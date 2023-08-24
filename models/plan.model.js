const mongoose = require("mongoose");

const planSchema = {
  plan_id: { type: String, required: true, unique: true },
  plan_start_time: {
    type: Number,
  },

  components: [
    {
      order: {
        type: Number,
      },
      type: {
        type: String,
      },

      is_highlight: {
        type: Boolean,
        default: false,
      },
      component_id: {
        type: mongoose.Schema.Types.ObjectId,
      },
    },
  ],

  preferred_transport: {
    type: String,
  },

  tile_content: {
    type: String,
  },
};

const PlanModel = mongoose.model("Plan", planSchema);

module.exports = PlanModel;
