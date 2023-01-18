const express = require("express");
const mongoose = require("mongoose");
const session = require("express-session");
const axios = require("axios");

mongoose.connect(
  "mongodb+srv://Vallhala:amanrahul@cluster0.gtojfvz.mongodb.net/test",
  () => {
    console.log("Connected to MongoDB");
  }
);

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/api/v1/home", (req, res) => {
  res.send("Welcome to MyBespoke !");
});

const userRouter = require("./routes/user.route");
app.use("/api/v1/user", userRouter);

app.listen(5000, () => {
  console.log(`Server started on port 5000`);
});
