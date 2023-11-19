const mongoose = require("mongoose");

const createdPlanSchema = {
  people_count: {
    type: Number,
  },

  plan_date: {
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
      tag: {
        type: String,
      },
      is_highlight: {
        type: Boolean,
        default: false,
      },
      component_id: {
        type: mongoose.Schema.Types.ObjectId,
      },
      offers: {
        status: {
          type: Boolean,
        },
        percent: {
          type: Number,
        },
        text: {
          type: String,
        },
      },
    },
  ],
  travel: {
    route: [
      {
        mode: {
          type: String,
        },
        duration: {
          type: Number,
        },
        distance: { type: String },
        boarding_point: { type: String },
        boarding_time: { type: Number },
        boarding_time_formatted: { type: String },
        drop_point: { type: String },
        drop_time: { type: Number },
        drop_time_formatted: { type: String },
        price: { type: Number },
      },
    ],
    duration: {
      type: Number,
    },
    distance: {
      type: Number,
    },
    price: {
      type: Number,
    },
  },

  tile_content: {
    type: String,
  },

  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
};

const CreatedPlanModel = mongoose.model("CreatedPlan", createdPlanSchema);

module.exports = CreatedPlanModel;
