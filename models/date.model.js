const mongoose = require("mongoose");

const dateSchema = new mongoose.Schema({
  // tags
  tags: {
    // Dining Preferences
    Dine: {
      Fine_Dining: {
        type: Boolean,
        default: false,
        required: true,
      },
      Decent_Dining: {
        type: Boolean,
        default: false,
        required: true,
      },
      Dhabas: {
        type: Boolean,
        default: false,
        required: true,
      },
      Home_Delivery: {
        type: Boolean,
        default: false,
        required: true,
      },
      Take_Away: {
        type: Boolean,
        default: false,
        required: true,
      },
      Home_Made: {
        type: Boolean,
        default: false,
        required: true,
      },
      Cafes: {
        type: Boolean,
        default: false,
        required: true,
      },
    },

    // Outing Preferences
    Outing: {
      Hills_Lakes: {
        type: Boolean,
        default: false,
        required: true,
      },
      Dams_Waterfalls: {
        type: Boolean,
        default: false,
        required: true,
      },
      Malls: {
        type: Boolean,
        default: false,
        required: true,
      },
      Movie: {
        type: Boolean,
        default: false,
        required: true,
      },
      Park: {
        type: Boolean,
        default: false,
        required: true,
      },
      Picnics: {
        type: Boolean,
        default: false,
        required: true,
      },
      Clubbing: {
        type: Boolean,
        default: false,
        required: true,
      },
      Night_Out: {
        type: Boolean,
        default: false,
        required: true,
      },
      Window_Shopping: {
        type: Boolean,
        default: false,
        required: true,
      },
    },

    // filter parameters
    area: {
      type: String,
    },
    people_count: {
      type: Number,
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
        type: String,
      },
    ],

    travel: {
      bus: [
        {
          mode: {
            type: String,
          },
          contact: {
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
        },
      ],
      reserved_auto: {
        contacts: [
          {
            name: {
              type: String,
            },
            number: {
              type: Number,
            },
          },
        ],
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
      },
      two_wheeler: {
        contacts: [
          {
            name: {
              type: String,
            },
            number: {
              type: Number,
            },
          },
        ],
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
      },
      four_wheeler: {
        contacts: [
          {
            name: {
              type: String,
            },
            number: {
              type: Number,
            },
          },
        ],
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
      },
    },

    dine: [
      {
        isHighlight: {
          type: Boolean,
        },
        hotel_name: {
          type: String,
        },
        contacts: [
          {
            name: {
              type: String,
            },
            number: {
              type: Number,
            },
          },
        ],
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
      },
    ],

    dine: [
      {
        isHighlight: {
          type: Boolean,
        },
        place_name: {
          type: String,
        },
        contacts: [
          {
            name: {
              type: String,
            },
            number: {
              type: Number,
            },
          },
        ],
        description: {
          type: String,
        },
        rating: {
          type: Number,
        },
        price_per_head: {
          type: Number,
        },
      },
    ],
  },
});

const Date = mongoose.model("Date", dateSchema);

module.exports = Date;
