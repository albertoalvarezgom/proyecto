require("dotenv").config();

const sharp = require("sharp");
const path = require("path");
const fs = require("fs-extra");
const uuid = require("uuid");

const imageUploadPath = path.join(__dirname, process.env.UPLOADS_DIR);

//Con esta función gestionamos la subida de imágenes
async function processAndSavePhoto(uploadedImage) {
  //Generamos un id aleatorio como nombre de archivo para evitar repeticiones
  const savedFileName = `${uuid.v1()}.jpg`;

  //Nos aseguramos de que el directorio de destino de las imágenes existe
  await fs.ensureDir(imageUploadPath);

  //Cargamos la imagen en el sharp
  const finalImage = sharp(uploadedImage.data);

  //Accedemos a la metadata del fichero para saber las dimensiones
  const imageInfo = await finalImage.metadata();

  //Si la imagen tiene un ancho mayor a 500, la adaptamos a este tamaño
  if (imageInfo.width > 500) {
    finalImage.resize(500);
  }

  //Guardamos la imagen en la ruta elegida con el nombre creado
  await finalImage.toFile(path.join(imageUploadPath, savedFileName));

  //Retornamos el nombre, que es lo que guardaremos en la BBDD
  return savedFileName;
}

module.exports = { processAndSavePhoto };
