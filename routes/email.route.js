const express = require("express");
const EmailModel = require("../models/email.model");
const router = express.Router();

router.post("/addEmail", async (req, res) => {
  const emailBody = req.body;
  try {
    const existingEmail = await EmailModel.findOne({
      email: emailBody.email,
    });
    if (existingEmail) {
      res
        .status(200)
        .send({ status: "Email Already Added", email: emailBody.email });
    } else {
      const email = new EmailModel(emailBody);
      email.save();
      res.status(200).send({ status: "Successful", email: email.email });
    }
  } catch (error) {
    res.status(500).send({ status: "Failed", message: error.message });
  }
});

module.exports = router;
