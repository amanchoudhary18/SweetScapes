const fast2sms = require("fast-two-sms");
const axios = require("axios")

const sendotp = async (mobile, otp) => {
  try {
    const response = await axios.get(
      `https://2factor.in/API/V1/${process.env.SMS_API_KEY}/SMS/+91${mobile}/${otp}/OTP1`
    );
    const res = response.data;
  } catch (err) {
    console.log(err);
  }
};

exports.sendotp=sendotp