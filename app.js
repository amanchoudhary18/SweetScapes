require("dotenv").config({ path: ".env" });
const express = require("express");
const mongoose = require("mongoose");
const axios = require("axios");
const generateAge = require("./utils/generateAge");
const path = require("path");
const cors = require("cors");
const OtpModel = require("./models/otp.model");

mongoose.connect(process.env.MONGODB_URI, () => {
  console.log("Connected to MongoDB");
});

const app = express();

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname + "/public")));

app.get("/api/v1/home", async (req, res) => {
  res.send("Welcome to SweetScapes !");
});

const userRouter = require("./routes/user.route");
app.use("/api/v1/user", userRouter);

const emailRouter = require("./routes/email.route");
app.use("/api/v1/email", emailRouter);

const planRouter = require("./routes/plan.route");
app.use("/api/v1/plan", planRouter);

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});
app.listen(process.env.PORT, () => {
  console.log(`Server started on ${process.env.PORT}`);
});

// delete otps
const deleteInactiveOTP = async () => {
  const otps = await OtpModel.find({});
  const filter = { status: false };
  const result = await OtpModel.deleteMany(filter);
  console.log(result);
};

setInterval(deleteInactiveOTP, 24 * 60 * 60 * 1000);

