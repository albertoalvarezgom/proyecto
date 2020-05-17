require('dotenv').config();

const path = require('path');
const fs = require('fs-extra');
const sharp = require('sharp');
const uuid = require('uuid');
const { format } = require('date-fns');
const crypto = require('crypto');
const sgMail = require('@sendgrid/mail');
const chalk = require('chalk');

const imageUploadPath = path.join(__dirname, process.env.UPLOADS_DIR);

//Borrar imágenes
async function deletePhoto(imagePath) {
  // console.log(chalk.yellow.inverse(path.join(imageUploadPath, imagePath)));
  await fs.unlink(path.resolve(imageUploadPath, imagePath), (error) => {
    if (error) {
      console.log(chalk.red(error));
    }
  });
}

//Formatear fecha a SQL
function formatDateToDB(date) {
  return format(date, 'yyyy-MM-dd HH:mm:ss');
}

//Formatear errores
function generateError(message, code) {
  const error = new Error(message);
  if (code) error.httpCode = code;
  return error;
}

//Formatear subida de imágenes
async function processAndSavePhoto(uploadedImage) {
  const savedFileName = `${uuid.v1()}.jpg`;

  await fs.ensureDir(imageUploadPath);

  const finalImage = sharp(uploadedImage.data);

  const imageInfo = await finalImage.metadata();

  if (imageInfo.width > 500) {
    finalImage.resize(500);
  }

  await finalImage.toFile(path.join(imageUploadPath, savedFileName));

  return savedFileName;
}

//Generar un código de validación random
function randomString(size = 20) {
  return crypto.randomBytes(size).toString('hex').slice(0, size);
}

//Envío de email
async function sendEmail({ email, title, content }) {
  sgMail.setApiKey(process.env.SENDGRID_KEY);

  const message = {
    to: email,
    from: 'albertoalvarezgom@gmail.com',
    subject: title,
    text: content,
    html: `<div>
      <h1>Valida tu email</h1>
      <p>${content}</p>  
    </div>`
  };

  await sgMail.send(message);
}

module.exports = {
  deletePhoto,
  formatDateToDB,
  generateError,
  processAndSavePhoto,
  randomString,
  sendEmail
};
