const mongoose = require("mongoose");

const otpModel = new mongoose.Schema({
  otp: {
    type: Number,
    required: true,
  },
  status: {
    type: Boolean,
  },
  user: {
    name: {
      type: String,
      required: true,
    },
    // password stored in hash form
    password: {
      type: String,
      required: true,
    },
    // email assosciated
    email: {
      type: String,
      trim: true,
      validate(value) {
        if (!validator.isEmail(value)) {
          throw new Error("Enter valid email");
        }
      },
    },
    // mobile number assosciated
    mobileNumber: {
      type: Number,
      required: true,
      maxLength: 10,
    },

    // auto-generated username
    username: {
      type: String,
    },
  },
});

const OtpModel = mongoose.model("Otp", otpModel);

module.exports = OtpModel;
