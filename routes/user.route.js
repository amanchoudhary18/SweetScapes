const express = require("express");
const User = require("../models/user.model");
const router = express.Router();

// sign up route
router.post("/register", async (req, res) => {
  const userBody = req.body;

  if (userBody.email || userBody.mobileNumber) {
    const user = new User(userBody);

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
      message: "Send an email or password in request.",
    });
  }
});

// login route
router.post("/login", async (req, res) => {
  const userBody = req.body;
  if (userBody.email || userBody.mobileNumber) {
    if (userBody.email) {
      try {
        const user = await User.findOne({ email: userBody.email });
        if (user) {
          const isMatch = await bcrypt.compare(
            userBody.password,
            user.password
          );
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
    } else if (userBody.mobileNumber) {
      try {
        const user = await User.findOne({
          mobileNumber: userBody.mobileNumber,
        });
        console.log(user);
        if (user) {
          const isMatch = await bcrypt.compare(
            userBody.password,
            user.password
          );
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
        message: "Enter valid email or mobile number",
      });
    }
  } else {
    res.status(200).send({
      status: "Failed",
      message: "Enter valid email or mobile number",
    });
  }
});

module.exports = router;
