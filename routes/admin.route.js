const bcrypt = require("bcryptjs");
const sgMail = require("@sendgrid/mail");
require("dotenv").config({ path: "../.env" });
const Admin = require("../models/admin.model");
const express = require("express");
const router = express.Router();
const generateRandomPassword = require("../utils/generateRandomPassword");
const adminAuth = require("../middleware/adminAuth");
const jwt = require("jsonwebtoken");
//register
router.post("/register", async (req, res) => {
  try {
    const { name, email } = req.body;
    const randomPassword = generateRandomPassword(name);
    const hashedPassword = await bcrypt.hash(randomPassword, 8);
    const admin = new Admin({ name, email, password: hashedPassword });
    await admin.save();

    // Send the random password to the user's email
    sgMail.setApiKey(process.env.SG_GRID_API);
    const msg = {
      to: email,
      from: "sweetscapes.organization@gmail.com",
      subject: "Your Registration Details",
      text: `Welcome, ${name}! Your password: ${randomPassword}`,
      cc: ["sweetscapes.organization@gmail.com"],
    };

    await sgMail.send(msg);

    res
      .status(200)
      .json({ status: "Successful", message: "Registration successful." });
  } catch (error) {
    console.log(error.response.body);
    res.status(500).json({ status: "Failed", message: "Registration failed" });
  }
});

// Login route
router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    const admin = await Admin.findOne({ email });

    if (!admin) {
      return res
        .status(401)
        .json({ status: "Failed", message: "Invalid credentials" });
    }
    const passwordMatch = await bcrypt.compare(password, admin.password);

    if (!passwordMatch) {
      return res
        .status(401)
        .json({ status: "Failed", message: "Invalid credentials" });
    }

    const token = await admin.generateAuthToken();

    res.status(200).json({
      status: "Successfull",
      message: "Login Successful",
      token: token,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: "Failed", message: "Login failed" });
  }
});

router.get("/me", adminAuth, async (req, res) => {
  console.log(req.user);
  try {
    res.status(200).json({
      status: "Successful",
      user: req.user,
    });
  } catch (error) {
    consolee.log(error);
  }
});

router.get("/check-super-admin", async (req, res, next) => {
  try {
    const token = req.headers.authorization.replace("Bearer ", "");
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const admin = await Admin.findOne({
      _id: decoded._id,
      "tokens.token": token,
      super: true,
    });

    if (!admin) {
      return res.status(403).send(false);
    }

    res.status(200).send(true);
  } catch (error) {
    console.error(error.message);
    res.status(401).send(false);
  }
});

module.exports = router;
