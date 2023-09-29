function getFirstWordAndConvertToLowercase(inputString) {
  const words = inputString.split(" ");
  if (words.length > 0) {
    const firstWord = words[0].toLowerCase();
    return firstWord;
  } else {
    return "";
  }
}

function generateRandomPassword(name) {
  const extractName = getFirstWordAndConvertToLowercase(name);
  const randomDigits = Math.floor(1000 + Math.random() * 9000);
  const password = `${extractName}-ss-${randomDigits}`;

  return password;
}

module.exports = generateRandomPassword;
