// REQUIRES
require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const fileUpload = require('express-fileupload');
const path = require('path');

const {
  userAuthenticated,
  userIsAdmin
} = require('./authentication/authentication.js');

// USER CONTROLLERS
const { newUser } = require('./controllers/user/newUser.js');
const { validateUser } = require('./controllers/user/validateUser.js');
const { loginUser } = require('./controllers/user/loginUser.js');
const { editPassword } = require('./controllers/user/editPassword.js');
const { getUsers } = require('./controllers/user/getUsers.js');
const { viewUser } = require('./controllers/user/viewUser.js');
const { editUser } = require('./controllers/user/editUser.js');
const { deleteUser } = require('./controllers/user/deleteUser.js');
const { hideUser } = require('./controllers/user/hideUser.js');
const { showUser } = require('./controllers/user/showUser.js');
const { restorePassword } = require('./controllers/user/restorePassword.js');

// ROOM CONTROLLERS
const { newRoom } = require('./controllers/room/newRoom.js');
const { editRoom } = require('./controllers/room/editRoom.js');
const { getRooms } = require('./controllers/room/getRooms.js');
const { deleteRoom } = require('./controllers/room/deleteRoom.js');
const { viewRoom } = require('./controllers/room/viewRoom.js');

// VOTE CONTROLLERS
const { voteUser } = require('./controllers/vote/voteUser.js');
const { voteRoom } = require('./controllers/vote/voteRoom.js');
const { getUserVotes } = require('./controllers/vote/getUserVotes.js');
const { getRoomVotes } = require('./controllers/vote/getRoomVotes.js');
const { editUserVote } = require('./controllers/vote/editUserVote.js');
const { editRoomVote } = require('./controllers/vote/editRoomVote.js');
const { deleteVote } = require('./controllers/vote/deleteVote.js');

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
app.use(express.static(path.join(__dirname, 'static')));

// HOME
// app.get('/', showHome);

// RUTAS DE USUARIOS
app.post('/user', newUser); //Hecho
app.get('/user/validate', validateUser); //Hecho
app.post('/user/login', loginUser); //Hecho
app.put('/user/:id/password', userAuthenticated, editPassword); //Hecho
app.get('/user', userAuthenticated, getUsers); //Hecho
app.get('/user/:id', userAuthenticated, viewUser); //Hecho
app.put('/user/:id', userAuthenticated, editUser); //Hecho
app.delete('/user/:id', userAuthenticated, userIsAdmin, deleteUser); //Hecho
app.put('/user/:id/hide', userAuthenticated, hideUser); //Hecho
app.put('/user/:id/show', userAuthenticated, showUser); //Hecho
app.put('/user/:id/restore', userAuthenticated, restorePassword); //Hecho

// RUTAS DE HABITACIONES
app.post('/room', userAuthenticated, newRoom); //Hecho
app.put('/room/:id/edit', userAuthenticated, editRoom); //Hecho
app.get('/room', userAuthenticated, getRooms); //Hecho
app.get('/room/:id', userAuthenticated, viewRoom); //Hecho
app.delete('/room/:id', userAuthenticated, deleteRoom); //Hecho

// RUTAS DE VOTO
app.post('/user/:id/vote', userAuthenticated, voteUser); //Hecho
app.get('/user/:id/vote', getUserVotes); //Hecho
app.put('/user/:id/vote', userAuthenticated, editUserVote); //Hecho
app.post('/room/:id/vote', userAuthenticated, voteRoom); //Hecho
app.get('/room/:id/vote', getRoomVotes); //Hecho
app.put('/room/:id/vote', userAuthenticated, editRoomVote); //Hecho
app.delete('/room/:id/vote/:id', userAuthenticated, userIsAdmin, deleteVote); //Hecho
app.delete('/user/:id/vote/:id', userAuthenticated, userIsAdmin, deleteVote); //Hecho

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
