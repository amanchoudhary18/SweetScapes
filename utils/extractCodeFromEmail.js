function extractCodeFromEmail(email) {
  const regex = /btech(\d{5})\.(\d{2})@bitmesra\.ac\.in/;
  const match = email.match(regex);
  if (match && match.length === 3) {
    return `${match[1]}${match[2]}`;
  } else {
    return null;
  }
}

// const testEmail = "btech12345.20@gmail.com";
// const code = extractCodeFromEmail(testEmail);
// console.log(code);

module.exports = extractCodeFromEmail;
