function extractCodeFromEmail(email) {
  const code = email
    .substring(0, email.indexOf("@"))
    .replace(".", "")
    .toUpperCase();
  console.log(code);
  return code;
}

// const testEmail = "btech12345.20@gmail.com";
// const code = extractCodeFromEmail(testEmail);
// console.log(code);

module.exports = extractCodeFromEmail;
