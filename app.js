require("dotenv").config({ path: "./config/.env" });
const express = require("express");
const mongoose = require("mongoose");
const axios = require("axios");
const generateAge = require("./utils/generateAge");

mongoose.connect(process.env.MONGODB_URI, () => {
  console.log("Connected to MongoDB");
});

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/api/v1/home", (req, res) => {
  res.send("Welcome to MyBespoke !");
});

const userRouter = require("./routes/user.route");
app.use("/api/v1/user", userRouter);

app.listen(process.env.PORT, () => {
  console.log(`Server started on ${process.env.PORT}`);
});
