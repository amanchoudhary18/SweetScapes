// Gurushanth's code
const mongoose = require("mongoose");

const paircodeSchema = new mongoose.Schema({
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "User",
  },
  paircode: {
    type: Number,
  },
});

const Paircode = mongoose.model("Paircode", paircodeSchema);

module.exports = Paircode;
