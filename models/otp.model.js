const mongoose = require("mongoose");

const otpModel = new mongoose.Schema({
  otp: {
    type: Number,
    required: true,
  },
  status: {
    type: Boolean,
  },
});

const OtpModel = mongoose.model("Otp", otpModel);

module.exports = OtpModel;
