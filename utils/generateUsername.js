// generates username
function getFirstWord(str) {
  let spaceIndex = str.indexOf(" ");
  return spaceIndex === -1 ? str : str.substring(0, spaceIndex);
}

const generateUsername = (userBody) => {
  const epoch_birthday = new Date(0);
  epoch_birthday.setUTCSeconds(userBody.birthday);

  const username =
    getFirstWord(userBody.name).toLowerCase() +
    userBody.mobileNumber.toString().substring(0, 2) +
    String(epoch_birthday.getDate()).padStart(2, "0");

  return username;
};

module.exports = generateUsername;
