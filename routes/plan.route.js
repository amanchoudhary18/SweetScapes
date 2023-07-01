const express = require("express");
const mongoose = require("mongoose");
const Bus = require("../models/bus.model");
const Outing = require("../models/outing.model");
const Dining = require("../models/dining.model");
const router = express.Router();
const axios = require("axios");
require("dotenv").config({ path: "../.env" });
const API_KEY = process.env.GOOGLE_MAPS_KEY;

const BIT_LOCATION = {
  map: {
    lat: "23.4152236",
    lng: "85.4212082",
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
function compareArrivalTime(busA, busB, time) {
  const timeDiffA = Math.abs(
    getTimeDifference(busA.boarding.arrival_time, time)
  );
  const timeDiffB = Math.abs(
    getTimeDifference(busB.boarding.arrival_time, time)
  );

  return timeDiffA - timeDiffB;
}

// round time to next
function roundTimeToNext(time, interval) {
  const [hours, minutes] = time.split(":");
  const parsedHours = parseInt(hours, 10);
  const parsedMinutes = parseInt(minutes, 10);

  let roundedMinutes;
  if (interval === 5) {
    roundedMinutes = Math.ceil(parsedMinutes / 5) * 5;
  } else if (interval === 10) {
    roundedMinutes = Math.ceil(parsedMinutes / 10) * 10;
  } else {
    throw new Error("Invalid interval. Please provide either 5 or 10.");
  }

  let roundedHours = parsedHours;
  if (roundedMinutes === 60) {
    roundedHours += 1;
    roundedMinutes = 0;
  }

  return `${String(roundedHours).padStart(2, "0")}:${String(
    roundedMinutes
  ).padStart(2, "0")}`;
}

// get time difference in minutes
function getMinutesBetween(startTime, endTime) {
  const [startHours, startMinutes] = startTime.split(":");
  const [endHours, endMinutes] = endTime.split(":");
  const totalStartMinutes =
    parseInt(startHours, 10) * 60 + parseInt(startMinutes, 10);
  const totalEndMinutes =
    parseInt(endHours, 10) * 60 + parseInt(endMinutes, 10);
  return totalEndMinutes - totalStartMinutes;
}

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

// Add duration to time
function addDurationToTime(time, durationInMinutes) {
  const [hours, minutes] = time.split(":").map(Number);
  const totalMinutes = hours * 60 + minutes + durationInMinutes;
  const newHours = Math.floor(totalMinutes / 60);
  const newMinutes = totalMinutes % 60;
  const newTime = `${String(newHours).padStart(2, "0")}:${String(
    newMinutes
  ).padStart(2, "0")}`;
  return newTime;
}

// Epoch to time
function epochToTime(epoch) {
  const milliseconds = epoch * 1000;
  const date = new Date(milliseconds);

  const hours = ("0" + date.getHours()).slice(-2);
  const minutes = ("0" + date.getMinutes()).slice(-2);

  const time = hours + ":" + minutes;
  return time;
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

router.post("/createPlan", async (req, res) => {
  try {
    const plan_start_time = req.body.plan_start_time;
    const requestData = req.body.components;

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
    let time = plan_start_time;
    let currTwoTravel;
    let totalDistance = 0;

    for (let i = 0; i < allDistancesandDurations.length; i++) {
      if (i != 0) {
        time += components[i - 1].details.duration * 60;

        if (
          getMinutesBetween(
            components[i - 1].details.closing_time,
            epochToTime(time)
          ) > 0
        ) {
          throw {
            message: `${
              components[i - 1].type === "Outing"
                ? components[i - 1].details.place_name
                : components[i - 1].details.hotel_name
            } is closed`,
            componentId: components[i - 1].id,
          };
        }
      }

      currTwoTravel = {
        duration: allDistancesandDurations[i].driving.duration,
        distance: allDistancesandDurations[i].driving.distance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: epochToTime(time),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: epochToTime(
          time + allDistancesandDurations[i].driving.duration * 60
        ),
      };

      if (i !== allDistancesandDurations.length - 1) {
        if (
          getMinutesBetween(
            components[i].details.opening_time,
            epochToTime(time)
          ) < 0
        ) {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is not open`,
            componentId: components[i].id,
          };
        }
      }

      twoTravel.push(currTwoTravel);

      time = time + allDistancesandDurations[i].driving.duration * 60;

      totalDistance += parseFloat(allDistancesandDurations[i].driving.distance);
    }

    let totalTime = Math.abs(
      getMinutesBetween(
        twoTravel[0].boarding_time,
        twoTravel[twoTravel.length - 1].drop_time
      )
    );

    const price_distance = (totalDistance / 40) * 100;
    const price_duration = (totalTime / 60) * 100;

    const completeTwoWheeler = {
      mode: "two_wheeler",
      route: twoTravel,
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price:
        price_distance > price_duration
          ? parseInt(price_distance)
          : parseInt(price_duration),
    };

    // Four Wheeler Travel
    const completeFourWheeler = {
      mode: "four_wheeler",
      route: twoTravel,
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price:
        price_distance > price_duration
          ? parseInt(price_distance)
          : parseInt(price_duration),
    };

    //Bus Travel
    let busTravel = [];
    const start = components[0];

    time = plan_start_time;

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

    startBus.sort((busA, busB) =>
      compareArrivalTime(busA, busB, epochToTime(time))
    );

    let currBusTravel;

    let start_bus_not_found = false;
    let end_bus_not_found = false;

    if (
      startBus[0] &&
      Math.abs(
        getMinutesBetween(startBus[0].boarding.arrival_time, epochToTime(time))
      ) <= 60
    ) {
      time = startBus[0].boarding.arrival_time;
      currBusTravel = {
        mode: "bus",
        distance: "Not Providing",
        duration: startBus[0].duration,
        boarding_point: startBus[0].boarding.name,
        boarding_time: time,
        drop_point: startBus[0].drop.name,
        drop_time: addDurationToTime(time, startBus[0].duration),
        price: startBus[0].student ? 0 : 40,
      };
      busTravel.push(currBusTravel);
      time = addDurationToTime(time, startBus[0].duration);
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
        drop_point:
          components[0].type == "Outing"
            ? components[0].details.place_name
            : components[0].details.hotel_name,
        drop_time: addDurationToTime(time, res.duration),
        price: 0,
      };

      busTravel.push(currBusTravel);
      time = addDurationToTime(time, res.duration);
    } else {
      start_bus_not_found = true;
      let startAuto = completeTwoWheeler.route[0];
      startAuto.mode = "auto";
      busTravel.push(startAuto);
      time += completeTwoWheeler.route[0].duration * 60;
    }

    if (time.toString().length > 5) {
      time = epochToTime(time);
    }

    for (let i = 1; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        time = addDurationToTime(time, components[i - 1].details.duration);
        time = roundTimeToNext(time, 5);
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
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: addDurationToTime(time, selectiveDuration),
      };

      busTravel.push(currBusTravel);

      time = addDurationToTime(time, selectiveDuration);
      time = roundTimeToNext(time, 5);
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

    let time_before_walking = time;
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
        drop_point: end_walk_drop,
        drop_time: addDurationToTime(time, resDistance.duration),
        price: 0,
      };

      time = addDurationToTime(time, resDistance.duration);
      time = roundTimeToNext(time, 5);

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

      endBus.sort((busA, busB) => compareArrivalTime(busA, busB, time));
    } else {
      endBus = [null];
    }

    if (
      endBus[0] &&
      getMinutesBetween(time, endBus[0].boarding.arrival_time) >= 0 &&
      getMinutesBetween(time, endBus[0].boarding.arrival_time) <= 30
    ) {
      currBusTravel = {
        mode: "bus",
        duration: endBus[0].duration,
        distance: "Not Providing",
        boarding_point: endBus[0].boarding.name,
        boarding_time: endBus[0].boarding.arrival_time,
        drop_point: endBus[0].drop.name,
        drop_time: endBus[0].drop.arrival_time,
        price: endBus[0].student ? 0 : 40,
      };
      busTravel.push(currWalkToBus);
      busTravel.push(currBusTravel);
    } else {
      end_bus_not_found = true;
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
        drop_point: "BIT Mesra",
        drop_time: addDurationToTime(
          time_before_walking,
          allDistancesandDurations[allDistancesandDurations.length - 1].driving
            .duration
        ),
      };
      busTravel.push(currBusTravel);
    }

    // Auto Travel
    let autoTravel = [];
    let currAutoTravel;
    time = plan_start_time;
    for (let i = 0; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        time = time + components[i - 1].details.duration * 60;
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
        boarding_time: epochToTime(time),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: epochToTime(time + selectiveDuration * 60),
      };

      autoTravel.push(currAutoTravel);

      time = time + selectiveDuration * 60;

      totalDistance += parseFloat(selectiveDuration);
    }

    if (start_bus_not_found && end_bus_not_found) {
      busTravel = null;
    }

    res.status(200).json({
      status: "Successful",
      allTravel: {
        bus: busTravel,
        auto: autoTravel,
        two_wheeler: completeTwoWheeler,
        four_wheeler: completeFourWheeler,
      },
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
  }
});

module.exports = router;
