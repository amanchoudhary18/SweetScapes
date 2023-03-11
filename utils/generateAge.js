const generateAge = (birthday) => {
  var epoch_birthday = new Date(0);
  epoch_birthday.setUTCSeconds(birthday);
  var ageDifMs = Date.now() - epoch_birthday;

  var ageDate = new Date(ageDifMs); // miliseconds from epoch
  return Math.abs(ageDate.getUTCFullYear() - 1970);
};

module.exports = generateAge;
