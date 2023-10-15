const express = require("express");
const Bus = require("../models/bus.model");
const Outing = require("../models/outing.model");
const Dining = require("../models/dining.model");
const axios = require("axios");
const PlanModel = require("../models/plan.model");
require("dotenv").config({ path: "../.env" });
const API_KEY = process.env.GOOGLE_MAPS_KEY;
const moment = require("moment-timezone");
const CreatedPlanModel = require("../models/created_plan.model");
const User = require("../models/user.model");
const NodeCache = require("node-cache");
const cache = new NodeCache({ stdTTL: 300 });

const BIT_LOCATION = {
  map: {
    lat: "23.41656964288303",
    lng: "85.44054332013442",
  },
};

// get google map distance and duration
function getGoogleDistance(origin, destination, mode) {
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

// 16.4 km 35
// 1.8 km 10
// 1.0 km 5
// 15.5 km 40
// 2.5 km 35

// 15.5 km 45
// 1.9 km 10
// 1.2 km 5
// 17.6 km 55
// 2.8 km 35

// Open Street Map
function getOpenDistance(origin, destination, mode) {
  const modeMapping = {
    driving: "cycling-electric",
    walking: "foot-walking",
  };

  const openRouteApiKey =
    "5b3ce3597851110001cf6248dcae9403f22e404fac54f97b25d258b5";
  const baseUrl = "https://api.openrouteservice.org/v2/directions";

  return new Promise((resolve, reject) => {
    const url = `${baseUrl}/${modeMapping[mode]}?api_key=${openRouteApiKey}&start=${origin.lng},${origin.lat}&end=${destination.lng},${destination.lat}`;

    axios
      .get(url)
      .then((response) => {
        const data = response.data;

        if (
          response.status === 200 &&
          data.type === "FeatureCollection" &&
          data.features.length > 0
        ) {
          const route = data.features[0];
          const distanceInMeters = route.properties.segments[0].distance;
          const durationInSeconds = route.properties.segments[0].duration;

          const distanceInKm = distanceInMeters / 1000;
          const roundedDistance = distanceInKm.toFixed(1);
          const estimatedDurationInMinutes =
            Math.ceil(durationInSeconds / 60 / 5) * 5; // Convert and round to the nearest 5-minute interval

          resolve({
            distance: `${roundedDistance} km`,
            duration: estimatedDurationInMinutes,
          });
        } else {
          reject(new Error("Invalid request"));
        }
      })
      .catch((error) => {
        console.error(error.message);
        reject(new Error("Failed to fetch distance"));
      });
  });
}

// // Example usage
// const origin = { lat: 37.7749, lng: -122.4194 };
// const destination = { lat: 34.0522, lng: -118.2437 };
// const mode = "driving-car"; // You can use 'foot-walking', 'cycling-regular', 'driving-car', etc.

// getGoogleDistance(origin, destination, mode, apiKey)
//   .then((result) => {
//     console.log(result);
//   })
//   .catch((error) => {
//     console.error(error);
//   });

// compare time function

const compareArrivalTime = (busA, busB, time) => {
  const istTimezone = "Asia/Kolkata";

  const busATime = moment.tz(time, istTimezone);
  const busBTime = moment.tz(time, istTimezone);

  const newATime = busA.boarding.arrival_time;
  const newBTime = busB.boarding.arrival_time;

  busATime.hours(newATime.split(":")[0]);
  busATime.minutes(newATime.split(":")[1]);
  busBTime.hours(newBTime.split(":")[0]);
  busBTime.minutes(newBTime.split(":")[1]);

  const diff1 = Math.abs(busATime.valueOf() - time);
  const diff2 = Math.abs(busBTime.valueOf() - time);

  return diff1 < diff2;
};

const compareReturnArrivalTime = (busA, busB, time) => {
  const istTimezone = "Asia/Kolkata";

  const busATime = moment.tz(busA.boarding.arrival_time, "HH:mm", istTimezone);
  const busBTime = moment.tz(busB.boarding.arrival_time, "HH:mm", istTimezone);

  const currentTime = moment(time);

  // Set the date of busATime and busBTime to match the date of currentTime
  busATime.set({
    year: currentTime.year(),
    month: currentTime.month(),
    date: currentTime.date(),
  });
  busBTime.set({
    year: currentTime.year(),
    month: currentTime.month(),
    date: currentTime.date(),
  });

  // Calculate and store the difference in minutes in the bus objects
  busA.diff = Math.abs(busATime.diff(currentTime, "minutes"));
  busB.diff = Math.abs(busBTime.diff(currentTime, "minutes"));

  return busA.diff < busB.diff;
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

function isTimestampBefore(epochTimeMs, timestring) {
  const istTimezone = "Asia/Kolkata";
  const istDatetime = moment.tz(epochTimeMs, istTimezone);
  const [providedHours, providedMinutes] = timestring.split(":").map(Number);

  const currentISTTime = moment.tz(istTimezone);

  const epochDate = new Date(epochTimeMs);

  const providedDatetime = currentISTTime.clone().set({
    year: epochDate.getFullYear(),
    month: epochDate.getMonth(),
    date: epochDate.getDate(),
    hours: providedHours,
    minutes: providedMinutes,
    seconds: 0,
    milliseconds: 0,
  });

  return istDatetime.isBefore(providedDatetime);
}

// Helper function to find the closest opening time in the time_slots array

function findClosestTimeSlots(time, timeSlots) {
  const istTimezone = "Asia/Kolkata";
  const istDatetime = moment.tz(time, istTimezone);

  for (const timeSlot of timeSlots) {
    const [openingProvidedHours, openingProvidedMinutes] = timeSlot.opening_time
      .split(":")
      .map(Number);
    const [closingProvidedHours, closingProvidedMinutes] = timeSlot.closing_time
      .split(":")
      .map(Number);

    const currentISTTime = moment.tz(istTimezone);
    const epochDate = new Date(time);

    let openingProvidedDatetime = currentISTTime.clone().set({
      year: epochDate.getFullYear(),
      month: epochDate.getMonth(),
      date: epochDate.getDate(),
      hours: openingProvidedHours,
      minutes: openingProvidedMinutes,
      seconds: 0,
      milliseconds: 0,
    });

    openingProvidedDatetime = openingProvidedDatetime.subtract(15, "minutes");

    const closingProvidedDatetime = currentISTTime.clone().set({
      year: epochDate.getFullYear(),
      month: epochDate.getMonth(),
      date: epochDate.getDate(),
      hours: closingProvidedHours,
      minutes: closingProvidedMinutes,
      seconds: 0,
      milliseconds: 0,
    });

    if (
      istDatetime.isBetween(openingProvidedDatetime, closingProvidedDatetime)
    ) {
      return {
        opening_time: timeSlot.opening_time,
        closing_time: timeSlot.closing_time,
        isWithin: true,
      };
    }
  }

  return {
    opening_time: null,
    closing_time: null,
    isWithin: false,
  };
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

const getTransport = async (req, res, getDistance) => {
  try {
    const plan_start_time = req.body.plan_start_time;
    const requestData = req.body.components;

    // Calculating initial time
    let options = { weekday: "long", timeZone: "Asia/Kolkata" };
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

    currWalkingDistanceandDuration = await getDistance(
      pointA.map,
      pointB.details.map,
      "walking"
    );

    if (currWalkingDistanceandDuration.distance.includes("km")) {
      distanceValue = parseFloat(
        currWalkingDistanceandDuration.distance.replace(" km", "")
      );
    } else if (currWalkingDistanceandDuration.distance.includes("m")) {
      distanceValue =
        parseFloat(currWalkingDistanceandDuration.distance.replace(" m", "")) /
        1000;
    }

    currDrivingDistanceandDuration = await getDistance(
      pointA.map,
      pointB.details.map,
      "driving"
    );

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

      currWalkingDistanceandDuration = await getDistance(
        pointA.details.map,
        pointB.details.map,
        "walking"
      );

      let distanceValue;

      if (currWalkingDistanceandDuration.distance.includes("km")) {
        distanceValue = parseFloat(
          currWalkingDistanceandDuration.distance.replace(" km", "")
        );
      } else if (currWalkingDistanceandDuration.distance.includes("m")) {
        distanceValue =
          parseFloat(
            currWalkingDistanceandDuration.distance.replace(" m", "")
          ) / 1000;
      }

      currDrivingDistanceandDuration = await getDistance(
        pointA.details.map,
        pointB.details.map,
        "driving"
      );

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

    currWalkingDistanceandDuration = await getDistance(
      pointA.details.map,
      pointB.map,
      "walking"
    );

    if (currWalkingDistanceandDuration.distance.includes("km")) {
      distanceValue = parseFloat(
        currWalkingDistanceandDuration.distance.replace(" km", "")
      );
    } else if (currWalkingDistanceandDuration.distance.includes("m")) {
      distanceValue =
        parseFloat(currWalkingDistanceandDuration.distance.replace(" m", "")) /
        1000;
    }

    currDrivingDistanceandDuration = await getDistance(
      pointA.details.map,
      pointB.map,
      "driving"
    );

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
    options = { timeZone: "Asia/Kolkata" };
    // Two Wheeler Travel
    let twoTravel = [];
    let time = new Date(date);
    let currTwoTravel;
    let totalDistance = 0;

    let closestOpeningTime;

    for (let i = 0; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        // time.setTime(
        //   time.getTime() + components[i - 1].details.duration * 60 * 1000
        // );

        // const istTimezone = "Asia/Kolkata";
        // const istDatetime = moment.tz(time, istTimezone);
        // const [closingProvidedHours, closingProvidedMinutes] =
        //   closestOpeningTime.closing_time.split(":").map(Number);

        // const currentISTTime = moment.tz(istTimezone);
        // const epochDate = new Date(time);

        // const closingProvidedDatetime = currentISTTime.clone().set({
        //   year: epochDate.getFullYear(),
        //   month: epochDate.getMonth(),
        //   date: epochDate.getDate(),
        //   hours: closingProvidedHours,
        //   minutes: closingProvidedMinutes,
        //   seconds: 0,
        //   milliseconds: 0,
        // });

        // if (closingProvidedDatetime.isBefore(istDatetime)) {
        //   time = closingProvidedDatetime.toDate();
        // }

        const istTimezone = "Asia/Kolkata";
        const reachingIstDatetime = moment.tz(time, istTimezone);

        const [closingProvidedHours, closingProvidedMinutes] =
          closestOpeningTime.closing_time.split(":").map(Number);

        const currentISTTime = moment.tz(istTimezone);
        const epochDate = new Date(time);

        const closingProvidedDatetime = currentISTTime.clone().set({
          year: epochDate.getFullYear(),
          month: epochDate.getMonth(),
          date: epochDate.getDate(),
          hours: closingProvidedHours,
          minutes: closingProvidedMinutes,
          seconds: 0,
          milliseconds: 0,
        });

        const timeLeft = closingProvidedDatetime.diff(
          reachingIstDatetime,
          "minutes"
        );

        const placeDuration = components[i - 1].details.duration;
        if (timeLeft >= placeDuration) {
          time.setTime(
            time.getTime() + components[i - 1].details.duration * 60 * 1000
          );
        } else if (placeDuration >= 120 && timeLeft >= 0.5 * placeDuration) {
          time = closingProvidedDatetime.toDate();
        } else if (timeLeft >= 0.75 * placeDuration) {
          time = closingProvidedDatetime.toDate();
        } else {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is closed at this time`,
            componentId: components[i].id,
          };
        }
      }

      currTwoTravel = {
        mode: "scooty",
        duration: allDistancesandDurations[i].driving.duration,
        distance: allDistancesandDurations[i].driving.distance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time.getTime(),
        boarding_time_formatted: new Date(time.getTime()).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time.setTime(
          time.getTime() +
            allDistancesandDurations[i].driving.duration * 60 * 1000
        ),
        drop_time_formatted: new Date(time.getTime()).toLocaleTimeString(
          "en-IN",
          options
        ),
        price: 0,
      };

      if (i !== allDistancesandDurations.length - 1) {
        closestOpeningTime = findClosestTimeSlots(
          time,
          components[i].details.time_slots
        );

        if (!closestOpeningTime.isWithin) {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is closed at this time`,
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
    // scooty
    let scooty_price = 0;

    if (
      dayoftheweek === "monday" ||
      dayoftheweek === "tuesday" ||
      dayoftheweek === "wednesday" ||
      dayoftheweek === "thursday"
    ) {
      let petrol_cost = (totalDistance / 40) * 100;
      let hour_cost = (totalTime / 60) * 60;
      scooty_price = petrol_cost + hour_cost;
    } else {
      let petrol_cost = (totalDistance / 40) * 100;
      let hour_cost = (totalTime / 60) * 70;
      scooty_price = petrol_cost + hour_cost;
    }

    let bike_price = 0;
    let odometer_cost = totalDistance * 10;

    let bike_time_calculator =
      totalTime / 60 - Math.floor(totalTime / 60) <= 0.25
        ? Math.floor(totalTime / 60)
        : Math.ceil(totalTime / 60);

    let rent_petrol_cost =
      Math.ceil(bike_time_calculator) * 90 + (totalDistance / 40) * 100;
    bike_price = Math.max(rent_petrol_cost, odometer_cost);

    const completeScooty = {
      route: twoTravel,
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: Math.round(scooty_price / 5) * 5,
    };

    const completeBike = {
      route: twoTravel.map((e) => ({ ...e, mode: "bike" })),
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: Math.round(bike_price / 5) * 5,
    };

    const completeMidSize = {
      route: twoTravel.map((e) => ({ ...e, mode: "mid_size" })),
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: 1800 + Math.ceil(((totalDistance / 16) * 94) / 10) * 10,
    };

    const completeSuv = {
      route: twoTravel.map((e) => ({ ...e, mode: "suv" })),
      duration: totalTime,
      distance: parseFloat(totalDistance.toFixed(2)),
      price: 6500 + Math.ceil(((totalDistance / 10) * 94) / 10) * 10,
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
      const bit_start = bus.route.filter((e) => e.name === "PMC, BIT Mesra")[0];

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

    let nearestBusTime;
    let start_bus_found = true;
    let end_bus_found = true;
    const timeZone = "Asia/Kolkata";
    if (startBus.length != 0) {
      startBus.sort((busA, busB) =>
        compareArrivalTime(busA, busB, time) ? -1 : 1
      );

      nearestBusTime = moment.tz(
        startBus[0].boarding.arrival_time,
        "HH:mm",
        timeZone
      );

      // Convert time to IST Date object
      const timeInIST = moment(time).tz(timeZone).toDate();

      // Set the date of nearestBusTime to match the date of timeInIST
      nearestBusTime.set({
        year: timeInIST.getFullYear(),
        month: timeInIST.getMonth(),
        date: timeInIST.getDate(),
        hour: startBus[0].boarding.arrival_time.split(":")[0],
        minute: startBus[0].boarding.arrival_time.split(":")[1],
      });

      const timeDifferenceInMinutes = Math.abs(
        nearestBusTime.diff(moment(timeInIST).tz(timeZone), "minutes")
      );

      const maximumTimeDifferenceInMinutes = 30;

      if (timeDifferenceInMinutes > maximumTimeDifferenceInMinutes) {
        start_bus_found = false;
      }
    } else {
      start_bus_found = false;
    }

    let currBusTravel;

    if (startBus[0] && start_bus_found) {
      time = nearestBusTime.toDate();

      currBusTravel = {
        mode: "bus",
        distance: startBus[0].drop.map.distance,
        duration: startBus[0].duration,
        boarding_point: startBus[0].boarding.name,
        boarding_time: time.getTime(),
        boarding_time_formatted: time.toLocaleTimeString("en-IN", options),
        drop_point: startBus[0].drop.name,
        drop_time: time.getTime() + startBus[0].duration * 60 * 1000,
        drop_time_formatted: new Date(
          time.getTime() + startBus[0].duration * 60 * 1000
        ).toLocaleTimeString("en-IN", options),
        price: startBus[0].student ? 0 : 40,
      };
      time = time.getTime() + startBus[0].duration * 60 * 1000;

      busTravel.push(currBusTravel);

      const start_walk_board = startBus[0].drop.map;
      const start_walk_drop = components[0].details.map;

      let res = await getDistance(start_walk_board, start_walk_drop, "walking");
      let startBusDistance;

      if (res.distance.includes("km")) {
        startBusDistance = parseFloat(res.distance.replace(" km", ""));
      } else if (res.distance.includes("m")) {
        startBusDistance = parseFloat(res.distance.replace(" m", "")) / 1000;
      }

      if (startBusDistance > 0.7) {
        res = await getDistance(start_walk_board, start_walk_drop, "driving");
      }

      currBusTravel = {
        mode: startBusDistance <= 0.7 ? "walking" : "auto",
        duration: res.duration,
        distance: res.distance,
        boarding_point: startBus[0].drop.name,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point:
          components[0].type == "Outing"
            ? components[0].details.place_name
            : components[0].details.hotel_name,
        drop_time: time + res.duration * 60 * 1000,
        drop_time_formatted: new Date(
          time + res.duration * 60 * 1000
        ).toLocaleTimeString("en-IN", options),
        price:
          startBusDistance <= 0.7
            ? 0
            : Math.max(
                Math.ceil((parseFloat(res.distance) * 20) / 50) * 50 +
                  (moment
                    .tz(time, "Asia/Kolkata")
                    .isAfter(moment.tz("17:30", "HH:mm", "Asia/Kolkata"))
                    ? 100
                    : 0),
                100
              ),
      };

      closestOpeningTime = findClosestTimeSlots(
        time,
        components[0].details.time_slots
      );

      if (!closestOpeningTime.isWithin) {
        throw {
          message: `${
            components[0].type === "Outing"
              ? components[0].details.place_name
              : components[0].details.hotel_name
          } is closed at this time`,
          componentId: components[0].id,
        };
      }

      busTravel.push(currBusTravel);
      time = time + res.duration * 60 * 1000;
    } else {
      let startAuto = {
        ...completeScooty.route[0],
        mode: "auto",
        price: Math.max(
          100,
          Math.ceil(
            (Math.round(
              parseFloat(allDistancesandDurations[0].driving.distance) * 2
            ) *
              10) /
              50
          ) * 50
        ),
      };

      closestOpeningTime = findClosestTimeSlots(
        time,
        components[0].details.time_slots
      );

      if (!closestOpeningTime.isWithin) {
        throw {
          message: `${
            components[0].type === "Outing"
              ? components[0].details.place_name
              : components[0].details.hotel_name
          } is closed at this time`,
          componentId: components[0].id,
        };
      }

      busTravel.push(startAuto);
      time = time.getTime() + completeScooty.route[0].duration * 60 * 1000;
    }

    for (let i = 1; i < allDistancesandDurations.length; i++) {
      if (i !== 0) {
        time = time + components[i - 1].details.duration * 60 * 1000;
        const istTimezone = "Asia/Kolkata";
        const istDatetime = moment.tz(time, istTimezone);
        const [closingProvidedHours, closingProvidedMinutes] =
          closestOpeningTime.closing_time.split(":").map(Number);

        const currentISTTime = moment.tz(istTimezone);
        const epochDate = new Date(time);

        const closingProvidedDatetime = currentISTTime.clone().set({
          year: epochDate.getFullYear(),
          month: epochDate.getMonth(),
          date: epochDate.getDate(),
          hours: closingProvidedHours,
          minutes: closingProvidedMinutes,
          seconds: 0,
          milliseconds: 0,
        });

        if (closingProvidedDatetime.isBefore(istDatetime)) {
          time = closingProvidedDatetime.valueOf();
        }
      }

      if (i === allDistancesandDurations.length - 1) {
        break;
      }

      let checkDistance = allDistancesandDurations[i].walking.distance.includes(
        "km"
      )
        ? parseFloat(
            allDistancesandDurations[i].walking.distance.replace(" km", "")
          )
        : parseFloat(
            allDistancesandDurations[i].walking.distance.replace(" m", "")
          );

      let selectiveDuration =
        checkDistance <= 0.7
          ? allDistancesandDurations[i].walking.duration
          : allDistancesandDurations[i].driving.duration;

      let selectiveDistance =
        checkDistance <= 0.7
          ? allDistancesandDurations[i].walking.distance
          : allDistancesandDurations[i].driving.distance;

      currBusTravel = {
        mode: checkDistance <= 0.7 ? "walking" : "auto",
        duration: selectiveDuration,
        distance: selectiveDistance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time + selectiveDuration * 60 * 1000,
        drop_time_formatted: new Date(
          time + selectiveDuration * 60 * 1000
        ).toLocaleTimeString("en-IN", options),
        price:
          checkDistance <= 0.7
            ? 0
            : Math.ceil((parseFloat(selectiveDistance) * 2 * 10) / 50) * 50 +
              (moment
                .tz(time, "Asia/Kolkata")
                .isAfter(moment.tz("17:30", "HH:mm", "Asia/Kolkata"))
                ? 100
                : 0),
      };

      if (i !== allDistancesandDurations.length - 1) {
        closestOpeningTime = findClosestTimeSlots(
          time,
          components[i].details.time_slots
        );

        if (!closestOpeningTime.isWithin) {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is closed at this time`,
            componentId: components[i].id,
          };
        }
      }

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

      let resDistance = await getDistance(
        end_walk_board,
        end_walk_drop_map,
        "walking"
      );

      let endBusDistance;

      if (resDistance.distance.includes("km")) {
        endBusDistance = parseFloat(resDistance.distance.replace(" km", ""));
      } else if (resDistance.distance.includes("m")) {
        endBusDistance =
          parseFloat(resDistance.distance.replace(" m", "")) / 1000;
      }

      if (endBusDistance > 0.7) {
        resDistance = await getDistance(
          end_walk_board,
          end_walk_drop_map,
          "driving"
        );
      }

      currWalkToBus = {
        mode: endBusDistance <= 0.7 ? "walking" : "auto",
        duration: resDistance.duration,
        distance: resDistance.distance,
        boarding_point:
          end.type == "Outing"
            ? end.details.place_name
            : end.details.hotel_name,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point: end_walk_drop,
        drop_time: time + resDistance.duration * 60 * 1000,
        drop_time_formatted: new Date(
          time + resDistance.duration * 60 * 1000
        ).toLocaleTimeString("en-IN", options),
        price:
          endBusDistance <= 0.7
            ? 0
            : Math.max(
                Math.ceil((parseFloat(resDistance.distance) * 20) / 50) * 50 +
                  (moment
                    .tz(time, "Asia/Kolkata")
                    .isAfter(moment.tz("17:30", "HH:mm", "Asia/Kolkata"))
                    ? 100
                    : 0),
                100
              ),
      };

      time = time + resDistance.duration * 60 * 1000;

      endBus = endBus.map((bus) => {
        const route = bus.route.find(
          (route) => route.name === end.details.bus_nodal_point
        );

        const bit_end = bus.route.filter((e) => e.name === "PMC, BIT Mesra")[0];

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
        compareReturnArrivalTime(busA, busB, new Date(time))
      );
    } else {
      endBus = [null];
    }
    end_bus_found = true;
    const minDiffBus =
      endBus[0] != null
        ? endBus.reduce((minBus, currentBus) =>
            currentBus.diff < minBus.diff ? currentBus : minBus
          )
        : null;

    // checking is bus is available +30 minutes
    let nearestEndBusTime;

    if (minDiffBus) {
      nearestEndBusTime = moment.tz(
        minDiffBus.boarding.arrival_time,
        "HH:mm",
        timeZone
      );

      const endTimeInIST = moment(time).tz(timeZone);

      nearestEndBusTime.set({
        year: endTimeInIST.year(),
        month: endTimeInIST.month(),
        date: endTimeInIST.date(),
        hour: nearestEndBusTime.hours(), // Use hours from boarding.arrival_time
        minute: nearestEndBusTime.minutes(), // Use minutes from boarding.arrival_time
      });

      const endTimeDifferenceInMinutes = nearestEndBusTime.diff(
        moment(endTimeInIST).tz(timeZone),
        "minutes"
      );

      if (
        !(endTimeDifferenceInMinutes <= 30 && endTimeDifferenceInMinutes >= 0)
      ) {
        end_bus_found = false;
      }

      nearestEndBusTime = nearestEndBusTime.valueOf();
    } else {
      end_bus_found = false;
    }

    if (end_bus_found) {
      currBusTravel = {
        mode: "bus",
        duration: minDiffBus.duration,
        distance: minDiffBus.boarding.map.distance,
        boarding_point: minDiffBus.boarding.name,
        boarding_time: nearestEndBusTime,
        boarding_time_formatted: new Date(nearestEndBusTime).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point: minDiffBus.drop.name,
        drop_time: nearestEndBusTime + minDiffBus.duration * 1000 * 60,
        drop_time_formatted: new Date(
          nearestEndBusTime + minDiffBus.duration * 1000 * 60
        ).toLocaleTimeString("en-IN", options),
        price: minDiffBus.student ? 0 : 40,
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
        ).toLocaleTimeString("en-IN", options),
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
        ).toLocaleTimeString("en-IN", options),
        price: Math.max(
          Math.ceil(
            (parseFloat(
              allDistancesandDurations[allDistancesandDurations.length - 1]
                .driving.distance
            ) *
              20) /
              50
          ) *
            50 +
            (moment
              .tz(time_before_walking, "Asia/Kolkata")
              .isAfter(moment.tz("17:30", "HH:mm", "Asia/Kolkata"))
              ? 100
              : 0),
          100
        ),
      };

      busTravel.push(currBusTravel);
    }

    price = 0;
    let completeBus;
    distance = 0;
    if (!start_bus_found && !end_bus_found) {
      completeBus = null;
    } else {
      for (let i = 0; i < busTravel.length; i++) {
        price += busTravel[i].price;
      }

      for (let i = 0; i < busTravel.length; i++) {
        if (busTravel[i].distance.includes("km")) {
          distanceValue = parseFloat(busTravel[i].distance.replace(" km", ""));
        } else if (busTravel[i].distance.includes("m")) {
          distanceValue =
            parseFloat(busTravel[i].distance.replace(" m", "")) / 1000;
        }
        distance += distanceValue;
      }

      completeBus = {
        route: busTravel,
        distance: distance,
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

        const istTimezone = "Asia/Kolkata";
        const istDatetime = moment.tz(time, istTimezone);
        const [closingProvidedHours, closingProvidedMinutes] =
          closestOpeningTime.closing_time.split(":").map(Number);

        const currentISTTime = moment.tz(istTimezone);
        const epochDate = new Date(time);

        const closingProvidedDatetime = currentISTTime.clone().set({
          year: epochDate.getFullYear(),
          month: epochDate.getMonth(),
          date: epochDate.getDate(),
          hours: closingProvidedHours,
          minutes: closingProvidedMinutes,
          seconds: 0,
          milliseconds: 0,
        });

        if (closingProvidedDatetime.isBefore(istDatetime)) {
          time = closingProvidedDatetime.valueOf();
        }
      }

      let checkDistance = allDistancesandDurations[i].walking.distance.includes(
        "km"
      )
        ? parseFloat(
            allDistancesandDurations[i].walking.distance.replace(" km", "")
          )
        : parseFloat(
            allDistancesandDurations[i].walking.distance.replace(" m", "")
          );

      let selectiveDuration =
        checkDistance <= 0.7
          ? allDistancesandDurations[i].walking.duration
          : allDistancesandDurations[i].driving.duration;

      let selectiveDistance =
        checkDistance <= 0.7
          ? allDistancesandDurations[i].walking.distance
          : allDistancesandDurations[i].driving.distance;

      currAutoTravel = {
        mode: checkDistance <= 0.7 ? "walking" : "auto",
        duration: selectiveDuration,
        distance: selectiveDistance,
        boarding_point: allDistancesandDurations[i].boarding_point,
        boarding_time: time,
        boarding_time_formatted: new Date(time).toLocaleTimeString(
          "en-IN",
          options
        ),
        drop_point: allDistancesandDurations[i].drop_point,
        drop_time: time + selectiveDuration * 1000 * 60,
        drop_time_formatted: new Date(
          time + selectiveDuration * 1000 * 60
        ).toLocaleTimeString("en-IN", options),
        price:
          checkDistance <= 0.7
            ? 0
            : Math.ceil(
                Math.max(
                  Math.round(parseFloat(selectiveDistance) * 2) * 10 +
                    (moment
                      .tz(time, "Asia/Kolkata")
                      .isAfter(moment.tz("17:30", "HH:mm", "Asia/Kolkata"))
                      ? 100
                      : 0),
                  allDistancesandDurations[i].boarding_point ===
                    "PMC, BIT Mesra" ||
                    allDistancesandDurations[i].drop_point === "PMC, BIT Mesra"
                    ? moment.tz(time, "Asia/Kolkata").hour() >= 17 &&
                      moment.tz(time, "Asia/Kolkata").minute() >= 30
                      ? 150
                      : 100
                    : 0
                ) / 50
              ) * 50,
      };

      if (i !== allDistancesandDurations.length - 1) {
        closestOpeningTime = findClosestTimeSlots(
          time,
          components[i].details.time_slots
        );

        if (!closestOpeningTime.isWithin) {
          throw {
            message: `${
              components[i].type === "Outing"
                ? components[i].details.place_name
                : components[i].details.hotel_name
            } is closed at this time`,
            componentId: components[i].id,
          };
        }
      }

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

    res.status(200).json({
      status: "Successful",
      allTravel: {
        bus: completeBus,
        auto: completeAuto,
        scooty: completeScooty,
        bike: completeBike,
        mid_size: completeMidSize,
        suv: completeSuv,
      },
    });
  } catch (error) {
    if (error.componentId)
      res.status(200).json({
        status: "Failed",
        message: error.message,
        componentId: error.componentId,
      });
    else {
      console.log(error);
      res.status(200).json({ status: "Failed", message: error.message });
    }
  }
};

exports.getMap = async (req, res) => {
  const { id, type } = req.body;

  try {
    if (type === "Outing") {
      const component = await Outing.findOne({ _id: id });
      res.status(200).send({ map: component.map, name: component.place_name });
    } else {
      const component = await Dining.findOne({ _id: id });
      res.status(200).send({ map: component.map, name: component.hotel_name });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "An error occurred while adding the bus." });
  }
};

exports.addBus = async (req, res) => {
  try {
    const bus = new Bus(req.body);
    const savedBus = await bus.save();

    res.status(200).json(savedBus);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "An error occurred while adding the bus." });
  }
};

exports.addOuting = async (req, res) => {
  const outingBody = req.body;
  try {
    const outing = new Outing(outingBody);
    outing.save();
    res.status(200).send({ status: "Successful", outing });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.addDining = async (req, res) => {
  const diningBody = req.body;
  try {
    const dining = new Dining(diningBody);
    dining.save();
    res.status(200).send({ status: "Successful", dining });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getDiningsLength = async (req, res) => {
  try {
    const dinings = await Dining.find({});
    res.status(200).send({ status: "Successful", count: dinings.length });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getOutingsLength = async (req, res) => {
  try {
    const outings = await Outing.find({});
    res.status(200).send({ status: "Successful", count: outings.length });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getAllDinings = async (req, res) => {
  try {
    const dinings = await Dining.find({});

    res.status(200).send({ status: "Successful", dinings });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getAllOutings = async (req, res) => {
  try {
    const outings = await Outing.find({});

    res.status(200).send({ status: "Successful", outings });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getOpenTravelOptions = async (req, res) => {
  await getTransport(req, res, getOpenDistance);
};

exports.getGoogleTravelOptions = async (req, res) => {
  await getTransport(req, res, getGoogleDistance);
};

exports.savePlan = async (req, res) => {
  const { plan_start_time, components, tile_content, preferred_transport } =
    req.body;

  try {
    // Create an array to store populated components
    const populatedComponents = [];

    // Populate the component_id field based on the type
    for (const component of components) {
      let componentModel;
      if (component.type === "Outing") {
        componentModel = Outing; // Use the Outing model for Outing components
      } else if (component.type === "Dining") {
        componentModel = Dining; // Use the Dining model for Dining components
      }

      if (componentModel) {
        // Create and save the component document if it doesn't exist
        let populatedComponent = await componentModel
          .findById(component.component_id)
          .exec();
        if (!populatedComponent) {
          populatedComponent = new componentModel({
            _id: component.component_id, // Set the _id to the provided component_id
            // Other properties specific to the component
          });
          await populatedComponent.save();
        }

        populatedComponents.push({
          order: component.order,
          type: component.type,
          is_highlight: component.is_highlight,
          component_id: populatedComponent._id, // Use the populated component's _id
        });
      }
    }

    // Generate a unique plan ID based on component_ids
    const componentIds = populatedComponents.map((c) =>
      c.component_id.toString()
    );
    const idString = componentIds.sort().join("");

    const existingPlan = await PlanModel.findOne({ plan_id: idString });

    if (!existingPlan) {
      // Find the authenticated admin based on the token (assuming req.user contains the authenticated admin)
      const admin = req.user;

      // Create a new plan and set the owner reference
      const plan = new PlanModel({
        plan_start_time,
        components: populatedComponents,
        plan_id: idString,
        tile_content,
        preferred_transport,
        owner: admin._id,
        owner_name: admin.name,
      });

      await plan.save();

      admin.plans.push(plan._id);
      await admin.save();

      res.status(200).send({ status: "Successful", plan });
    } else {
      res.status(200).send({
        status: "Failed",
        message: "This plan already exists!!",
        existingPlan,
      });
    }
  } catch (error) {
    console.error(error);
    res.status(200).send({ status: "Failed", message: error.message });
  }
};

exports.updatePlan = async (req, res) => {
  const idString = req.params.id;
  const { plan_start_time, components, tile_content, preferred_transport } =
    req.body;

  try {
    // Create an array to store populated components
    const populatedComponents = [];

    // Populate the component_id field based on the type
    for (const component of components) {
      let componentModel;
      if (component.type === "Outing") {
        componentModel = Outing; // Use the Outing model for Outing components
      } else if (component.type === "Dining") {
        componentModel = Dining; // Use the Dining model for Dining components
      }

      if (componentModel) {
        // Create and save the component document if it doesn't exist
        let populatedComponent = await componentModel
          .findById(component.component_id)
          .exec();
        if (!populatedComponent) {
          populatedComponent = new componentModel({
            _id: component.component_id, // Set the _id to the provided component_id
            // Other properties specific to the component
          });
          await populatedComponent.save();
        }

        populatedComponents.push({
          order: component.order,
          type: component.type,
          is_highlight: component.is_highlight,
          component_id: populatedComponent._id, // Use the populated component's _id
        });
      }
    }

    const existingPlan = await PlanModel.findOneAndDelete({
      plan_id: idString,
    });

    const admin = req.user;

    const plan = new PlanModel({
      plan_start_time,
      components: populatedComponents,
      plan_id: idString,
      tile_content,
      preferred_transport,
      owner: admin._id,
      owner_name: admin.name,
    });

    await plan.save();

    res.status(200).send({ status: "Successful", plan });
  } catch (error) {
    console.error(error);
    res.status(200).send({ status: "Failed", message: error.message });
  }
};

const calculateLikeness = (plan_preferences, userPreferences) => {
  // console.log(plan_preferences, userPreferences);
  const dinePreferences = userPreferences.Dine;
  const outingPreferences = userPreferences.Outing;
  const dinePlanPreferences = plan_preferences.Dine;
  const outingPlanPreferences = plan_preferences.Outing;

  const dineLikeness =
    dinePlanPreferences.Fine_Dining * dinePreferences.Fine_Dining +
    dinePlanPreferences.Foodcourt * dinePreferences.Foodcourt +
    dinePlanPreferences.Classic_Dine_In * dinePreferences.Classic_Dine_In +
    dinePlanPreferences.Dhabas * dinePreferences.Dhabas +
    dinePlanPreferences.Cafes * dinePreferences.Cafes +
    dinePlanPreferences.Streetfood * dinePreferences.Streetfood;

  const outingLikeness =
    outingPlanPreferences.Hills * outingPreferences.Hills +
    outingPlanPreferences.Lakes * outingPreferences.Lakes +
    outingPlanPreferences.Dams_Waterfalls * outingPreferences.Dams_Waterfalls +
    outingPlanPreferences.Arcade * outingPreferences.Arcade +
    outingPlanPreferences.Movie_Halls * outingPreferences.Movie_Halls +
    outingPlanPreferences.Parks * outingPreferences.Parks +
    outingPlanPreferences.Clubs_Bars * outingPreferences.Clubs_Bars +
    outingPlanPreferences.Shopping * outingPreferences.Shopping +
    outingPlanPreferences.Night_Out * outingPreferences.Night_Out +
    outingPlanPreferences.Places_Of_Worship *
      outingPreferences.Places_Of_Worship +
    outingPlanPreferences.Museum * outingPreferences.Museum;

  const likeness = (dineLikeness + outingLikeness) / 16;

  return likeness;
};

exports.getAllPlans = async (req, res) => {
  try {
    const allPlans = await PlanModel.find({ approved: 1 });
    const userPreferences = req.user.preferences;
    console.log(userPreferences);

    const updatedPlans = allPlans.map((plan) => {
      const uniqueTags = new Set();
      const imgArray = [];
      let price = 0;

      let plan_preferences = {
        Dine: {
          Fine_Dining: 0,
          RestroBar: 0,
          Foodcourt: 0,
          Classic_Dine_In: 0,
          Dhabas: 0,
          Cafes: 0,
          Streetfood: 0,
        },
        Outing: {
          Hills: 0,
          Lakes: 0,
          Dams_Waterfalls: 0,
          Arcade: 0,
          Movie_Halls: 0,
          Parks: 0,
          Clubs_Bars: 0,
          Night_Out: 0,
          Shopping: 0,
          Places_Of_Worship: 0,
          Museum: 0,
        },
      };
      plan.components.forEach((component, index) => {
        uniqueTags.add(component.tag);

        plan_preferences[component.type === "Dining" ? "Dine" : "Outing"][
          component.tag
        ]++;

        imgArray.push({
          img_link: component.img,
          name: component.name,
          order: component.order,
        });

        price += component.price;
      });
      let likeness = calculateLikeness(plan_preferences, userPreferences);
      const uniqueTagsArray = Array.from(uniqueTags);

      return {
        tags: uniqueTagsArray,
        img: imgArray,
        tile_content: plan.tile_content,
        plan_start_time: plan.plan_start_time,
        price: price,
        _id: plan.plan_id,
        availability: plan.availability,
        likeness,
      };
    });
    updatedPlans.sort((a, b) => b.likeness - a.likeness);
    res
      .status(200)
      .send({ status: "Successful", completedAllPlans: updatedPlans });
  } catch (error) {
    console.error(error);
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getParticularPlan = async (req, res) => {
  const plan_id = req.body.plan_id;

  try {
    const plan = await PlanModel.findOne({
      plan_id,
      approved: 1,
    });

    if (!plan) {
      res.send(404).send({ status: "Failed", message: "No plan found" });
    }

    console.log(plan);

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
        order: component.order,
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
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getComponentsByTag = async (req, res) => {
  const { tag, type } = req.body;

  try {
    let components = [];

    if (type == "Dining") {
      components = await Dining.find({
        tags: { $in: tag },
      });
    } else {
      components = await Outing.find({
        tags: { $in: tag },
      });
    }

    const sendingComponents = [];

    for (let i = 0; i < components.length; i++) {
      components[i].img = extractIdFromGoogleDriveLink(components[i].img);
      const openingTime12Hour = moment
        .tz(components[i].opening_time, "HH:mm", "Asia/Kolkata")
        .format("h:mm A");
      const closingTime12Hour = moment
        .tz(components[i].closing_time, "HH:mm", "Asia/Kolkata")
        .format("h:mm A");

      components[i].closing_time = closingTime12Hour;
      components[i].opening_time = openingTime12Hour;

      const sendingComponent = {
        is_highlight: false,
        order: -1,
        details: components[i],
      };
      sendingComponents.push(sendingComponent);
    }

    res
      .status(200)
      .send({ status: "Successful", components: sendingComponents });
  } catch (error) {
    console.log(error);
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.saveUserCreatedPlan = async (req, res) => {
  try {
    const token = req.header("Authorization").replace("Bearer ", "");
    const {
      plan_date,
      people_count,
      finalComponents,
      finalTravel,
      tile_content,
    } = {
      ...req.body,
    };

    const createdPlanBody = {
      travel: finalTravel,
      people_count,
      components: finalComponents,
      tile_content,
      createdBy: req.user._id,
      plan_date,
    };
    const userCreatedPlan = new CreatedPlanModel(createdPlanBody);
    await userCreatedPlan.save();
    await User.findByIdAndUpdate(req.user._id, {
      $push: { createdPlans: userCreatedPlan._id },
    });

    const response = await axios.get(
      `https://date-form-prod.onrender.com/api/v1/plan/getSavedUserCreatedPlan/${userCreatedPlan._id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`, // Include the token in the request header
        },
      }
    );

    res.status(200).send({
      status: "Successful",
      final_plan_details: response.data.final_plan_details,
    });
  } catch (error) {
    res.status(200).send({
      status: "Failed",
      message: error.message,
    });
  }
};

exports.getSavedUserCreatedPlan = async (req, res) => {
  const planId = req.params.id;
  const userId = req.user._id;

  try {
    const plan = await CreatedPlanModel.findById(planId).exec();

    if (!plan) {
      return res
        .status(404)
        .json({ status: "Failed", message: "Plan not found." });
    }

    if (plan.createdBy._id.toString() !== userId.toString()) {
      return res.status(200).json({
        status: "Failed",
        message: "You do not have permission to access this plan.",
      });
    }

    const populatedComponents = [];
    const tags = new Set();
    const images = [];

    let component_price = 0;
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

      component_price += curr_component.price_per_head;
    }

    const uniqueTags = Array.from(tags);

    // Final Component

    const filteredComponents = populatedComponents.map((component) => {
      const { is_highlight } = component;
      const { hotel_name, place_name, tags, price_per_head, duration } =
        component.details;
      let locationName =
        component.details.type === "Outing" ? place_name : hotel_name;
      return {
        is_highlight,
        name: locationName,
        tag: tags[0], // Assuming tags is an array
        price_per_head,
        duration,
      };
    });

    const route = plan.travel.route;

    const updatedRoute = [];

    route.forEach((routeItem) => {
      const matchingComponent = filteredComponents.find(
        (component) => component.name === routeItem.drop_point
      );

      const {
        mode,
        duration,
        distance,
        boarding_point,
        boarding_time,
        boarding_time_formatted,
        drop_point,
        drop_time,
        drop_time_formatted,
        price,
      } = routeItem;

      const update = {
        mode,
        duration,
        distance,
        boarding_point,
        boarding_time,
        boarding_time_formatted,
        drop_point,
        drop_time,
        drop_time_formatted,
        price,
        drop_point_component: matchingComponent ? matchingComponent : null,
      };

      updatedRoute.push(update);
      // }
    });

    const updatedTravel = { ...plan.travel, route: updatedRoute };

    const planDetails = {
      plan_start_time: plan.plan_date,
      images: images.sort((a, b) => a.order - b.order),
      no_of_components: filteredComponents.length,
      tile_content,
      tags: uniqueTags,
      complete_travel: updatedTravel.route,
      component_price: component_price * plan.people_count,
      travel_price: updatedTravel.price,
      people_count: plan.people_count,
    };

    res
      .status(200)
      .json({ status: "Successful", final_plan_details: planDetails });
  } catch (error) {
    res.status(500).json({
      status: "Failed",
      message: error.message,
    });
  }
};

function convertEpochToIndianTime(epoch) {
  const indianTime = moment(epoch).tz("Asia/Kolkata");
  const formattedTime = indianTime.format("hh:mm A");
  return formattedTime;
}

exports.getAllPlansAdmin = async (req, res) => {
  try {
    const allPlans = await PlanModel.find({}).exec();

    const completedAllPlans = await Promise.all(
      allPlans.map(async (plan) => {
        const populatedComponents = [];
        const tile_content = plan.tile_content;
        await Promise.all(
          plan.components.map(async (component) => {
            let componentModel;
            if (component.type === "Outing") {
              componentModel = Outing;
            } else if (component.type === "Dining") {
              componentModel = Dining;
            }

            if (componentModel) {
              const curr_component = await componentModel
                .findById(component.component_id)
                .exec();

              if (curr_component) {
                for (const time_slots of curr_component.time_slots) {
                  time_slots.opening_time = moment
                    .tz(time_slots.opening_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");

                  time_slots.closing_time = moment
                    .tz(time_slots.closing_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");
                }

                const componentWithHighlight = {
                  is_highlight: component.is_highlight,
                  order: component.order,
                  details: curr_component,
                };

                populatedComponents.push(componentWithHighlight);
              }
            }
          })
        );

        return {
          id: plan.plan_id,
          plan_start_time: plan.plan_start_time,
          components: populatedComponents.sort((a, b) => a.order - b.order),
          tile_content,
          approved: plan.approved,
          owner_name: plan.owner_name,
        };
      })
    );

    res.status(200).send({ status: "Successful", completedAllPlans });
  } catch (error) {
    console.error(error);
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.approvePlan = async (req, res) => {
  const plan_id = req.params.id;

  try {
    const plan = await PlanModel.updateOne(
      {
        plan_id,
      },
      { approved: 1 }
    );
    res.status(200).send({ status: "Successful", message: "Approved" });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.rejectPlan = async (req, res) => {
  const plan_id = req.params.id;

  try {
    const plan = await PlanModel.updateOne(
      {
        plan_id,
      },
      { approved: 2 }
    );
    res.status(200).send({ status: "Successful", message: "Rejected" });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.searchRestaurant = async (req, res) => {
  const { restaurantName } = req.params;
  const encodedRestaurantName = encodeURIComponent(restaurantName);
  const apiUrl = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${encodedRestaurantName}+Ranchi,India&key=${API_KEY}`;

  try {
    const response = await axios.get(apiUrl);

    if (response.status === 200) {
      const data = response.data;
      if (data.results && data.results.length > 0) {
        const firstResult = data.results[0];
        const name = firstResult.name;
        const address = firstResult.formatted_address;
        const rating = firstResult.rating || "N/A";

        const restaurantInfo = {
          name,
          address,
          rating,
        };

        res.json(restaurantInfo);
      } else {
        res
          .status(404)
          .json({ error: "No results found for the specific restaurant." });
      }
    } else {
      res.status(500).json({ error: "Error making API request." });
    }
  } catch (error) {
    res.status(500).json({ error: "Error making API request." });
  }
};

exports.getAllPlansNamesTags = async (req, res) => {
  try {
    const allPlans = await PlanModel.find({}).exec();

    const completedAllPlans = await Promise.all(
      allPlans.map(async (plan) => {
        const populatedComponents = [];

        await Promise.all(
          plan.components.map(async (component) => {
            let componentModel;
            if (component.type === "Outing") {
              componentModel = Outing;
            } else if (component.type === "Dining") {
              componentModel = Dining;
            }

            if (componentModel) {
              const curr_component = await componentModel
                .findById(component.component_id)
                .exec();

              if (curr_component) {
                for (const time_slots of curr_component.time_slots) {
                  time_slots.opening_time = moment
                    .tz(time_slots.opening_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");

                  time_slots.closing_time = moment
                    .tz(time_slots.closing_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");
                }

                populatedComponents.push({
                  name:
                    curr_component.type === "Dining"
                      ? curr_component.hotel_name
                      : curr_component.place_name,
                  tags: curr_component.tags,
                });
              }
            }
          })
        );

        return {
          components: populatedComponents,
        };
      })
    );

    res.status(200).send({ status: "Successful", completedAllPlans });
  } catch (error) {
    console.error(error);
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getTime = async (req, res) => {
  try {
    const { type, id } = req.body;
    if (type === "Outing") {
      const outing = await Outing.findOne({ _id: id });

      res
        .status(200)
        .send({ status: "Successful", time_slots: outing.time_slots });
    } else {
      const dining = await Dining.findOne({ _id: id });
      res
        .status(200)
        .send({ status: "Successful", time_slots: dining.time_slots });
    }
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.getUpcomingSavedUserCreatedPlans = async (req, res) => {
  const userId = req.user._id;
  const currentDate = new Date();
  try {
    const userPlans = await CreatedPlanModel.find({
      createdBy: userId,
      plan_date: { $gte: currentDate },
    })
      .sort({ plan_date: 1 })
      .exec();

    if (!userPlans || userPlans.length === 0) {
      return res.status(200).json({
        status: "Failed",
        message: "No upcoming plans found for this user.",
      });
    }

    const plansDetails = [];

    for (const plan of userPlans) {
      const tags = [];

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

        tags.push({ order: component.order, tag: curr_component.tags[0] });
      }

      const planDetails = {
        plan_start_time: plan.plan_date,
        id: plan._id,
        tile_content,
        tags,
      };

      plansDetails.push(planDetails);
    }

    console.log(plansDetails);

    res
      .status(200)
      .send({ status: "Successful", user_upcoming_plans: plansDetails });
  } catch (error) {
    res.status(500).send({
      status: "Failed",
      message: error.message,
    });
  }
};

exports.getRecentSavedUserCreatedPlans = async (req, res) => {
  const userId = req.user._id;
  const currentDate = new Date();

  try {
    const userPlans = await CreatedPlanModel.find({
      createdBy: userId,
      plan_date: { $lt: currentDate },
    })
      .sort({ plan_date: -1 })
      .exec();

    if (!userPlans || userPlans.length === 0) {
      return res.status(200).json({
        status: "Failed",
        message: "No recent plans found for this user.",
      });
    }

    const plansDetails = [];

    for (const plan of userPlans) {
      const tags = [];

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

        tags.push({ order: component.order, tag: curr_component.tags[0] });
      }

      const planDetails = {
        plan_start_time: plan.plan_date,
        id: plan._id,
        tile_content,
        tags,
      };

      plansDetails.push(planDetails);
    }

    console.log(plansDetails);

    res
      .status(200)
      .send({ status: "Successful", user_recent_plans: plansDetails });
  } catch (error) {
    res.status(500).send({
      status: "Failed",
      message: error.message,
    });
  }
};

exports.getBookmarkedPlans = async (req, res) => {
  const userId = req.user._id;

  try {
    const user = await User.findById(userId).populate("bookmarks");

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const allPlans = user.bookmarks;

    const completedAllPlans = await Promise.all(
      allPlans.map(async (plan) => {
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
        let price = 0;
        const tile_content = plan.tile_content;

        await Promise.all(
          plan.components.map(async (component) => {
            let componentModel;
            if (component.type === "Outing") {
              componentModel = Outing;
            } else if (component.type === "Dining") {
              componentModel = Dining;
            }

            if (componentModel) {
              const curr_component = await componentModel
                .findById(component.component_id)
                .exec();

              if (curr_component) {
                for (const time_slots of curr_component.time_slots) {
                  time_slots.opening_time = moment
                    .tz(time_slots.opening_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");

                  time_slots.closing_time = moment
                    .tz(time_slots.closing_time, "HH:mm", "Asia/Kolkata")
                    .format("h:mm A");
                }

                const componentWithHighlight = {
                  is_highlight: component.is_highlight,
                  order: component.order,
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
                  sunday:
                    availability.sunday && curr_component.availability.sunday,
                  monday:
                    availability.monday && curr_component.availability.monday,
                  tuesday:
                    availability.tuesday && curr_component.availability.tuesday,
                  wednesday:
                    availability.wednesday &&
                    curr_component.availability.wednesday,
                  thursday:
                    availability.thursday &&
                    curr_component.availability.thursday,
                  friday:
                    availability.friday && curr_component.availability.friday,
                  saturday:
                    availability.saturday &&
                    curr_component.availability.saturday,
                };

                price += curr_component.price_per_head;
              }
            }
          })
        );

        const uniqueTags = Array.from(tags);

        return {
          id: plan.plan_id,
          tags: uniqueTags,
          images: images.sort((a, b) => a.order - b.order),
          availability,
          plan_start_time: plan.plan_start_time,
          price,
          tile_content,
          components: populatedComponents.sort((a, b) => a.order - b.order),
        };
      })
    );

    res
      .status(200)
      .send({ status: "Successful", bookmarkedPlans: completedAllPlans });
  } catch (error) {
    console.error(error);
    res.status(500).send({ status: "Failed", message: error.message });
  }
};

exports.changeSchema = async (req, res) => {
  try {
    // Fetch all older plans
    const oldPlans = await PlanModel.find();

    // Iterate through each old plan and update it to match the new schema
    for (const oldPlan of oldPlans) {
      const updatedComponents = [];

      let availability = {
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        saturday: true,
      };

      for (const oldComponent of oldPlan.components) {
        let componentModel;
        if (oldComponent.type === "Outing") {
          componentModel = Outing;
        } else if (oldComponent.type === "Dining") {
          componentModel = Dining;
        }

        if (componentModel) {
          const curr_component = await componentModel
            .findById(oldComponent.component_id)
            .exec();

          availability = {
            sunday: availability.sunday && curr_component.availability.sunday,
            monday: availability.monday && curr_component.availability.monday,
            tuesday:
              availability.tuesday && curr_component.availability.tuesday,
            wednesday:
              availability.wednesday && curr_component.availability.wednesday,
            thursday:
              availability.thursday && curr_component.availability.thursday,
            friday: availability.friday && curr_component.availability.friday,
            saturday:
              availability.saturday && curr_component.availability.saturday,
          };

          const updatedComponent = {
            order: oldComponent.order,
            type: oldComponent.type,
            is_highlight: oldComponent.is_highlight,
            name:
              oldComponent.type === "Dining"
                ? curr_component.hotel_name
                : curr_component.place_name,
            img: extractIdFromGoogleDriveLink(curr_component.img),
            tag: curr_component.tags[0],
            price: curr_component.price_per_head,
            component_id: oldComponent.component_id,
            availability,
          };
          updatedComponents.push(updatedComponent);
        }
      }

      oldPlan.components = updatedComponents;

      await oldPlan.save();
    }

    res.status(200).json({ oldPlans });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};
