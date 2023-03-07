const mongoose = require("mongoose");

const otpModel = new mongoose.Schema({
  otp: {
    type: String,
    required: true,
  },
  status: {
    type: Boolean,
    required: true,
  },
  mobileNumber:{
    type: Number,
    required: true,
  }
});

const OtpModel = mongoose.model("Otp", otpModel);

module.exports = OtpModel;
