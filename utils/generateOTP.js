// generates n digit otp

function generateOTP(length) {
  // The first digit of the OTP should be between 1 and 9
  let otp = "" + Math.floor(Math.random() * 9 + 1);

  // Generate remaining digits of the OTP
  for (let i = 1; i < length; i++) {
    otp += Math.floor(Math.random() * 10);
  }

  return otp;
}

module.exports = generateOTP;
