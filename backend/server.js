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
const { likeUser } = require('./controllers/user/likeUser.js');
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

// MATCH CONTROLLERS
const { getMatches } = require('./controllers/matches/getMatches.js');
const { cancelMatch } = require('./controllers/matches/cancelMatch.js');

// MESSAGES CONTROLLERS
const { getMessages } = require('./controllers/messages/getMessages.js');
const { sendMessage } = require('./controllers/messages/sendMessage.js');
const { deleteMessage } = require('./controllers/messages/deleteMessage.js');

// BOOKING CONTROLLERS
const { requestBooking } = require('./controllers/booking/requestBooking.js');
const { acceptBooking } = require('./controllers/booking/acceptBooking.js');
// const { editBooking } = require('./controllers/booking/editBooking.js');
const { viewBooking } = require('./controllers/booking/viewBooking.js');
const { deleteBooking } = require('./controllers/booking/deleteBooking.js');
const { getBookings } = require('./controllers/booking/getBookings.js');
const { finishBooking } = require('./controllers/booking/finishBooking.js');

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
app.put('/user/:id/like', userAuthenticated, likeUser); //Hecho
app.get('/user/:id', userAuthenticated, viewUser); //Hecho
app.put('/user/:id', userAuthenticated, editUser); //Hecho
app.delete('/user/:id', userAuthenticated, userIsAdmin, deleteUser); //Hecho
app.put('/user/:id/hide', userAuthenticated, hideUser); //Hecho
app.put('/user/:id/show', userAuthenticated, showUser); //Hecho
app.put('/user/:id/restore', userAuthenticated, restorePassword); //Hecho

// RUTAS DE HABITACIONES
app.post('/room', userAuthenticated, newRoom); //Hecho
app.put('/room/:id/edit', userAuthenticated, editRoom); //Hecho
app.get('/room', getRooms); //Hecho
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

// RUTAS DE MATCHES
app.get('/user/:id/matches', userAuthenticated, getMatches); //Hecho
app.delete('/user/:id/matches/:id', userAuthenticated, cancelMatch); //Hecho

// RUTAS DE MENSAJES
app.get('/user/:id/matches/:id', userAuthenticated, getMessages); //Hecho
app.post('/user/:id/matches/:id', userAuthenticated, sendMessage); //Hecho
app.delete(
  '/user/:id/matches/:id/message/:id',
  userAuthenticated,
  userIsAdmin,
  deleteMessage
); //Hecho

// RUTAS DE RESERVA
app.post('/user/:id/matches/:id/booking', userAuthenticated, requestBooking); //Hecho
app.get('/matches/:id/booking/accept', acceptBooking); //Hecho
app.get('/user/:id/booking', userAuthenticated, getBookings); //Hecho
app.get('/user/:iduser/booking/:idbooking', userAuthenticated, viewBooking); //Hecho
// app.put('/room/:id/booking/:id', userAuthenticated, editBooking); //Mandar mail a la otra persona solicitando un cambio en la reserva (aclarar que esto se hace para que quede por escrito)
app.put(
  '/user/:iduser/booking/:idbooking/finish',
  userAuthenticated,
  finishBooking
); //Hecho
app.delete(
  '/user/:iduser/booking/:idbooking',
  userAuthenticated,
  userIsAdmin,
  deleteBooking
); //Hecho

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
