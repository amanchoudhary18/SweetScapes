const User = require("../models/user.model");
const bcrypt = require("bcryptjs");
const generateOTP = require("../utils/generateOTP");
const Paircode = require("../models/paircode.model");
const { sendotp } = require("../utils/sendOTP");
const OtpModel = require("../models/otp.model");
const generateUsername = require("../utils/generateUsername");
const generateAge = require("../utils/generateAge");

//register function
exports.register = async (req, res) => {
  const userBody = req.body;

  if (!userBody.email.includes("@bitmesra.ac.in")) {
    res
      .status(200)
      .send({ status: "Failed", message: "Enter your institute email id" });
  } else {
    const existingEmailUser = await User.findOne({
      email: userBody.email,
    });
    const user = new User(userBody);
    if (userBody.email) {
      if (!existingEmailUser) {
        try {
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
            console.log("executing otp timeout");
            const otpupdate = await OtpModel.findOneAndUpdate(
              { _id: otpsave._id },
              { otp: otp, status: false }
            );
            console.log(otpupdate);
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
        } catch (err) {
          res.status(200).send({
            status: "Failed",
            message: err.message,
          });
        }
      } else {
        res.status(200).send({
          status: "Failed",
          message: "Email is already in use",
        });
      }
    } else {
      res.status(200).send({
        status: "Failed",
        message: "Send a email or password in request.",
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
      console.log(user);
      if (user) {
        const isMatch = await bcrypt.compare(userBody.password, user.password);
        console.log(isMatch);

        const token = await user.generateAuthToken();
        if (isMatch) {
          res.status(200).send({ status: "Successful", user, token });
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
      message: "Enter valid email",
    });
  }
};

// my data function
exports.mydata = async (req, res) => {
  res.send(req.user);
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

  console.log(req.body);

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(404);
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
          console.log(preferences.Dine);
          //Dining Preferences
          if (preferences.Dine.Fine_Dining !== undefined)
            user.preferences.Dine.Fine_Dining = preferences.Dine.Fine_Dining
              ? 1
              : 0
              ? 1
              : 0;
          if (preferences.Dine.Decent_Dining !== undefined)
            user.preferences.Dine.Decent_Dining = preferences.Dine.Decent_Dining
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
          if (preferences.Outing.Malls !== undefined)
            user.preferences.Outing.Malls = preferences.Outing.Malls ? 1 : 0;
          if (preferences.Outing.Movie !== undefined)
            user.preferences.Outing.Movie = preferences.Outing.Movie ? 1 : 0;
          if (preferences.Outing.Park !== undefined)
            user.preferences.Outing.Park = preferences.Outing.Park ? 1 : 0;
          if (preferences.Outing.Picnics !== undefined)
            user.preferences.Outing.Picnics = preferences.Outing.Picnics
              ? 1
              : 0;
          if (preferences.Outing.Clubbing !== undefined)
            user.preferences.Outing.Clubbing = preferences.Outing.Clubbing
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
      res.send({ status: "Successful", user });
    } catch (error) {
      res.send({ status: "Failed", message: error.message });
      console.log(error);
    }
  }
};

//update birthday and gender and send preferences
exports.updateInitial = async (req, res) => {
  const { gender, birthday } = req.body;

  console.log(req.body);

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(404);
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
        "Malls",
        "Movie",
        "Park",
        "Picnics",
        "Clubbing",
        "Night Out",
        "Window Shopping",
      ];
      user.save();
      res.send({ status: "Successful", dining, outing });
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
    res.status(404);
    throw new Error("User Not Found");
  } else {
    try {
      if (preferences) {
        if (preferences.Dine) {
          console.log(preferences.Dine);
          //Dining Preferences
          if (preferences.Dine.Fine_Dining !== undefined)
            user.preferences.Dine.Fine_Dining = preferences.Dine.Fine_Dining
              ? 1
              : 0
              ? 1
              : 0;
          if (preferences.Dine.Decent_Dining !== undefined)
            user.preferences.Dine.Decent_Dining = preferences.Dine.Decent_Dining
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
          if (preferences.Outing.Malls !== undefined)
            user.preferences.Outing.Malls = preferences.Outing.Malls ? 1 : 0;
          if (preferences.Outing.Movie !== undefined)
            user.preferences.Outing.Movie = preferences.Outing.Movie ? 1 : 0;
          if (preferences.Outing.Park !== undefined)
            user.preferences.Outing.Park = preferences.Outing.Park ? 1 : 0;
          if (preferences.Outing.Picnics !== undefined)
            user.preferences.Outing.Picnics = preferences.Outing.Picnics
              ? 1
              : 0;
          if (preferences.Outing.Clubbing !== undefined)
            user.preferences.Outing.Clubbing = preferences.Outing.Clubbing
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
      // if (user.name && user.mobileNumber && user.birthday) {
      //   user.username = generateUsername(user);
      // }
      user.save();
      res.send({ status: "Successful", user });
    } catch (error) {
      res.send({ status: "Failed", message: error.message });
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
    const user = new User({ email });
    await user.save();
    const token = await user.generateAuthToken();

    res.status(200).send({
      status: "Successful",
      message: "Email verified",
      user,
      token,
    });
  } else {
    res.status(400).send({ status: "Failed", message: "Wrong OTP entered" });
  }
};

//generate paircode function
exports.generatePairCode = async (req, res) => {
  const genPairCode = generateOTP(6);
  console.log(genPairCode);
  const paircodebody = {
    owner: req.user,
    paircode: genPairCode,
  };

  const paircode = new Paircode(paircodebody);
  console.log(paircode);
  await paircode.save();

  setTimeout(async () => {
    console.log("Deleted the Paircode ");
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
  console.log(pairbody);
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
      res.send({ status: "Failed", message: "Enter your institute email id" });
    }
  }
};
