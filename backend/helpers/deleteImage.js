const path = require("path");
const fs = require("fs-extra");

async function deletePhoto(imagePath) {
  await fs.unlink(path.join(imageUploadPath, imagePath));
}
module.exports = { deletePhoto };
