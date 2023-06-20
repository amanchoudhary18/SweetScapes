const mongoose = require("mongoose");

const hitModel = new mongoose.Schema({
  hit_time: {
    type: String,
    required: true,
  },
});

const HitModel = mongoose.model("Hit", hitModel);

module.exports = HitModel;
