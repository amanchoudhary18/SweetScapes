const express = require("express");
const DateModel = require("../models/date.model");
const router = express.Router();

router.post("/addDate", async (req, res) => {
  const dateBody = req.body;
  try {
    const date = new DateModel(dateBody);
    date.save();
    res.status(200).send({ status: "Successful", date });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

router.get("/dates", async (req, res) => {
  try {
    const dates = await DateModel.find({});
    res.status(200).send({ status: "Successful", dates });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;
