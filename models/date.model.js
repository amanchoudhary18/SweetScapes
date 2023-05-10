const mongoose = require("mongoose");

const dateSchema = new mongoose.Schema({
  // tags
  tags: {
    // Dining Preferences
    Dine: {
      Fine_Dining: {
        type: Number,
        required: true,
        default: 0,
      },
      Decent_Dining: {
        type: Number,
        required: true,
        default: 0,
      },
      Dhabas: {
        type: Number,
        required: true,
        default: 0,
      },
      Home_Delivery: {
        type: Number,
        required: true,
        default: 0,
      },
      Take_Away: {
        type: Number,
        required: true,
        default: 0,
      },
      Home_Made: {
        type: Number,
        required: true,
        default: 0,
      },
      Cafes: {
        type: Number,
        required: true,
        default: 0,
      },
      Streetfood: {
        type: Number,
        required: true,
        default: 0,
      },
    },

    // Outing Preferences
    Outing: {
      Hills_Lakes: {
        type: Number,
        required: true,
        default: 0,
      },
      Dams_Waterfalls: {
        type: Number,
        required: true,
        default: 0,
      },
      Malls: {
        type: Number,
        required: true,
        default: 0,
      },
      Movie: {
        type: Number,
        required: true,
        default: 0,
      },
      Park: {
        type: Number,
        required: true,
        default: 0,
      },
      Picnics: {
        type: Number,
        required: true,
        default: 0,
      },
      Clubbing: {
        type: Number,
        required: true,
        default: 0,
      },
      Night_Out: {
        type: Number,
        required: true,
        default: 0,
      },
      Window_Shopping: {
        type: Number,
        required: true,
        default: 0,
      },
    },
  },

  // filter parameters
  area: {
    type: String,
  },
  people_count: {
    ["2"]: {
      type: Boolean,
      default: false,
    },
    ["3-6"]: {
      type: Boolean,
      default: false,
    },
    ["7-10"]: {
      type: Boolean,
      default: false,
    },
    [">10"]: {
      type: Boolean,
      default: false,
    },
  },
  availability: {
    monday: {
      type: Boolean,
      default: true,
    },
    tuesday: {
      type: Boolean,
      default: true,
    },
    wednesday: {
      type: Boolean,
      default: true,
    },
    thursday: {
      type: Boolean,
      default: true,
    },
    friday: {
      type: Boolean,
      default: true,
    },
    saturday: {
      type: Boolean,
      default: true,
    },
    sunday: {
      type: Boolean,
      default: true,
    },
  },

  // tile-components
  category: {
    type: String,
  },
  tile_content: {
    type: String,
  },
  price_per_head: {
    type: Number,
  },

  //detailed
  detailed_content: {
    type: String,
  },

  images: [
    {
      image: {
        type: String,
      },
    },
  ],

  travel: {
    bus: {
      contacts: [
        {
          name: {
            type: String,
          },
          number: {
            type: String,
          },
        },
      ],
      details: [
        {
          going: {
            type: Boolean,
          },
          mode: {
            type: String,
          },
          boarding_point: {
            type: String,
          },
          drop_point: {
            type: String,
          },
          boarding_time: {
            type: String,
          },
          price: {
            type: Number,
          },
          duration: {
            type: Number,
          },
        },
      ],
    },
    reserved_auto: {
      contacts: [
        {
          name: {
            type: String,
          },
          number: {
            type: String,
          },
        },
      ],
      details: [
        {
          going: {
            type: Boolean,
          },
          mode: {
            type: String,
          },
          boarding_point: {
            type: String,
          },
          drop_point: {
            type: String,
          },
          boarding_time: {
            type: String,
          },
          price: {
            type: String,
          },
          duration: {
            type: Number,
          },
        },
      ],
    },
    two_wheeler: {
      contacts: [
        {
          name: {
            type: String,
          },
          number: {
            type: String,
          },
        },
      ],
      details: [
        {
          mode: {
            type: String,
          },
          going: {
            type: Boolean,
          },

          boarding_point: {
            type: String,
          },
          drop_point: {
            type: String,
          },
          boarding_time: {
            type: String,
          },
          price: {
            type: String,
          },
          duration: {
            type: Number,
          },
        },
      ],
    },
    four_wheeler: {
      contacts: [
        {
          name: {
            type: String,
          },
          number: {
            type: String,
          },
        },
      ],
      details: [
        {
          going: {
            type: Boolean,
          },
          mode: {
            type: String,
          },

          boarding_point: {
            type: String,
          },
          drop_point: {
            type: String,
          },
          boarding_time: {
            type: String,
          },
          price: {
            type: String,
          },
          duration: {
            type: Number,
          },
        },
      ],
    },
    personal: [
      {
        going: {
          type: Boolean,
        },
        mode: {
          type: String,
        },
        boarding_point: {
          type: String,
        },
        drop_point: {
          type: String,
        },
        boarding_time: {
          type: String,
        },
        duration: {
          type: Number,
        },
      },
    ],
  },

  dine: [
    {
      isHighlight: {
        type: Boolean,
      },
      boarding_point: {
        type: String,
      },
      tag: {
        type: String,
      },
      hotel_name: {
        type: String,
      },
      contact: {
        name: {
          type: String,
        },
        number: {
          type: String,
        },
      },

      menu: {
        type: String,
      },

      description: {
        type: String,
      },
      rating: {
        type: Number,
      },
      price_per_head: {
        type: Number,
      },
      map_link: {
        type: String,
      },
      boarding_time: {
        type: String,
      },
      website_link: {
        type: String,
      },
    },
  ],

  place: [
    {
      isHighlight: {
        type: Boolean,
      },
      boarding_point: {
        type: String,
      },
      tag: {
        type: String,
      },
      place_name: {
        type: String,
      },
      contact: {
        name: {
          type: String,
        },
        number: {
          type: String,
        },
      },

      description: {
        type: String,
      },
      rating: {
        type: Number,
      },
      price_per_head: {
        type: Number,
      },
      map_link: {
        type: String,
      },
      boarding_time: {
        type: String,
      },
      website_link: {
        type: String,
      },
    },
  ],
});

const DateModel = mongoose.model("Date", dateSchema);

module.exports = DateModel;
