const express = require("express");
const User = require("../models/user.model");
const bcrypt = require("bcryptjs");
const generateOTP = require("../utils/generateOTP");
const userAuth = require("../middleware/userAuth");
const Paircode = require("../models/paircode.model");
const router = express.Router();

// sign up route
router.post("/register", async (req, res) => {
  const userBody = req.body;
  const existingUsernameUser = await User.findOne({
    username: userBody.username,
  });
  const existingMobileUser = await User.findOne({
    mobileNumber: userBody.mobileNumber,
  });

  if (userBody.mobileNumber) {
    const user = new User(userBody);

    if (!existingMobileUser) {
      if (!existingUsernameUser) {
        try {
          if (user.username) await user.save();
          const token = await user.generateAuthToken();
          res.status(200).send({
            status: "Successful",
            user,
            token,
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
          message: "Username already taken",
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

router.post("/sendotp", async (req, res) => {
  const response = await fast2sms.sendMessage({
    authorization: process.env.FAST2SMS_APIKEY,
    message: req.body.message,
    number: req.body.number,
  });

  res.send(response);
});
module.exports = router;
