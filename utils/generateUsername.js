// generates username
function getFirstWord(str) {
  let spaceIndex = str.indexOf(" ");
  return spaceIndex === -1 ? str : str.substring(0, spaceIndex);
}

const generateUsername = (userBody) => {
  const username =
    getFirstWord(userBody.name).toLowerCase() +
    userBody.mobileNumber.toString().substring(0, 2) +
    userBody.mobileNumber.toString().substring(8, 10);

  return username;
};

module.exports = generateUsername;
