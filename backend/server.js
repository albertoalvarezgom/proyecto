// REQUIRES
require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const fileUpload = require('express-fileupload');

const {
  userAuthenticated,
  userIsAdmin
} = require('./authentication/authentication.js');

const { showHome } = require('./controllers/home/homeControllers.js');

const {
  newUser,
  validateUser,
  loginUser,
  updatePasswordUser,
  getUsers,
  viewUser,
  editUser,
  deleteUser
} = require('./controllers/user/userControllers.js');

const {
  getRooms,
  viewRoom,
  newRoom,
  editRoom,
  deleteRoom
} = require('./controllers/room/roomControllers.js');

const {
  voteUser,
  voteRoom,
  getVotes,
  editVote
} = require('./controllers/vote/voteControllers.js');

const {
  newBooking,
  showBooking,
  editBooking,
  acceptBooking,
  declineBooking,
  deleteBooking,
  getBookings
} = require('./controllers/booking/bookingControllers.js');

const {
  getMessage,
  sendMessage,
  deleteMessage
} = require('./controllers/messages/messageControllers.js');

const app = express();
const port = process.env.PORT;

// MIDDLEWARES
app.use(morgan('dev'));
app.use(cors());
app.use(bodyParser.json());
app.use(fileUpload());

// HOME
app.get('/', showHome);

//Mirar el orden de las rutas

// RUTAS DE USUARIOS
app.post('/user', newUser);
app.get('/user/validate', validateUser);
//Crear ruta solo para admin para validar usuarios si hay algún problema con el email
app.post('/user/login', loginUser);
app.post('/user/:id/password', userAuthenticated, updatePasswordUser);
app.get('/user/', getUsers);
app.get('/user/:id', viewUser);
app.put('/user/:id', userAuthenticated, editUser);
app.delete('/user/:id', userAuthenticated, userIsAdmin, deleteUser);

// RUTAS DE PISOS
app.get('/room', getRooms);
app.get('/room/:id', viewRoom);
app.post('/room', userAuthenticated, newRoom);
app.put('/room/:id', userAuthenticated, editRoom);
app.delete('/room/:id', userAuthenticated, deleteRoom);

// RUTAS DE VOTO
app.post('/user/:id/vote', userAuthenticated, voteUser);
app.get('/user/:id/vote', getVotes);
app.put('/user/:id/vote', userAuthenticated, editVote);
app.post('/room/:id/vote', userAuthenticated, voteRoom);
app.get('/room/:id/vote', getVotes);
app.put('/room/:id/vote', userAuthenticated, editVote);

// RUTAS DE RESERVA
app.post('/room/:id/booking', userAuthenticated, newBooking);
app.get('/room/:id/booking/:id', userAuthenticated, showBooking);
app.get('/room/:id/booking/', userAuthenticated, userIsAdmin, getBookings);
app.put('/room/:id/booking/:id', userAuthenticated, editBooking);
app.delete(
  '/room/:id/booking/:id',
  userAuthenticated,
  userIsAdmin,
  deleteBooking
);
app.get('/room/:id/booking/:id/accept', userAuthenticated, acceptBooking);
app.get('/room/:id/booking/:id/decline', userAuthenticated, declineBooking);

//MENSAJES
//Página que lista mensajes (crear tabla en la BBDD de mensajes, relacionada con reserva, con el
//id de los usuarios que participan y el contenido del mensaje) y ahí meter socket
//para que cargue con un setInterval

// RUTAS DE MENSAJES
app.get('/booking/:id/messages', userAuthenticated, getMessage);
app.post('/booking/:id/messages/:id', userAuthenticated, sendMessage);
app.delete(
  '/booking/:id/messages/:id',
  userAuthenticated,
  userIsAdmin,
  deleteMessage
);

//Cuando buscas usuario:
//Ordenar usuarios por afinidad, que se muestren por orden descendente
//Crear campo en usuarios de dónde buscan piso

//Mirar fileupload para subir varios archivos

//OPCIÓN DE SOBRADO --> SECCIÓN DONDE LA GENTE SE JUNTE POR AFINIDAD PARA ALQUILAR JUNTOS UN PISO

// ERROR MIDDLEWARES
app.use((error, request, response, next) => {
  console.log(error);
  response
    .status(error.httpCode || 500)
    .send({ status: 'error', message: error.message });
});

app.use((request, response) => {
  response.status(404).send({ status: 'error', message: 'NOT FOUND' });
});

// SERVIDOR
app.listen(port, () => {
  console.log(`Servidor funcionando en http://localhost:${port}`);
});
