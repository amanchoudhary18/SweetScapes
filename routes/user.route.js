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

// sign up route
router.post("/register", async (req, res) => {
  const userBody = req.body;
  const existingMobileUser = await User.findOne({
    mobileNumber: userBody.mobileNumber,
  });
  const user = new User(userBody);
  if (userBody.mobileNumber) {
    if (!existingMobileUser) {
      try {
        otp = generateOTP(4);
        // await sendotp(user.mobileNumber, otp);
        var otpModel = { otp: otp, status: true, user: user };
        const otpDb = new OtpModel(otpModel);
        otpsave = await otpDb.save();
        setTimeout(async () => {
          console.log("executing otp timeout");
          const otpupdate = await OtpModel.findOneAndUpdate(
            { _id: otpsave._id },
            { otp: otp, status: false, user: user }
          );
          console.log(otpupdate);
        }, 100000);
        if (otpsave)
          res.status(200).send({ message: "otp sent", otpId: otpsave._id });
        else
          res.send({
            status: "otp not sent",
            message: otpsave,
          });
      } catch (err) {
        res.status(200).send({
          status: "Failed here",
          message: err.message,
        });
      }
    } else {
      res.status(200).send({
        status: "Failed",
        message: "Mobile number is already in use",
      });
    }
  } else {
    res.status(200).send({
      status: "Failed",
      message: "Send a mobile number or password in request.",
    });
  }
});

// login route
router.post("/login", async (req, res) => {
  const userBody = req.body;
  if (userBody.mobileNumber) {
    try {
      const user = await User.findOne({
        mobileNumber: userBody.mobileNumber,
      });
      console.log(user);
      if (user) {
        const isMatch = await bcrypt.compare(userBody.password, user.password);
        console.log(isMatch);
        if (isMatch) {
          res
            .status(200)
            .send({ status: "Successful", user, token: user.token });
        } else {
          res.status(200).send({
            status: "Failed",
            message: "Password does not match",
          });
        }
      } else {
        console.log("No value found case");
        res.status(200).send({
          status: "Failed",
          message: "No user found",
        });
      }
    } catch (err) {
      res.status(200).send({
        status: "Failed",
        message: err.message,
      });
    }
  } else {
    res.status(200).send({
      status: "Failed",
      message: "Enter valid mobile number",
    });
  }
});

router.get("/generatePairCode", userAuth, async (req, res) => {
  const gencode = async () => {
    const otp = generateOTP(6);
    const existingOtp = await Paircode.find({ paircode: otp });
    if (existingOtp) gencode();
    else return otp;
  };

  const genPairCode = gencode();
  console.log(genPairCode);
  const paircodebody = {
    owner: req.user,
    paircode: genPairCode,
  };

  const paircode = new Paircode(paircodebody);
  await paircode.save();

  setTimeout(async () => {
    console.log("Deleted the Paircode ");
    await Paircode.findByIdAndDelete({ _id: paircode._id });
  }, 30000);

  res.json({
    status: true,
    data: null,
    msg: `Paircode generated ${gencode}`,
  });
});

router.post("/matchPairCode", userAuth, async (req, res) => {
  const paircode = req.body.paircode;
  const pairbody = await Paircode.findOne({ paircode });

  const userA = await User.findOneAndUpdate(
    { _id: pairbody.owner },
    { pairedWith: req.user }
  );

  const userB = await User.findOneAndUpdate(
    { _id: req.user._id },
    { pairedWith: pairbody.owner, isPaired: true }
  );

  res.send({ userA, userB });
});

router.post("/otpVerification", async (req, res) => {
  const otp = req.body.otpEntered;
  const otpId = req.body.otpId;
  
  const otpDB = await OtpModel.findById(otpId);
  if (otpDB.otp == otp && otpDB.status) {
    const userBody = otpDB.user;
    // const username = generateUsername(userBody);
    // userBody.username = username;
    const user = new User(userBody);
    await user.save();
    const token = await user.generateAuthToken();
    res.status(200).send({
      status: "Successful",
      user,
      token,
    });
  } else {
    res.status(400).send({ message: "wrong otp entered" });
    console.log("wrong otp entered");
  }
});
module.exports = router;
