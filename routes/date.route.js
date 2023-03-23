const express = require("express");
const userAuth = require("../middleware/userAuth");
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

    const dateData = dates.map(
      ({
        category,
        availability,
        area,
        people_count,
        tile_content,
        price_per_head,
        _id,
      }) => ({
        category,
        availability,
        area,
        people_count,
        tile_content,
        price_per_head,
        _id,
      })
    );

    console.log(dateData);
    res.status(200).send({ status: "Successful", dateData });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

router.get("/:id", userAuth, async (req, res) => {
  try {
    const dates = await DateModel.findById(req.params.id);
    res.status(200).send({ status: "Successful", dates });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;
