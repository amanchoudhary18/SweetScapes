const mongoose = require("mongoose");

const dateSchema = new mongoose.Schema({
  // tags
  tags: {
    // Dining Preferences
    Dine: {
      Fine_Dining: {
        type:Number,
        required: true,
        default:0,
      },
      Decent_Dining: {
        type:Number,
        required: true,
        default:0,
      },
      Dhabas: {
        type:Number,
        required: true,
        default:0,
      },
      Home_Delivery: {
        type:Number,
        required: true,
        default:0,
      },
      Take_Away: {
        type:Number,
        required: true,
        default:0,
      },
      Home_Made: {
        type:Number,
        required: true,
        default:0,
      },
      Cafes: {
        type:Number,
        required: true,
        default:0,
      },
    },

    // Outing Preferences
    Outing: {
      Hills_Lakes: {
        type:Number,
        required: true,
        default:0,
      },
      Dams_Waterfalls: {
        type:Number,
        required: true,
        default:0,
      },
      Malls: {
        type:Number,
        required: true,
        default:0,
      },
      Movie: {
        type:Number,
        required: true,
        default:0,
      },
      Park: {
        type:Number,
        required: true,
        default:0,
      },
      Picnics: {
        type:Number,
        required: true,
        default:0,
      },
      Clubbing: {
        type:Number,
        required: true,
        default:0,
      },
      Night_Out: {
        type:Number,
        required: true,
        default:0,
      },
      Window_Shopping: {
        type:Number,
        required: true,
        default:0,
      },
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
);

const Date = mongoose.model("Date", dateSchema);

module.exports = Date;
