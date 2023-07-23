const express = require("express");
const mongoose = require("mongoose");
const Bus = require("../models/bus.model");
const Outing = require("../models/outing.model");
const Dining = require("../models/dining.model");
const router = express.Router();
const axios = require("axios");
const PlanModel = require("../models/plan.model");
require("dotenv").config({ path: "../.env" });
const API_KEY = process.env.GOOGLE_MAPS_KEY;
const userAuth = require("../middleware/userAuth");

const BIT_LOCATION = {
  map: {
    lat: "23.41656964288303",
    lng: "85.44054332013442",
  },
};

// get google map distance and duration
function getDistance(origin, destination, mode) {
  return new Promise((resolve, reject) => {
    const url = `https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${origin.lat},${origin.lng}&destinations=${destination.lat},${destination.lng}&mode=${mode}&key=${API_KEY}`;

    axios
      .get(url)
      .then((response) => {
        const data = response.data;

        if (data.status === "OK") {
          const distance = data.rows[0].elements[0].distance.text;
          const durationInMinutes = Math.round(
            data.rows[0].elements[0].duration.value / 60
          );
          resolve({ distance, duration: Math.ceil(durationInMinutes / 5) * 5 });
        } else {
          reject(new Error("Invalid request"));
        }
      })
      .catch((error) => {
        reject(new Error("Failed to fetch distance"));
      });
  });
}

// compare time function
const compareArrivalTime = (busA, busB, time) => {
  const busATime = new Date(time);
  const busBTime = new Date(time);

  const newATime = busA.boarding.arrival_time;
  const newBTime = busB.boarding.arrival_time;

  busATime.setHours(newATime.split(":")[0]);
  busATime.setMinutes(newATime.split(":")[1]);
  busBTime.setHours(newBTime.split(":")[0]);
  busBTime.setMinutes(newBTime.split(":")[1]);

  const diff1 = Math.abs(busATime.getTime() - time.getTime());
  const diff2 = Math.abs(busBTime.getTime() - time.getTime());

  return diff1 < diff2;
};

//utility function
function getTimeDifference(time1, time2) {
  const [hours1, minutes1] = time1.split(":");
  const [hours2, minutes2] = time2.split(":");

  const date1 = new Date();
  date1.setHours(hours1, minutes1, 0, 0);

  const date2 = new Date();
  date2.setHours(hours2, minutes2, 0, 0);

  const differenceMs = date2 - date1;
  const minutesDifference = Math.floor(differenceMs / (1000 * 60));

  return minutesDifference;
}

// compare epoch with "hh:mm"
function isTimestampBefore(timestamp, timeString) {
  const currentTime = new Date();
  const [hours, minutes] = timeString.split(":");
  const comparisonTime = new Date(
    currentTime.getFullYear(),
    currentTime.getMonth(),
    currentTime.getDate(),
    hours,
    minutes
  );

  return timestamp < comparisonTime.getTime();
}

// Extract file id from drive link
function extractIdFromGoogleDriveLink(url) {
  const regex = /\/file\/d\/([a-zA-Z0-9_-]+)\/view/i;
  const match = url.match(regex);

  if (match && match[1]) {
    return match[1];
  } else {
    return null;
  }
}

// Add a new bus
router.post("/addBus", async (req, res) => {
  try {
    const bus = new Bus(req.body);
    const savedBus = await bus.save();

    res.status(200).json(savedBus);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "An error occurred while adding the bus." });
  }
});

// Add a new outing
router.post("/addOuting", async (req, res) => {
  const outingBody = req.body;
  try {
    const outing = new Outing(outingBody);
    outing.save();
    res.status(200).send({ status: "Successful", outing });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

// Add a new dining
router.post("/addDining", async (req, res) => {
  const diningBody = req.body;
  try {
    const dining = new Dining(diningBody);
    dining.save();
    res.status(200).send({ status: "Successful", dining });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

// Get Number of Dinings
router.get("/getDiningsLength", async (req, res) => {
  try {
    const dinings = await Dining.find({});
    res.status(200).send({ status: "Successfull", count: dinings.length });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

// Get number of Outings
router.get("/getOutingsLength", async (req, res) => {
  try {
    const outings = await Outing.find({});
    res.status(200).send({ status: "Successfull", count: outings.length });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

// Create a plan
router.post("/createPlan", async (req, res) => {
  try {
    const plan_start_time = req.body.plan_start_time;
    const requestData = req.body.components;

    // Calculating initial time
    const options = { weekday: "long", timeZone: "Asia/Kolkata" };
    const date = new Date(plan_start_time);
    const dayoftheweek = date
      .toLocaleDateString("en-IN", options)
      .toLowerCase();

    // details of all components of the plan
    const components = [];
    for (const item of requestData) {
      const { order, type, id } = item;
      let details = null;
      if (type === "Outing") {
        details = await Outing.findById(id);
      } else if (type === "Dining") {
        details = await Dining.findById(id);
      }

      if (!details.availability[dayoftheweek]) {
        throw {
          message: `${
            type === "Outing" ? details.place_name : details.hotel_name
          } is not available on ${dayoftheweek}s`,
          componentId: id,
        };
      }
      components.push({ id, order, type, details });
    }

    components.sort((a, b) => a.order - b.order);

    // All distance and duration
    const allDistancesandDurations = [];

    let currDistanceandDuration;
    let currDrivingDistanceandDuration;
    let currWalkingDistanceandDuration;
    let pointA;
    let pointB;

    pointA = BIT_LOCATION;
    pointB = components[0];

    currDrivingDistanceandDuration = await getDistance(
      pointA.map,
      pointB.details.map,
      "driving"
    );

    if (currDrivingDistanceandDuration.distance.includes("km")) {
      distanceValue = parseFloat(
        currDrivingDistanceandDuration.distance.replace(" km", "")
      );
    } else if (currDrivingDistanceandDuration.distance.includes("m")) {
      distanceValue =
        parseFloat(currDrivingDistanceandDuration.distance.replace(" m", "")) /
        1000;
    }

    currWalkingDistanceandDuration =
      distanceValue < 1
        ? await getDistance(pointA.map, pointB.details.map, "walking")
        : null;

    currDistanceandDuration = {
      boarding_point: "BIT Mesra",
      drop_point:
        pointB.type === "Outing"
          ? pointB.details.place_name
          : pointB.details.hotel_name,
      driving: currDrivingDistanceandDuration,
      walking: currWalkingDistanceandDuration,
    };

    allDistancesandDurations.push(currDistanceandDuration);

    for (let i = 0; i < components.length - 1; i++) {
      pointA = components[i];
      pointB = components[i + 1];

      currDrivingDistanceandDuration = await getDistance(
        pointA.details.map,
        pointB.details.map,
        "driving"
      );

      let distanceValue;

      if (currDrivingDistanceandDuration.distance.includes("km")) {
        distanceValue = parseFloat(
          currDrivingDistanceandDuration.distance.replace(" km", "")
        );
      } else if (currDrivingDistanceandDuration.distance.includes("m")) {
        distanceValue =
          parseFloat(
            currDrivingDistanceandDuration.distance.replace(" m", "")
          ) / 1000;
      }

      currWalkingDistanceandDuration =
        distanceValue < 1
          ? await getDistance(pointA.details.map, pointB.details.map, "walking")
          : null;

      currDistanceandDuration = {
        boarding_point:
          pointA.type === "Outing"
            ? pointA.details.place_name
            : pointA.details.hotel_name,
        drop_point:
          pointB.type === "Outing"
            ? pointB.details.place_name
            : pointB.details.hotel_name,
        driving: currDrivingDistanceandDuration,
        walking: currWalkingDistanceandDuration,
      };

      allDistancesandDurations.push(currDistanceandDuration);
    }

    pointA = components[components.length - 1];
    pointB = BIT_LOCATION;

    currDrivingDistanceandDuration = await getDistance(
      pointA.details.map,
      pointB.map,
      "driving"
    );

    if (currDrivingDistanceandDuration.distance.includes("km")) {
      distanceValue = parseFloat(
        currDrivingDistanceandDuration.distance.replace(" km", "")
      );
    } else if (currDrivingDistanceandDuration.distance.includes("m")) {
      distanceValue =
        parseFloat(currDrivingDistanceandDuration.distance.replace(" m", "")) /
        1000;
    }

    currWalkingDistanceandDuration =
      distanceValue < 1
        ? await getDistance(pointA.details.map, pointB.map, "walking")
        : null;

    currDistanceandDuration = {
      boarding_point:
        pointA.type === "Outing"
          ? pointA.details.place_name
          : pointA.details.hotel_name,
      drop_point: "BIT Mesra",

      driving: currDrivingDistanceandDuration,
      walking: currWalkingDistanceandDuration,
    };

    allDistancesandDurations.push(currDistanceandDuration);

    // Two Wheeler Travel
    let twoTravel = [];
    let time = new Date(date);
    let currTwoTravel;
    let totalDistance = 0;

    for (let i = 0; i < allDistancesandDurations.length; i++) {
      if (i != 0) {
        time.setTime(
          time.getTime() + components[i - 1].details.duration * 60 * 1000
        );

        if (!isTimestampBefore(time, components[i - 1].details.closing_time)) {
          throw {
            message: `${
              components[i - 1].type === "Outing"
                ? components[i - 1].details.place_name
                : components[i - 1].details.hotel_name
            } gets closed at ${components[i - 1].details.closing_time}`,
            componentId: components[i - 1].id,
          };
        }
      }

      currTwoTravel = {
        mode: "two wheeler",
        duration: allDistancesandDurations[i].driving.duration,
        distance: allDistancesandDurations[i].driving.distance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time.getTime(),
        boarding_time_formatted: new Date(time.getTime()).toLocaleTimeString(),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time.setTime(
          time.getTime() +
            allDistancesandDurations[i].driving.duration * 60 * 1000
        ),
        drop_time_formatted: new Date(time.getTime()).toLocaleTimeString(),
      };

      if (i !== allDistancesandDurations.length - 1) {
        if (isTimestampBefore(time, components[i].details.opening_time)) {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is not open before ${components[i].details.opening_time}`,
            componentId: components[i].id,
          };
        }
      }

      twoTravel.push(currTwoTravel);

      totalDistance += parseFloat(allDistancesandDurations[i].driving.distance);
    }

    const totalTime = Math.floor(
      (twoTravel[twoTravel.length - 1].drop_time - twoTravel[0].boarding_time) /
        (1000 * 60)
    );

    let price = 0;

    if (
      dayoftheweek === "monday" ||
      dayoftheweek === "tuesday" ||
      dayoftheweek === "wednesday" ||
      dayoftheweek === "thursday"
    ) {
      let petrol_cost = (totalDistance / 40) * 100;
      let hour_cost = (totalTime / 60) * 60;
      price = petrol_cost + hour_cost;
    } else if (dayoftheweek === "saturday" || dayoftheweek === "sunday") {
      let petrol_cost = (totalDistance / 40) * 100;
      let hour_cost = (totalTime / 60) * 70;
      price = petrol_cost + hour_cost;
    } else {
      let petrol_cost = (totalDistance / 30) * 100;
      let hour_cost = (totalTime / 60) * 70;
      price = petrol_cost + hour_cost;
    }

    const completeTwoWheeler = {
      route: twoTravel,
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: Math.round(price / 5) * 5,
    };

    // Four Wheeler Travel

    const completeFourWheeler = {
      route: twoTravel.map((travel) => {
        if (travel.mode === "two wheeler") {
          return { ...travel, mode: "four wheeler" };
        }
        return travel;
      }),
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: 1800,
    };

    //Bus Travel
    let busTravel = [];
    const start = components[0];

    time = new Date(date);

    // Finding all the buses in the route
    let startBus = await Bus.find({
      route_type: { $in: start.details.bus_route_type },
    }).then((result) =>
      result.filter(
        (obj) =>
          obj.going &&
          obj.route.some(
            (route) => route.name === start.details.bus_nodal_point
          )
      )
    );

    // Allocating boarding and drop points
    startBus = startBus.map((bus) => {
      const route = bus.route.find(
        (route) => route.name === start.details.bus_nodal_point
      );
      const bit_start = bus.route.filter((e) => e.name === "BIT Mesra")[0];

      return {
        student: bus.student,
        busId: bus._id,
        boarding: bit_start,
        drop: route,
        duration: Math.abs(
          getTimeDifference(bit_start.arrival_time, route.arrival_time)
        ),
      };
    });

    // Sorting based on closest time of boarding
    startBus.sort((busA, busB) =>
      compareArrivalTime(busA, busB, time) ? -1 : 1
    );

    // Check if the bus is +- 30 minutes from start time
    const nearestBusTime = new Date(time);
    nearestBusTime.setHours(startBus[0].boarding.arrival_time.split(":")[0]);
    nearestBusTime.setMinutes(startBus[0].boarding.arrival_time.split(":")[1]);

    let start_bus_found = true;
    let end_bus_found = true;

    if (Math.abs(nearestBusTime - time) / (1000 * 60) > 30)
      start_bus_found = false;

    let currBusTravel;

    if (startBus[0] && start_bus_found) {
      time = nearestBusTime;

      currBusTravel = {
        mode: "bus",
        distance: "Not Providing",
        duration: startBus[0].duration,
        boarding_point: startBus[0].boarding.name,
        boarding_time: time.getTime(),
        boarding_time_formatted: time.toLocaleTimeString(),
        drop_point: startBus[0].drop.name,
        drop_time: time.getTime() + startBus[0].duration * 60 * 1000,
        drop_time_formatted: new Date(
          time.getTime() + startBus[0].duration * 60 * 1000
        ).toLocaleTimeString(),
        price: startBus[0].student ? 0 : 40,
      };
      time = time.getTime() + startBus[0].duration * 60 * 1000;

      busTravel.push(currBusTravel);

      const start_walk_board = startBus[0].drop.map;
      const start_walk_drop = components[0].details.map;
      const res = await getDistance(
        start_walk_board,
        start_walk_drop,
        "walking"
      );

      currBusTravel = {
        mode: "walking",
        duration: res.duration,
        distance: res.distance,
        boarding_point: startBus[0].drop.name,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(),
        drop_point:
          components[0].type == "Outing"
            ? components[0].details.place_name
            : components[0].details.hotel_name,
        drop_time: time + res.duration * 60 * 1000,
        drop_time_formatted: new Date(
          time + res.duration * 60 * 1000
        ).toLocaleTimeString(),
        price: 0,
      };

      busTravel.push(currBusTravel);
      time = time + res.duration * 60 * 1000;
    } else {
      let startAuto = {
        ...completeTwoWheeler.route[0],
        mode: "auto",
        price:
          Math.round(
            parseFloat(allDistancesandDurations[0].driving.distance) * 2
          ) * 10,
      };

      busTravel.push(startAuto);
      time = time.getTime() + completeTwoWheeler.route[0].duration * 60 * 1000;
    }

    for (let i = 1; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        time = time + components[i - 1].details.duration * 60 * 1000;
      }

      if (i === allDistancesandDurations.length - 1) {
        break;
      }

      let selectiveDuration = allDistancesandDurations[i].walking
        ? allDistancesandDurations[i].walking.duration
        : allDistancesandDurations[i].driving.duration;

      let selectiveDistance = allDistancesandDurations[i].walking
        ? allDistancesandDurations[i].walking.distance
        : allDistancesandDurations[i].driving.distance;

      currBusTravel = {
        mode: allDistancesandDurations[i].walking ? "walking" : "auto",
        duration: selectiveDuration,
        distance: selectiveDistance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time + selectiveDuration * 60 * 1000,
        drop_time_formatted: new Date(
          time + selectiveDuration * 60 * 1000
        ).toLocaleTimeString(),
        price: allDistancesandDurations[i].walking
          ? 0
          : Math.round(parseFloat(selectiveDistance) * 2) * 10,
      };

      busTravel.push(currBusTravel);

      time = time + selectiveDuration * 60 * 1000;
      totalDistance += parseFloat(selectiveDuration);
    }

    const end = components[components.length - 1];
    const end_walk_board = end.details.map;
    let end_walk_drop = end.details.bus_nodal_point;
    let end_walk_drop_map;

    let endBus = await Bus.find({
      route_type: { $in: end.details.bus_route_type },
    }).then((result) =>
      result.filter(
        (obj) =>
          !obj.going &&
          obj.route.some((route) => route.name === end.details.bus_nodal_point)
      )
    );

    let time_before_walking = new Date(time).getTime();
    let currWalkToBus;
    if (endBus[0]) {
      for (const routeElement of endBus[0].route) {
        if (routeElement.name === end_walk_drop) {
          end_walk_drop_map = routeElement.map;
          break;
        }
      }

      const resDistance = await getDistance(
        end_walk_board,
        end_walk_drop_map,
        "walking"
      );

      currWalkToBus = {
        mode: "walking",
        duration: resDistance.duration,
        distance: resDistance.distance,
        boarding_point:
          end.type == "Outing"
            ? end.details.place_name
            : end.details.hotel_name,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(),
        drop_point: end_walk_drop,
        drop_time: time + resDistance.duration * 60 * 1000,
        drop_time_formatted: new Date(
          time + resDistance.duration * 60 * 1000
        ).toLocaleTimeString(),
        price: 0,
      };

      time = time + resDistance.duration * 60 * 1000;

      endBus = endBus.map((bus) => {
        const route = bus.route.find(
          (route) => route.name === end.details.bus_nodal_point
        );

        const bit_end = bus.route.filter((e) => e.name === "BIT Mesra")[0];

        return {
          student: bus.student,
          busId: bus._id,
          boarding: route,
          drop: bit_end,
          duration: Math.abs(
            getTimeDifference(bit_end.arrival_time, route.arrival_time)
          ),
        };
      });

      endBus.sort((busA, busB) =>
        compareArrivalTime(busA, busB, new Date(time))
      );
    } else {
      endBus = [null];
    }

    // checking is bus is available +30 minutes
    let nearestEndBusTime;
    if (endBus[0] != null) {
      nearestEndBusTime = new Date(time);
      nearestEndBusTime.setHours(endBus[0].boarding.arrival_time.split(":")[0]);
      nearestEndBusTime.setMinutes(
        endBus[0].boarding.arrival_time.split(":")[1]
      );

      if (
        (nearestEndBusTime - time) / (1000 * 60) < 0 ||
        (nearestEndBusTime - time) / (1000 * 60) > 30
      )
        end_bus_found = false;
    } else {
      end_bus_found = false;
    }

    if (end_bus_found) {
      currBusTravel = {
        mode: "bus",
        duration: endBus[0].duration,
        distance: "Not Providing",
        boarding_point: endBus[0].boarding.name,
        boarding_time: nearestBusTime,
        boarding_time_formatted: new Date(nearestBusTime).toLocaleTimeString(),
        drop_point: endBus[0].drop.name,
        drop_time: nearestBusTime + endBus[0].duration * 1000 * 60,
        drop_time_formatted: new Date(
          nearestBusTime + endBus[0].duration * 1000 * 60
        ).toLocaleTimeString(),
        price: endBus[0].student ? 0 : 40,
      };
      busTravel.push(currWalkToBus);
      busTravel.push(currBusTravel);
    } else {
      currBusTravel = {
        mode: "auto",
        duration:
          allDistancesandDurations[allDistancesandDurations.length - 1].driving
            .duration,
        distance:
          allDistancesandDurations[allDistancesandDurations.length - 1].driving
            .distance,
        boarding_point:
          allDistancesandDurations[allDistancesandDurations.length - 1]
            .boarding_point,
        boarding_time: time_before_walking,
        boarding_time_formatted: new Date(
          time_before_walking
        ).toLocaleTimeString(),
        drop_point: "BIT Mesra",
        drop_time:
          time_before_walking +
          allDistancesandDurations[allDistancesandDurations.length - 1].driving
            .duration *
            60 *
            1000,
        drop_time_formatted: new Date(
          time_before_walking +
            allDistancesandDurations[allDistancesandDurations.length - 1]
              .driving.duration *
              60 *
              1000
        ).toLocaleTimeString(),
        price:
          Math.round(
            parseFloat(
              allDistancesandDurations[allDistancesandDurations.length - 1]
                .driving.distance
            ) * 2
          ) * 10,
      };
      busTravel.push(currBusTravel);
    }

    price = 0;
    let completeBus;
    if (!start_bus_found && !end_bus_found) {
      completeBus = null;
    } else {
      for (let i = 0; i < busTravel.length; i++) {
        price += busTravel[i].price;
      }

      completeBus = {
        route: busTravel,
        distance: "Not Providing",
        duration: Math.round(
          (busTravel[busTravel.length - 1].drop_time -
            busTravel[0].boarding_time) /
            (1000 * 60)
        ),
        price,
      };
    }

    // Auto Travel
    let autoTravel = [];
    let currAutoTravel;
    time = new Date(date).getTime();

    totalDistance = 0;
    for (let i = 0; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        time = time + components[i - 1].details.duration * 60 * 1000;
      }

      let selectiveDuration = allDistancesandDurations[i].walking
        ? allDistancesandDurations[i].walking.duration
        : allDistancesandDurations[i].driving.duration;

      let selectiveDistance = allDistancesandDurations[i].walking
        ? allDistancesandDurations[i].walking.distance
        : allDistancesandDurations[i].driving.distance;

      currAutoTravel = {
        mode: allDistancesandDurations[i].walking ? "walking" : "auto",
        duration: selectiveDuration,
        distance: selectiveDistance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time + selectiveDuration * 1000 * 60,
        drop_time_formatted: new Date(
          time + selectiveDuration * 1000 * 60
        ).toLocaleTimeString(),
        price: allDistancesandDurations[i].walking
          ? 0
          : Math.round(parseFloat(selectiveDistance) * 2) * 10,
      };

      autoTravel.push(currAutoTravel);

      time = time + selectiveDuration * 60 * 1000;

      totalDistance += parseFloat(selectiveDistance);
    }

    price = 0;

    for (let i = 0; i < autoTravel.length; i++) {
      price += autoTravel[i].price;
    }

    const completeAuto = {
      route: autoTravel,
      distance: totalDistance,
      duration: Math.round(
        (autoTravel[autoTravel.length - 1].drop_time -
          autoTravel[0].boarding_time) /
          (1000 * 60)
      ),
      price,
    };

    // Overall Availability
    const availability = {
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      saturday: true,
    };

    components.forEach((component) => {
      Object.keys(availability).forEach((day) => {
        availability[day] =
          availability[day] && component.details.availability[day];
      });
    });

    console.log(components);

    res.status(200).json({
      status: "Successful",
      allTravel: {
        bus: completeBus,
        auto: completeAuto,
        two_wheeler: completeTwoWheeler,
        four_wheeler: completeFourWheeler,
      },
      availability,
    });
  } catch (error) {
    if (error.componentId)
      res.status(500).json({
        status: "Failed",
        message: error.message,
        componentId: error.componentId,
      });
    else {
      console.log(error);
      res.status(500).json({ status: "Failed", message: error.message });
    }
    console.log(error);
  }
});

router.post("/savePlan", async (req, res) => {
  const { plan_start_time, components, tile_content } = req.body;
  components.sort((a, b) => a.component_id.localeCompare(b.component_id));
  let idString = "";
  components.map((e) => {
    idString += e.component_id;
  });

  console.log(idString);

  try {
    const existingPlan = await PlanModel.findOne({ plan_id: idString });

    if (!existingPlan) {
      const plan = new PlanModel({
        plan_start_time,
        components,
        plan_id: idString,
        tile_content,
      });
      await plan.save();
      res.status(200).send({ status: "Successful", plan });
    } else {
      res
        .status(200)
        .send({ status: "Failed", message: "Already made", existingPlan });
    }
  } catch (error) {
    console.log(error);
    res.status(500).send({ status: "Failed", message: error });
  }
});

router.get("/getAllPlans", userAuth, async (req, res) => {
  try {
    const allPlans = await PlanModel.find({});
    const userPreferences = req.user.preferences;

    const completedAllPlans = [];

    for (let i = 0; i < allPlans.length; i++) {
      const populatedComponents = [];
      const tags = new Set();
      const images = [];
      let availability = {
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        saturday: true,
      };
      const plan_start_time = allPlans[i].plan_start_time;
      let price = 0;
      const tile_content = allPlans[i].tile_content;
      const plan_preferences = {
        Dine: {
          Fine_Dining: 0,
          Decent_Dining: 0,
          Dhabas: 0,
          Cafes: 0,
          Streetfood: 0,
        },
        Outing: {
          Hills: 0,
          Lakes: 0,
          Dams_Waterfalls: 0,
          Malls: 0,
          Movie_Halls: 0,
          Parks: 0,
          Clubbing: 0,
          Night_Out: 0,
          Shopping: 0,
          Places_Of_Worship: 0,
          Museum: 0,
        },
      };

      for (const component of allPlans[i].components) {
        let curr_component;

        if (component.type === "Outing") {
          curr_component = await Outing.findOne({
            _id: component.component_id,
          });
        } else if (component.type === "Dining") {
          curr_component = await Dining.findOne({
            _id: component.component_id,
          });
        }
        const componentWithHighlight = {
          is_highlight: component.is_highlight,
          details: curr_component,
        };

        populatedComponents.push(componentWithHighlight);

        tags.add(curr_component.tags[0]);

        images.push({
          img_link: extractIdFromGoogleDriveLink(curr_component.img),
          img_name:
            curr_component.type === "Outing"
              ? curr_component.place_name
              : curr_component.hotel_name,
          order: component.order,
        });

        availability = {
          sunday: availability.sunday && curr_component.availability.sunday,
          monday: availability.monday && curr_component.availability.monday,
          tuesday: availability.tuesday && curr_component.availability.tuesday,
          wednesday:
            availability.wednesday && curr_component.availability.wednesday,
          thursday:
            availability.thursday && curr_component.availability.thursday,
          friday: availability.friday && curr_component.availability.friday,
          saturday:
            availability.saturday && curr_component.availability.saturday,
        };

        price += curr_component.price_per_head;

        plan_preferences[component.type === "Outing" ? "Outing" : "Dine"][
          curr_component.tags[0]
        ]++;
      }

      const likeness =
        (plan_preferences.Dine.Fine_Dining * userPreferences.Dine.Fine_Dining +
          plan_preferences.Dine.Decent_Dining *
            userPreferences.Dine.Decent_Dining +
          plan_preferences.Dine.Dhabas * userPreferences.Dine.Dhabas +
          plan_preferences.Dine.Cafes * userPreferences.Dine.Cafes +
          plan_preferences.Dine.Streetfood * userPreferences.Dine.Streetfood +
          plan_preferences.Outing.Hills * userPreferences.Outing.Hills +
          plan_preferences.Outing.Lakes * userPreferences.Outing.Lakes +
          plan_preferences.Outing.Dams_Waterfalls *
            userPreferences.Outing.Dams_Waterfalls +
          plan_preferences.Outing.Malls * userPreferences.Outing.Malls +
          plan_preferences.Outing.Movie_Halls *
            userPreferences.Outing.Movie_Halls +
          plan_preferences.Outing.Parks * userPreferences.Outing.Parks +
          plan_preferences.Outing.Clubbing * userPreferences.Outing.Clubbing +
          plan_preferences.Outing.Shopping * userPreferences.Outing.Shopping +
          plan_preferences.Outing.Night_Out * userPreferences.Outing.Night_Out +
          plan_preferences.Outing.Places_Of_Worship *
            userPreferences.Outing.Places_Of_Worship +
          plan_preferences.Outing.Museum * userPreferences.Outing.Museum) /
        16;

      const uniqueTags = Array.from(tags);

      completedAllPlans.push({
        id: allPlans[i].plan_id,
        tags: uniqueTags,
        images: images.sort((a, b) => a.order - b.order),
        availability,
        plan_start_time,
        price,
        tile_content,
        likeness: parseFloat(likeness),
        components: populatedComponents,
      });
    }

    completedAllPlans.sort((a, b) => b.likeness - a.likeness);

    res.status(200).send({ status: "Successful", completedAllPlans });
  } catch (error) {
    console.log(error);
    res.status(200).send({ status: "Failed", message: error.message });
  }
});

router.get("/getPlanDetails/:id", userAuth, async (req, res) => {
  const plan_id = req.params.id;
  try {
    const plan = await PlanModel.findOne({
      plan_id,
    });

    const populatedComponents = [];
    const tags = new Set();
    const images = [];

    let availability = {
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      saturday: true,
    };
    const plan_start_time = plan.plan_start_time;
    let price = 0;
    const tile_content = plan.tile_content;

    for (const component of plan.components) {
      let curr_component;

      if (component.type === "Outing") {
        curr_component = await Outing.findOne({
          _id: component.component_id,
        });
      } else if (component.type === "Dining") {
        curr_component = await Dining.findOne({
          _id: component.component_id,
        });
      }

      const componentWithHighlight = {
        is_highlight: component.is_highlight,
        details: curr_component,
      };

      populatedComponents.push(componentWithHighlight);
      tags.add(curr_component.tags[0]);

      images.push({
        img_link: extractIdFromGoogleDriveLink(curr_component.img),
        img_name:
          curr_component.type === "Outing"
            ? curr_component.place_name
            : curr_component.hotel_name,
        order: component.order,
      });

      availability = {
        sunday: availability.sunday && curr_component.availability.sunday,
        monday: availability.monday && curr_component.availability.monday,
        tuesday: availability.tuesday && curr_component.availability.tuesday,
        wednesday:
          availability.wednesday && curr_component.availability.wednesday,
        thursday: availability.thursday && curr_component.availability.thursday,
        friday: availability.friday && curr_component.availability.friday,
        saturday: availability.saturday && curr_component.availability.saturday,
      };

      price += curr_component.price_per_head;
    }

    const uniqueTags = Array.from(tags);

    const planDetails = {
      id: plan_id,
      tags: uniqueTags,
      images: images.sort((a, b) => a.order - b.order),
      availability,
      plan_start_time,
      price,
      tile_content,
      components: populatedComponents,
    };

    res.status(200).send({ status: "Successful", planDetails });
  } catch (error) {
    console.log(error);
    res.status(200).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;