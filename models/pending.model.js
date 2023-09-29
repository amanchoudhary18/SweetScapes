const mongoose = require("mongoose");

const pendingSchema = new mongoose.Schema({
  name: {
    type: String,
  },

  type: {
    type: String,
  },
  added: {
    type: Boolean,
    default: false,
  },
});

const Pending = mongoose.model("Pending", pendingSchema);

module.exports = Pending;
