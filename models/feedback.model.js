const mongoose = require("mongoose");

const feedbackModel = new mongoose.Schema({
  feedback_text: {
    type: String,
  },
  hasVisited: {
    type: Boolean,
  },
  plan: {
    type: mongoose.Schema.Types.ObjectId,
    refPath: "CreatedPlan",
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    refPath: "User",
  },
});

const FeedbackModel = mongoose.model("Feedback", feedbackModel);

module.exports = FeedbackModel;
