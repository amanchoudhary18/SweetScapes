const mongoose = require("mongoose");

const emailModel = new mongoose.Schema({
  email: {
    type: String,
    required: true,
  },
});

const EmailModel = mongoose.model("Email", emailModel);

module.exports = EmailModel;
