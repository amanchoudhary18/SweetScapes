const mongoose = require("mongoose");

const outingModel = new mongoose.Schema({
  type: {
    type: String,
  },
  tags: [
    {
      type: String,
    },
  ],
  place_name: {
    type: String,
  },
  contact: {
    name: {
      type: String,
    },
    number: {
      type: String,
    },
  },
  description: {
    type: String,
  },
  rating: {
    type: Number,
  },
  price_per_head: {
    type: Number,
  },
  map: {
    lat: {
      type: String,
    },
    lng: {
      type: String,
    },
  },
  website_link: {
    type: String,
  },
  bus_nodal_point: {
    type: String,
  },
  bus_route_type: [
    {
      type: String,
      enum: ["Kokar", "RIMS"],
    },
  ],
  duration: {
    type: Number,
  },
  opening_time: {
    type: String,
  },
  closing_time: {
    type: String,
  },
  img: {
    type: String,
  },
});

const Outing = mongoose.model("Outing", outingModel);

module.exports = Outing;
