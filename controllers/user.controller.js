const User = require("../models/user.model");
const bcrypt = require("bcryptjs");
const generateOTP = require("../utils/generateOTP");
const Paircode = require("../models/paircode.model");
const { sendotp } = require("../utils/sendOTP");
const OtpModel = require("../models/otp.model");
const generateUsername = require("../utils/generateUsername");

//register function
exports.register = async (req, res) => {
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
        var otpModel = { otp: otp, status: true, owner: user };
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
        message: "Mobile number is already in use",
      });
    }
  } else {
    res.status(200).send({
      status: "Failed",
      message: "Send a mobile number or password in request.",
    });
  }
};

// login function
exports.login = async (req, res) => {
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
      message: "Enter valid mobile number",
    });
  }
};

// my data function
exports.mydata = async (req, res) => {
  res.send(req.user);
};

// update user data function
exports.update = async (req, res) => {
  const { name, email, mobileNumber, gender, avatar, birthday, preferences } =
    req.body;

  const user = await User.findById(req.user._id);
  if (!user) {
    res.status(404);
    throw new Error("User Not Found");
  } else {
    try {
      if (name) user.name = name;
      if (email) user.email = email;
      if (mobileNumber) user.mobileNumber = mobileNumber;
      if (gender) user.gender = gender;
      if (avatar) user.avatar = avatar;
      if (birthday) user.birthday = birthday;

      if (preferences) {
        if (preferences.Dine) {
          //Dining Preferences
          if (preferences.Dine.Fine_Dining)
            user.preferences.Dine.Fine_Dining = true;
          if (preferences.Dine.Decent_Dining)
            user.preferences.Dine.Decent_Dining = true;
          if (preferences.Dine.Dhabas) user.preferences.Dine.Dhabas = true;
          if (preferences.Dine.Home_Delivery)
            user.preferences.Dine.Home_Delivery = true;
          if (preferences.Dine.Take_Away)
            user.preferences.Dine.Take_Away = true;
          if (preferences.Dine.Home_Made)
            user.preferences.Dine.Home_Made = true;
          if (preferences.Dine.Cafes) user.preferences.Dine.Cafes = true;
        }

        // Outing Preferences
        if (preferences.Outing) {
          if (preferences.Outing.Hills_Lakes)
            user.preferences.Outing.Hills_Lakes = true;
          if (preferences.Outing.Dams_Waterfalls)
            user.preferences.Outing.Dams_Waterfalls = true;
          if (preferences.Outing.Malls) user.preferences.Outing.Malls = true;
          if (preferences.Outing.Movie) user.preferences.Outing.Movie = true;
          if (preferences.Outing.Park) user.preferences.Outing.Park = true;
          if (preferences.Outing.Picnics)
            user.preferences.Outing.Picnics = true;
          if (preferences.Outing.Clubbing)
            user.preferences.Outing.Clubbing = true;
          if (preferences.Outing.Night_Out)
            user.preferences.Outing.Night_Out = true;
          if (preferences.Outing.Window_Shopping)
            user.preferences.Outing.Window_Shopping = true;
        }
      }

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
  const userBody = req.body.user;

  const otpDB = await OtpModel.findById(otpId);
  if (otpDB.otp == otp && otpDB.status) {
    const user = new User(userBody);
    await user.save();
    const token = await user.generateAuthToken();
    res.status(200).send({
      status: "Successful",
      user,
      token,
    });
  } else {
    res.status(400).send({ status: "Failed", message: "wrong otp entered" });
    console.log("wrong otp entered");
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
