const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const validator = require("validator");

const userSchema = new mongoose.Schema(
  {
    // name
    name: {
      type: String,
      required: true,
    },
    // password stored in hash form
    password: {
      type: String,
      required: true,
    },
    // email assosciated
    email: {
      type: String,
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
      required: true,
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
      enum: ["Male", "Female", "Others"],
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
          type: Boolean,
          default: false,
        },
        Decent_Dining: {
          type: Boolean,
          default: false,
        },
        Dhabas: {
          type: Boolean,
          default: false,
        },
        Home_Delivery: {
          type: Boolean,
          default: false,
        },
        Take_Away: {
          type: Boolean,
          default: false,
        },
        Home_Made: {
          type: Boolean,
          default: false,
        },
        Cafes: {
          type: Boolean,
          default: false,
        },
      },

      // Outing Preferences
      Outing: {
        Hills_Lakes: {
          type: Boolean,
          default: false,
        },
        Dams_Waterfalls: {
          type: Boolean,
          default: false,
        },
        Malls: {
          type: Boolean,
          default: false,
        },
        Movie: {
          type: Boolean,
          default: false,
        },
        Park: {
          type: Boolean,
          default: false,
        },
        Picnics: {
          type: Boolean,
          default: false,
        },
        Clubbing: {
          type: Boolean,
          default: false,
        },
        Night_Out: {
          type: Boolean,
          default: false,
        },
        Window_Shopping: {
          type: Boolean,
          default: false,
        },
      },
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
    token: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

// generates authentication token and stores it and then updates the document
userSchema.methods.generateAuthToken = async function () {
  const user = this;
  const token = jwt.sign({ _id: user.id.toString() }, process.env.JWT_SECRET); // adding user id to payload of the token which would be decoded after verify method is called
  user.token = token;
  await user.save();
  return token;
};

// deletes password, token and otp from user document when sending the response.
userSchema.methods.toJSON = function () {
  const user = this;
  const userObject = user.toObject();
  delete userObject.password;
  delete userObject.token;
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
