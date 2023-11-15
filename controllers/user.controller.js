const User = require("../models/user.model");
const bcrypt = require("bcryptjs");
const generateOTP = require("../utils/generateOTP");
const Paircode = require("../models/paircode.model");
const { sendotp } = require("../utils/sendOTP");
const OtpModel = require("../models/otp.model");
const generateUsername = require("../utils/generateUsername");
const generateAge = require("../utils/generateAge");
const sgMail = require("@sendgrid/mail");
const mongoose = require("mongoose");
const PlanModel = require("../models/plan.model");
const Outing = require("../models/outing.model");
const Dining = require("../models/dining.model");
const moment = require("moment-timezone");
const FeedbackModel = require("../models/feedback.model");
const CreatedPlanModel = require("../models/created_plan.model");
require("dotenv").config({ path: "../.env" });

//register function
exports.register = async (req, res) => {
  const userBody = req.body;

  if (!userBody.email.includes("@bitmesra.ac.in")) {
    res
      .status(200)
      .send({ status: "Failed", message: "Enter your institute email id" });
  } else {
    try {
      const otp = generateOTP(4);

      sgMail.setApiKey(process.env.SG_GRID_API);
      console.log(process.env.SG_GRID_API);

      const msg = {
        to: userBody.email,
        from: "sweetscapes.organization@gmail.com",
        subject: "OTP for Registration",
        text: `Your OTP is: ${otp}`,
      };

      sgMail
        .send(msg)
        .then(async () => {
          const otpModel = {
            otp: otp,
            status: true,
            email: userBody.email,
          };
          const otpDb = new OtpModel(otpModel);
          const otpsave = await otpDb.save();

          setTimeout(async () => {
            const otpupdate = await OtpModel.findOneAndUpdate(
              { _id: otpsave._id },
              { otp: otp, status: false }
            );
          }, 100000);

          res.status(200).send({
            status: "Successful",
            message: "otp sent",
            otpId: otpsave._id,
          });
        })
        .catch((error) => {
          console.error(error);
          res.status(200).send({
            status: "Failed",
            message: "Failed to send OTP",
          });
        });
    } catch (err) {
      console.error(err);
      res.status(500).send({
        status: "Failed",
        message: err.message,
      });
    }
  }
};
// login function
exports.login = async (req, res) => {
  const userBody = req.body;

  if (userBody.email) {
    try {
      const user = await User.findOne({
        email: userBody.email,
      });

      if (user) {
        otp = generateOTP(4);
        // await sendotp(user.mobileNumber, otp);
        var otpModel = {
          otp: otp,
          status: true,
          email: user.email,
        };
        const otpDb = new OtpModel(otpModel);
        otpsave = await otpDb.save();
        setTimeout(async () => {
          const otpupdate = await OtpModel.findOneAndUpdate(
            { _id: otpsave._id },
            { otp: otp, status: false }
          );
        }, 100000);
        if (otpsave)
          res.status(200).send({
            status: "Successful",
            message: "otp sent",
            otpId: otpsave._id,
          });
        else
          res.send({
            status: "Failed",
            message: otpsave,
          });
      } else {
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
      message: "Enter valid email",
    });
  }
};

exports.loginotpverification = async (req, res) => {
  try {
    const otp = req.body.otpEntered;
    const otpId = req.body.otpId;

    const otpDB = await OtpModel.findById(otpId);
    const email = otpDB.email;

    if (
      otpDB.otp == otp &&
      otpDB.status &&
      req.body.user.email == otpDB.email
    ) {
      const user = await User.findOne({ email });

      const token = await user.generateAuthToken();

      otpDB.status = false;
      await otpDB.save();

      res.status(200).send({
        status: "Successful",
        message: "Email verified",
        user,
        token,
      });
    } else {
      res.status(200).send({
        status: "Failed",
        message: "Incorrect OTP entered. Please try again.",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(200).send({
      status: "Failed",
      message: "Incorrect OTP entered. Please try again.",
    });
  }
};

// my data function
exports.mydata = async (req, res) => {
  try {
    res.status(200).send({ status: "Successful", userData: req.user });
  } catch (error) {
    res.status(200).send({ status: "Failed", message: "User not found" });
  }
};

// update user data function
exports.update = async (req, res) => {
  const {
    name,
    password,
    email,
    mobileNumber,
    gender,
    avatar,
    birthday,
    preferences,
    location,
  } = req.body;

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(200);
    throw new Error("User Not Found");
  } else {
    try {
      if (name) user.name = name;
      if (password) user.password = password;
      if (email) user.email = email;
      if (mobileNumber) user.mobileNumber = mobileNumber;
      if (gender) user.gender = gender;
      if (avatar) user.avatar = avatar;
      if (birthday) user.birthday = birthday;

      if (location) {
        user.location.latitude = location.latitude;
        user.location.longitude = location.longitude;
      }

      // if (user.name && user.mobileNumber && user.birthday) {
      //   user.username = generateUsername(user);
      // }

      if (preferences) {
        if (preferences.Dine) {
          //Dining Preferences
          if (preferences.Dine.Fine_Dining !== undefined)
            user.preferences.Dine.Fine_Dining = preferences.Dine.Fine_Dining
              ? 1
              : 0;
          if (preferences.Dine.Foodcourt !== undefined)
            user.preferences.Dine.Foodcourt = preferences.Dine.Foodcourt
              ? 1
              : 0;
          if (preferences.Dine.RestroBar !== undefined)
            user.preferences.Dine.RestroBar = preferences.Dine.RestroBar
              ? 1
              : 0;
          if (preferences.Dine.Classic_Dine_In !== undefined)
            user.preferences.Dine.Classic_Dine_In = preferences.Dine
              .Classic_Dine_In
              ? 1
              : 0;
          if (preferences.Dine.Dhabas !== undefined)
            user.preferences.Dine.Dhabas = preferences.Dine.Dhabas ? 1 : 0;
          if (preferences.Dine.Home_Delivery !== undefined)
            user.preferences.Dine.Home_Delivery = preferences.Dine.Home_Delivery
              ? 1
              : 0;
          if (preferences.Dine.Take_Away !== undefined)
            user.preferences.Dine.Take_Away = preferences.Dine.Take_Away
              ? 1
              : 0;
          if (preferences.Dine.Home_Made !== undefined)
            user.preferences.Dine.Home_Made = preferences.Dine.Home_Made
              ? 1
              : 0;
          if (preferences.Dine.Cafes !== undefined)
            user.preferences.Dine.Cafes = preferences.Dine.Cafes ? 1 : 0;
        }

        // Outing Preferences
        if (preferences.Outing !== undefined) {
          if (preferences.Outing.Hills_Lakes !== undefined)
            user.preferences.Outing.Hills_Lakes = preferences.Outing.Hills_Lakes
              ? 1
              : 0;
          if (preferences.Outing.Dams_Waterfalls !== undefined)
            user.preferences.Outing.Dams_Waterfalls = preferences.Outing
              .Dams_Waterfalls
              ? 1
              : 0;
          if (preferences.Outing.Arcade !== undefined)
            user.preferences.Outing.Arcade = preferences.Outing.Arcade ? 1 : 0;
          if (preferences.Outing.Movie !== undefined)
            user.preferences.Outing.Movie = preferences.Outing.Movie ? 1 : 0;
          if (preferences.Outing.Park !== undefined)
            user.preferences.Outing.Parks = preferences.Outing.Parks ? 1 : 0;
          if (preferences.Outing.Picnics !== undefined)
            user.preferences.Outing.Picnics = preferences.Outing.Picnics
              ? 1
              : 0;
          if (preferences.Outing.Clubs_Bars !== undefined)
            user.preferences.Outing.Clubs_Bars = preferences.Outing.Clubs_Bars
              ? 1
              : 0;
          if (preferences.Outing.Night_Out !== undefined)
            user.preferences.Outing.Night_Out = preferences.Outing.Night_Out
              ? 1
              : 0;
          if (preferences.Outing.Window_Shopping !== undefined)
            user.preferences.Outing.Window_Shopping = preferences.Outing
              .Window_Shopping
              ? 1
              : 0;
        }

        user.isNew = false;
      }

      user.save();
      res.status(200).send({ status: "Successful", user });
    } catch (error) {
      res.status(200).send({ status: "Failed", message: error.message });
      console.log(error);
    }
  }
};

//update birthday and gender and send preferences
exports.updateInitial = async (req, res) => {
  const { gender, birthday } = req.body;

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(200);
    throw new Error("User Not Found");
  } else {
    try {
      if (gender) user.gender = gender;
      if (birthday) user.birthday = birthday;

      const dining = [
        "Fine Dining",
        "Decent Dining",
        "Dhabas",
        "Home Delivery",
        "Take Away",
        "Home-made",
        "Cafes",
      ];
      const outing = [
        "Hills, Lakes",
        "Dams, Waterfalls",
        "Arcade",
        "Movie",
        "Park",
        "Picnics",
        "Clubs_Bars",
        "Night Out",
        "Window Shopping",
      ];
      user.save();
      res.status(200).send({ status: "Successful", dining, outing });
    } catch (error) {
      res.send({ status: "Failed", message: error.message });
      console.log(error);
    }
  }
};

//set preferences
exports.setInitialPreferences = async (req, res) => {
  const { preferences } = req.body;

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(200);
    throw new Error("User Not Found");
  } else {
    try {
      if (preferences) {
        if (preferences.Dine) {
          //Dining Preferences
          if (preferences.Dine.Fine_Dining !== undefined)
            user.preferences.Dine.Fine_Dining = preferences.Dine.Fine_Dining
              ? 1
              : 0;
          if (preferences.Dine.Foodcourt !== undefined)
            user.preferences.Dine.Foodcourt = preferences.Dine.Foodcourt
              ? 1
              : 0;
          if (preferences.Dine.RestroBar !== undefined)
            user.preferences.Dine.RestroBar = preferences.Dine.RestroBar
              ? 1
              : 0;
          if (preferences.Dine.Classic_Dine_In !== undefined)
            user.preferences.Dine.Classic_Dine_In = preferences.Dine
              .Classic_Dine_In
              ? 1
              : 0;
          if (preferences.Dine.Dhabas !== undefined)
            user.preferences.Dine.Dhabas = preferences.Dine.Dhabas ? 1 : 0;

          if (preferences.Dine.Cafes !== undefined)
            user.preferences.Dine.Cafes = preferences.Dine.Cafes ? 1 : 0;
        }

        // Outing Preferences
        if (preferences.Outing !== undefined) {
          if (preferences.Outing.Hills !== undefined)
            user.preferences.Outing.Hills = preferences.Outing.Hills ? 1 : 0;
          if (preferences.Outing.Lakes !== undefined)
            user.preferences.Outing.Lakes = preferences.Outing.Lakes ? 1 : 0;
          if (preferences.Outing.Dams_Waterfalls !== undefined)
            user.preferences.Outing.Dams_Waterfalls = preferences.Outing
              .Dams_Waterfalls
              ? 1
              : 0;
          if (preferences.Outing.Arcade !== undefined)
            user.preferences.Outing.Arcade = preferences.Outing.Arcade ? 1 : 0;
          if (preferences.Outing.Movie_Halls !== undefined)
            user.preferences.Outing.Movie_Halls = preferences.Outing.Movie_Halls
              ? 1
              : 0;
          if (preferences.Outing.Parks !== undefined)
            user.preferences.Outing.Parks = preferences.Outing.Parks ? 1 : 0;

          if (preferences.Outing.Clubs_Bars !== undefined)
            user.preferences.Outing.Clubs_Bars = preferences.Outing.Clubs_Bars
              ? 1
              : 0;
          if (preferences.Outing.Night_Out !== undefined)
            user.preferences.Outing.Night_Out = preferences.Outing.Night_Out
              ? 1
              : 0;
          if (preferences.Outing.Shopping !== undefined)
            user.preferences.Outing.Shopping = preferences.Outing.Shopping
              ? 1
              : 0;
          if (preferences.Outing.Places_Of_Worship !== undefined)
            user.preferences.Outing.Places_Of_Worship = preferences.Outing
              .Places_Of_Worship
              ? 1
              : 0;
          if (preferences.Outing.Museum !== undefined)
            user.preferences.Outing.Museum = preferences.Outing.Museum ? 1 : 0;
        }

        user.isNew = false;
      }

      user.save();
      res.status(200).send({ status: "Successful", user });
    } catch (error) {
      res.status(200).send({ status: "Failed", message: error.message });
      console.log(error);
    }
  }
};

// otp-verification function
exports.otpverification = async (req, res) => {
  const otp = req.body.otpEntered;
  const otpId = req.body.otpId;

  const otpDB = await OtpModel.findById(otpId);
  const email = otpDB.email;

  if (otpDB.otp == otp && otpDB.status) {
    const existingEmail = await User.findOne({ email: email });

    if (existingEmail) {
      const user = await User.findOne({ email: email });
      const token = await user.generateAuthToken();
      res.status(200).send({
        status: "Successful",
        user,
        token,
      });
    } else {
      if (email.includes("@bitmesra.ac.in")) {
        const user = new User({ email: email });
        await user.save();
        const token = await user.generateAuthToken();
        res.status(200).send({
          status: "Successful",
          user,
          token,
        });
      } else {
        res.send({
          status: "Failed",
          message: "Enter your institute email id",
        });
      }
    }
  } else {
    res.status(200).send({ status: "Failed", message: "Wrong OTP entered" });
  }
};

//generate paircode function
exports.generatePairCode = async (req, res) => {
  const genPairCode = generateOTP(6);

  const paircodebody = {
    owner: req.user,
    paircode: genPairCode,
  };

  const paircode = new Paircode(paircodebody);

  await paircode.save();

  setTimeout(async () => {
    await Paircode.findByIdAndDelete({ _id: paircode._id });
  }, 100000);

  res.json({
    status: "Successful",
    code: genPairCode,
  });
};

// match pair code
exports.matchPairCode = async (req, res) => {
  const paircode = req.body.paircode;

  const pairbody = await Paircode.findOne({ paircode });

  const userA = await User.findOneAndUpdate(
    { _id: pairbody.owner },
    { pairedWith: req.user, isPaired: true }
  );

  const userB = await User.findOneAndUpdate(
    { _id: req.user._id },
    { pairedWith: pairbody.owner, isPaired: true }
  );

  res.send({ status: "Successful", userA, userB });
};

//logout
exports.logout = async (req, res) => {
  try {
    req.user.tokens = req.user.tokens.filter((token) => {
      return token.token !== req.token;
    });
    await req.user.save();

    res.send();
  } catch (e) {
    res.status(500).send();
  }
};

//google login
exports.googlelogin = async (req, res) => {
  const userBody = req.body;
  const existingEmail = await User.findOne({ email: userBody.email });

  if (existingEmail) {
    const user = await User.findOne({ email: userBody.email });
    const token = await user.generateAuthToken();
    res.status(200).send({
      status: "Successful",
      user,
      token,
    });
  } else {
    if (userBody.email.includes("@bitmesra.ac.in")) {
      const user = new User({ email: userBody.email, name: userBody.name });
      await user.save();
      const token = await user.generateAuthToken();
      res.status(200).send({
        status: "Successful",
        user,
        token,
      });
    } else {
      res
        .status(200)
        .send({ status: "Failed", message: "Enter your institute email id" });
    }
  }
};

exports.deleteInactiveOtps = async (req, res) => {
  try {
    const filter = { status: false };
    const result = await OtpModel.deleteMany(filter);
    res
      .status(200)
      .json({ status: "Successful", message: "OTPs deleted", result });
  } catch (error) {
    console.error("Error deleting inactive OTPs:", error);
    res.status(500).json({ status: "Failed", message: error.message });
  }
};

exports.bookmarkPlan = async (req, res) => {
  const { planId, bookmark } = req.body;
  const userId = req.user._id;

  try {
    const user = await User.findById(userId);

    const plan = await PlanModel.findOne({ plan_id: planId });

    if (bookmark && !user.bookmarks.includes(plan._id)) {
      user.bookmarks.push(plan._id);
    } else if (!bookmark && user.bookmarks.includes(plan._id)) {
      user.bookmarks.pull(plan._id);
    }

    await user.save();
    res.status(200).json({
      status: "Successful",
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: "Failed", error: error.message });
  }
};

exports.feedback = async (req, res) => {
  try {
    const feedbackBody = { ...req.body, user: req.user._id };
    const feedback = new FeedbackModel(feedbackBody);

    const planId = req.body.plan;

    const updatedPlan = await CreatedPlanModel.findOneAndUpdate(
      { _id: planId },
      { $set: { feedback_given: true } },
      { new: true } // to get the updated document
    );

    await feedback.save();

    res.status(200).send({ status: "Successful", feedback });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
};
