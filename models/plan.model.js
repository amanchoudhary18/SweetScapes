const mongoose = require("mongoose");

const planSchema = {
  plan_id: { type: String, required: true, unique: true, index: true },

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
      name: {
        type: String,
      },
      img: {
        type: String,
      },
      tag: {
        type: String,
      },
      price: {
        type: Number,
      },
      component_id: {
        type: mongoose.Schema.Types.ObjectId,
        refPath: "components.type",
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

  tile_content: {
    type: String,
  },
  approved: {
    type: Number,
    default: 0,
  },
  created_at: { type: Date, required: true, default: Date.now },
};

const PlanModel = mongoose.model("Plan", planSchema);

module.exports = PlanModel;
