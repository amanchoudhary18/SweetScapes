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

      // Dining
      const likeness =
        (tags.Dine.Fine_Dining * userPreferences.Dine.Fine_Dining +
          tags.Dine.Decent_Dining * userPreferences.Dine.Decent_Dining +
          tags.Dine.Dhabas * userPreferences.Dine.Dhabas +
          tags.Dine.Home_Delivery * userPreferences.Dine.Home_Delivery +
          tags.Dine.Take_Away * userPreferences.Dine.Take_Away +
          tags.Dine.Home_Made * userPreferences.Dine.Home_Made +
          tags.Dine.Cafes * userPreferences.Dine.Cafes +
          tags.Dine.Streetfood * userPreferences.Dine.Streetfood +
          tags.Outing.Hills_Lakes * userPreferences.Outing.Hills_Lakes +
          tags.Outing.Dams_Waterfalls * userPreferences.Outing.Dams_Waterfalls +
          tags.Outing.Malls * userPreferences.Outing.Malls +
          tags.Outing.Movie * userPreferences.Outing.Movie +
          tags.Outing.Park * userPreferences.Outing.Park +
          tags.Outing.Picnics * userPreferences.Outing.Picnics +
          tags.Outing.Clubbing * userPreferences.Outing.Clubbing +
          tags.Outing.Window_Shopping * userPreferences.Outing.Window_Shopping +
          tags.Outing.Night_Out * userPreferences.Outing.Night_Out) /
        17;

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

      return updatedDate;
    });
    dateData.sort(function (a, b) {
      if (a.likeness < b.likeness) return -1;
      else return 1;
    });

    res.status(200).send({ status: "Successful", date: dateData });
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
    console.log(date);
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

    // Contacts
    const busContacts = date.travel.bus.contacts;
    const reservedAutoContacts = date.travel.reserved_auto.contacts;
    const twoWheelerContacts = date.travel.two_wheeler.contacts;
    const fourWheelerContacts = date.travel.four_wheeler.contacts;

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
        bus: { route: busMerge, contacts: busContacts },
        reserved_auto: { route: autoMerge, contacts: reservedAutoContacts },
        two_wheeler: { route: twoMerge, contacts: twoWheelerContacts },
        four_wheeler: { route: fourMerge, contacts: fourWheelerContacts },
        personal: { route: personalMerge },
      },
    };

    res.status(200).send({ status: "Successful", date: updatedDate });
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;
