const jwt = require("jsonwebtoken");
const Admin = require("../models/admin.model");

const adminAuth = async (req, res, next) => {
  try {
    const token = req.headers.authorization.replace("Bearer ", "");
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const admin = await Admin.findOne({
      _id: decoded._id,
      "tokens.token": token,
    });
    if (!admin) {
      throw new Error();
    }
    req.token = token;
    req.user = admin;
    next();
  } catch (error) {
    console.log(error.message);
    res.status(401).send({ status: "Failed", message: "Please authenticate." });
  }
};

module.exports = adminAuth;
