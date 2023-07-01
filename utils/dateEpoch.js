const convertToEpoch = (timeString) => {
  const [hours, minutes] = timeString.split(":");

  const date = new Date();
  date.setUTCHours(hours);
  date.setUTCMinutes(minutes);

  return date.getTime();
};

// Function to convert epoch time to a formatted time string
const convertFromEpoch = (epochTime) => {
  console.log(epochTime);
  const date = new Date(epochTime);

  const hours = date.getUTCHours().toString().padStart(2, "0");
  const minutes = date.getUTCMinutes().toString().padStart(2, "0");

  return `${hours}:${minutes}`;
};

module.exports = { convertFromEpoch, convertToEpoch };
