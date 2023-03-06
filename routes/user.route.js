const express = require("express");
const User = require("../models/user.model");
const bcrypt = require("bcryptjs");
const generateOTP = require("../utils/generateOTP");
const userAuth = require("../middleware/userAuth");
const Paircode = require("../models/paircode.model");
const { sendotp } = require("../utils/sendOTP");
const router = express.Router();
const OtpModel = require("../models/otp.model");
const generateUsername = require("../utils/generateUsername");
const UserController = require("../controllers/user.controller");

// sign up route
router.post("/register", UserController.register);

// login route
router.post("/login", UserController.login);

// get mydata
router.get("/mydata", userAuth, UserController.mydata);

// update data
router.put("/update", userAuth, UserController.update);

//generate pair code
router.get("/generatePairCode", userAuth, UserController.generatePairCode);

// match pair code
router.post("/matchPairCode", userAuth, UserController.matchPairCode);

// otp verification
router.post("/otpVerification", UserController.otpverification);

module.exports = router;
