const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const validator = require("validator");

const userSchema = new mongoose.Schema(
  {
    // name
    name: {
      type: String,
    },
    // password stored in hash form
    password: {
      type: String,
    },
    // email assosciated
    email: {
      type: String,
      required: true,
      trim: true,
      validate(value) {
        if (!validator.isEmail(value)) {
          throw new Error("Enter valid email");
        }
      },
    },
    // mobile number assosciated
    mobileNumber: {
      type: Number,
      maxLength: 10,
      validate(value) {
        if (!validator.isMobilePhone(`${value}`)) {
          throw new Error("Enter valid mobile number");
        }
      },
    },

    // auto-generated username
    username: {
      type: String,
    },

    // age
    age: {
      type: String,
    },

    gender: {
      type: String,
    },
    avatar: {
      type: String,
    },
    birthday: {
      type: String,
    },

    // User Preferences
    preferences: {
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

    isNew: {
      type: Boolean,
      default: true,
    },

    location: {
      latitude: {
        type: String,
      },
      longitude: {
        type: String,
      },
    },

    isPaired: {
      type: Boolean,
      default: false,
    },

    isSubscribed: {
      type: Boolean,
      default: false,
    },

    pairedWith: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    tokens: [
      {
        token: {
          type: String,
          required: true,
        },
      },
    ],
  },
  {
    timestamps: true,
  }
);

// generates authentication token and stores it and then updates the document

userSchema.methods.generateAuthToken = async function () {
  const user = this;
  const token = jwt.sign({ _id: user._id.toString() }, process.env.JWT_SECRET);

  user.tokens = user.tokens.concat({ token });
  await user.save();

  return token;
};

// deletes password, token and otp from user document when sending the response.
userSchema.methods.toJSON = function () {
  const user = this;
  const userObject = user.toObject();
  delete userObject.password;
  delete userObject.tokens;
  return userObject;
};

// hashes the password as we cannot store plain text password
userSchema.pre("save", async function (next) {
  const user = this;
  if (user.isModified("password")) {
    user.password = await bcrypt.hash(user.password, 8);
  }
  next();
});

const User = mongoose.model("User", userSchema);

module.exports = User;
