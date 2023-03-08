const mongoose = require("mongoose");

const dateSchema = new mongoose.Schema({
  // tags
  tags: {
    // Dining Preferences
    Dine: {
      Fine_Dining: {
        type:Number,
        required: true,
      },
      Decent_Dining: {
        type:Number,
        required: true,
      },
      Dhabas: {
        type:Number,
        required: true,
      },
      Home_Delivery: {
        type:Number,
        required: true,
      },
      Take_Away: {
        type:Number,
        required: true,
      },
      Home_Made: {
        type:Number,
        required: true,
      },
      Cafes: {
        type:Number,
        required: true,
      },
    },

    // Outing Preferences
    Outing: {
      Hills_Lakes: {
        type:Number,
        required: true,
      },
      Dams_Waterfalls: {
        type:Number,
        required: true,
      },
      Malls: {
        type:Number,
        required: true,
      },
      Movie: {
        type:Number,
        required: true,
      },
      Park: {
        type:Number,
        required: true,
      },
      Picnics: {
        type:Number,
        required: true,
      },
      Clubbing: {
        type:Number,
        required: true,
      },
      Night_Out: {
        type:Number,
        required: true,
      },
      Window_Shopping: {
        type:Number,
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
            type: Number,
          },
        },
      ],
      reserved_auto: {mode: {
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
      two_wheeler: {mode: {
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
      four_wheeler: {mode: {
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

    place: [
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
