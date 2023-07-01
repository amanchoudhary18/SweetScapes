const mongoose = require("mongoose");

const busModel = new mongoose.Schema({
  route_type: {
    type: String,
    enum: ["Kokar", "RIMS"],
    required: true,
  },
  going: {
    type: Boolean,
  },
  student: {
    type: Boolean,
  },
  availability: {
    weekday: {
      type: Boolean,
    },
    sat: {
      type: Boolean,
    },
    sun: {
      type: Boolean,
    },
    holiday: {
      type: Boolean,
    },
  },
  route: [
    {
      name: {
        type: String,
      },
      arrival_time: {
        type: String,
      },
      map: {
        lat: {
          type: String,
        },
        lng: {
          type: String,
        },
      },
    },
  ],
});

const Bus = mongoose.model("Bus", busModel);

busModel.pre("save", function (next) {
  // Sort the route array based on arrival_time
  this.route.sort((a, b) => {
    const timeA = new Date(a.arrival_time);
    const timeB = new Date(b.arrival_time);
    return timeA - timeB;
  });

  next();
});

module.exports = Bus;
