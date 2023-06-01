require("dotenv").config({ path: "./config/.env" });
const express = require("express");
const mongoose = require("mongoose");
const axios = require("axios");
const generateAge = require("./utils/generateAge");
const path = require("path");
const cors = require("cors");

mongoose.connect(process.env.MONGODB_URI, () => {
  console.log("Connected to MongoDB");
});

const app = express();

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname + "/public")));

app.get("/api/v1/home", (req, res) => {
  res.send("Welcome to SweetScapes !");
});

const userRouter = require("./routes/user.route");
app.use("/api/v1/user", userRouter);

const dateRouter = require("./routes/date.route");
app.use("/api/v1/date", dateRouter);

const emailRouter = require("./routes/email.route");
app.use("/api/v1/email", emailRouter);

app.listen(process.env.PORT, () => {
  console.log(`Server started on ${process.env.PORT}`);
});
