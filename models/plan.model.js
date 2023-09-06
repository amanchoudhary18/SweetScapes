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

  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Admin",
  },

  owner_name: {
    type: String,
  },
  preferred_transport: {
    type: String,
  },

  tile_content: {
    type: String,
  },

  created_at: { type: Date, required: true, default: Date.now },
};

const PlanModel = mongoose.model("Plan", planSchema);

module.exports = PlanModel;
