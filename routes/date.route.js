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

router.get("/dates", userAuth, async (req, res) => {
  try {
    const dates = await DateModel.find({});
    const userPreferences = req.user.preferences;
    const dateData = dates.map((date) => {
      const {
        category,
        availability,
        area,
        people_count,
        tile_content,
        price_per_head,
        tags,
        _id,
      } = date;

      let dineCount = 0;
      let outingCount = 0;

      // Dining
      if (tags.Dine.Fine_Dining === userPreferences.Dine.Fine_Dining)
        dineCount++;
      if (tags.Dine.Decent_Dining === userPreferences.Dine.Decent_Dining)
        dineCount++;
      if (tags.Dine.Dhabas === userPreferences.Dine.Dhabas) dineCount++;
      if (tags.Dine.Home_Delivery === userPreferences.Dine.Home_Delivery)
        dineCount++;
      if (tags.Dine.Take_Away === userPreferences.Dine.Take_Away) dineCount++;
      if (tags.Dine.Home_Made === userPreferences.Dine.Home_Made) dineCount++;
      if (tags.Dine.Cafes === userPreferences.Dine.Cafes) dineCount++;
      if (tags.Dine.Streetfood === userPreferences.Dine.Streetfood) dineCount++;

      // Outing
      if (tags.Outing.Hills_Lakes === userPreferences.Outing.Hills_Lakes)
        outingCount++;
      if (
        tags.Outing.Dams_Waterfalls === userPreferences.Outing.Dams_Waterfalls
      )
        outingCount++;
      if (tags.Outing.Malls === userPreferences.Outing.Malls) outingCount++;
      if (tags.Outing.Movie === userPreferences.Outing.Movie) outingCount++;
      if (tags.Outing.Park === userPreferences.Outing.Park) outingCount++;
      if (tags.Outing.Picnics === userPreferences.Outing.Picnics) outingCount++;
      if (tags.Outing.Clubbing === userPreferences.Outing.Clubbing)
        outingCount++;
      if (
        tags.Outing.Window_Shopping === userPreferences.Outing.Window_Shopping
      )
        outingCount++;
      if (tags.Outing.Night_Out === userPreferences.Outing.Night_Out)
        outingCount++;

      // Calculate likeness
      const likeness = dineCount + outingCount;

      const updatedDate = {
        likeness,
        category,
        availability,
        area,
        people_count,
        tile_content,
        price_per_head,
        tags,
      };

      updatedDate.sort(function (a, b) {
        if (a.likeness < b.likeness) return -1;
        else return 1;
      });

      return updatedDate;
    });

    console.log(dateData.length);
    res.status(200).send({ status: "Successful", dateData });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

// router.get("/:id", userAuth, async (req, res) => {
//   try {
//     const dates = await DateModel.findById(req.params.id);
//     res.status(200).send({ status: "Successful", dates });
//   } catch (error) {
//     res.status(500).send({ status: "Failed", message: error.message });
//   }
// });

router.get("/:id", userAuth, async (req, res) => {
  try {
    const date = await DateModel.findById(req.params.id);
    const {
      tags,
      area,
      people_count,
      availability,
      category,
      tile_content,
      price_per_head,
      detailed_content,
      images,
    } = date;

    // Bus Sort
    const busMerge = [...date.travel.bus.details, ...date.place, ...date.dine];
    busMerge.sort(function (a, b) {
      return a.boarding_time.localeCompare(b.boarding_time);
    });

    // Reserved Auto Sort
    const autoMerge = [
      ...date.travel.reserved_auto.details,
      ...date.place,
      ...date.dine,
    ];
    autoMerge.sort(function (a, b) {
      return a.boarding_time.localeCompare(b.boarding_time);
    });

    // Two Wheeler Sort
    const twoMerge = [
      ...date.travel.two_wheeler.details,
      ...date.place,
      ...date.dine,
    ];
    twoMerge.sort(function (a, b) {
      return a.boarding_time.localeCompare(b.boarding_time);
    });

    // Four Wheeler Sort
    const fourMerge = [
      ...date.travel.four_wheeler.details,
      ...date.place,
      ...date.dine,
    ];
    fourMerge.sort(function (a, b) {
      return a.boarding_time.localeCompare(b.boarding_time);
    });

    // Personal Sort
    const personalMerge = [
      ...date.travel.personal,
      ...date.place,
      ...date.dine,
    ];
    personalMerge.sort(function (a, b) {
      return a.boarding_time.localeCompare(b.boarding_time);
    });

    const updatedDate = {
      tags,
      area,
      people_count,
      availability,
      category,
      tile_content,
      price_per_head,
      detailed_content,
      images,
      itenary: {
        bus: busMerge,
        reserved_auto: autoMerge,
        two_wheeler: twoMerge,
        four_wheeler: fourMerge,
        personal: personalMerge,
      },
    };

    res.status(200).send({ status: "Successful", updatedDate });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;
