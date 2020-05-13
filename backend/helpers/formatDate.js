const { format } = require("date-fns");

function formatDateToDB(date) {
  return format(date, "yyyy-MM-dd HH:mm:ss");
}

module.exports = { formatDateToDB };
