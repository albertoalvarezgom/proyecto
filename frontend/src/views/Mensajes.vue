<template>
  <div id="matches">
    <vue-headful title="Mis mensajes" description="Mis mensajes" />
    <!-- MENU -->
    <menucustom></menucustom>
    <!-- /MENU -->
    <img src="../assets/planta4.jpg" alt="Imagen de formulario" id="planta4" />
    <!-- MATCHES -->
    <div class="matchContainer">
      <div>
        <div v-if="matches.length === 0">
          <h2>Todavía no tienes chats abiertos...</h2>
          <p>¡Dale a me gusta a tus perfiles favoritos para encontrar a tu roomie!</p>
        </div>
        <ul class="chatContainer">
          <li v-for="match in matches" :key="match.id_match" v-show="!openedChat" class="chat">
            <div>
              <img :src="match.user[0].image_1" />
              <h2
                @click="getUserInfo(match.user[0].id_user)"
                class="userMatchName"
              >{{ match.user[0].first_name }}</h2>
              <i>{{ match.match.status }}</i>
              <br />
              <div>
                <button @click="deleteChat(match.match.id_match)" class="profileButton">Borrar chat</button>
                <button
                  @click="openChat(match.match, match.user)"
                  v-if="match.match.status === 'match'"
                  class="profileButton"
                >Hablar</button>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <!-- /MATCHES -->
      <!-- MODAL DE PERFIL DE USUARIO -->
      <div class="modal" v-if="userModal">
        <div class="modalBoxUser">
          <div class="userInfo">
            <div class="name">
              <h4 class="type">{{ userInfo.profile.ig_profile }}</h4>
              <br />
              <h1>{{ userInfo.profile.name }}, {{ userInfo.profile.age }}</h1>
              <h2>
                {{ userInfo.profile.rating }}
                <p>/ 5</p>
              </h2>
            </div>
            <p class="type">{{ userInfo.profile.type }}</p>
            <br />
            <img :src="userInfo.profile.image1" />
            <br />
            <div class="flex">
              <div>
                <p>Campo profesional:</p>
                <h2>{{ userInfo.profile.occupation_field }}</h2>
              </div>
              <div>
                <p>Estado laboral:</p>
                <h2>{{ userInfo.profile.occupation_status }}</h2>
              </div>
              <div>
                <p>Pareja:</p>
                <h2>{{ userInfo.profile.couple }}</h2>
              </div>
            </div>
            <br />
            <h2 class="type">Personalidad</h2>
            <ul class="flex">
              <li v-for="personalidad in userInfo.personality" :key="personalidad.id_personality">
                <p>{{ personalidad.name }}</p>
              </li>
            </ul>
            <h2 class="type">Hobbies</h2>
            <ul>
              <li v-for="hobby in userInfo.hobbies" :key="hobby.id_hobby">
                <h3 id="hobbyName">{{ hobby.name }}</h3>
                <p id="hobbyDescription">{{ hobby.description }}</p>
              </li>
            </ul>
            <h2 class="type">Reglas</h2>
            <ul class="flex">
              <li v-for="rule in userInfo.rules" :key="rule.id_rule">
                <p>{{ rule.name }}</p>
              </li>
            </ul>
            <button @click="closeModal()" class="profileButton">Cerrar</button>
          </div>
        </div>
      </div>
      <!-- /MODAL DE PERFIL DE USUARIO -->
      <!-- CHAT ABIERTO -->
      <div v-show="openedChat" id="chat">
        <h1 @click="getUserInfo(userChat.id_user)" class="userMatchName">{{userChat.first_name}}</h1>
        <br />
        <br />
      </div>
      <div v-show="openedChat" class="messagesContainer">
        <div id="messages">
          <ul v-for="message in messages" :key="message.id_message">
            <li :class="{ eu: id === message.id_user, outro: id !== message.id_user }">
              <b>{{ message.comment }}</b>
              <div>
                <p>{{ message.first_name }}</p>
                <i>{{ message.creation_date }}</i>
              </div>
            </li>
          </ul>
        </div>
        <div class="chatOptions">
          <div id="writeMessage">
            <textarea
              name="message"
              id="messageText"
              cols="60"
              rows="5"
              v-model="message"
              placeholder="Escribe aquí tu mensaje..."
            ></textarea>
            <div id="messageControllers">
              <button @click="closeChat()" class="profileButton">Cerrar</button>
              <button @click="sendMessage(matchid)" class="profileButton">Enviar</button>
            </div>
          </div>
          <div>
            <button
              @click="request = true"
              class="profileButton"
              v-show="!request"
            >Solicitar reserva</button>
            <fieldset v-show="request">
              <label for="startDate">Fecha de inicio de la reserva</label>
              <br />
              <input type="date" name="startDate" v-model="startDate" />
            </fieldset>
            <fieldset v-show="request">
              <label for="finishDate">Fecha de fin de la reserva</label>
              <br />
              <input type="date" name="finishDate" v-model="finishDate" />
            </fieldset>
            <button
              @click="requestBooking(matchid)"
              v-show="request"
              class="profileButton"
            >Enviar solicitud</button>
            <button @click="cancelBooking()" v-show="request" class="profileButton">Cancelar</button>
          </div>
        </div>
      </div>
      <footercustom v-show="openedChat"></footercustom>
    </div>
    <!-- /CHAT ABIERTO -->
    <button class="homeButton">
      <router-link to="/">Volver a la home</router-link>
    </button>
    <!-- FOOTER -->
    <footercustom v-if="!userModal && !openedChat"></footercustom>
    <!-- /FOOTER -->
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Mensajes",
  components: { menucustom, footercustom },
  data() {
    return {
      id: Number(localStorage.getItem("id")),
      matchid: null,
      matches: [],
      messages: [],
      openedChat: false,
      message: "",
      request: false,
      startDate: null,
      finishDate: null,
      userInfo: {},
      userModal: false,
      userChat: {}
    };
  },
  methods: {
    getMatches() {
      let self = this;
      self.search = true;
      axios
        .get("http://localhost:3001/user/" + self.id + "/matches", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.matches = response.data.data.map(match => {
            match.user[0].image_1 =
              "http://localhost:3001/uploads/" + match.user[0].image_1;
            return match;
          });
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
          if (error.response.status === 401) {
            self.$router.push("/login");
          }
        });
    },
    openChat(match, user) {
      let self = this;
      self.userChat = user[0];

      axios
        .get(
          "http://localhost:3001/user/" +
            self.id +
            "/matches/" +
            match.id_match,
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          self.messages = response.data.messages;
          self.openedChat = true;
          self.matchid = match.id_match;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    deleteChat(matchId) {
      let self = this;
      axios
        .delete(
          "http://localhost:3001/user/" + self.id + "/matches/" + matchId,
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          self.getMatches();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    getMessages(matchid) {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/matches/" + matchid, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.messages = response.data.messages;
          self.openedChat = true;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    sendMessage(match) {
      let self = this;
      axios
        .post(
          "http://localhost:3001/user/" + self.id + "/matches/" + self.matchid,
          { comment: self.message },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(reponse) {
          self.getMessages(match);
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
      self.message = "";
    },
    openRequest() {
      self.request = true;
    },
    requestBooking(matchId) {
      let self = this;
      axios
        .post(
          "http://localhost:3001/user/" +
            self.id +
            "/matches/" +
            matchId +
            "/booking",
          { startDate: self.startDate, finishDate: self.finishDate },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "La solicitud de reserva ha sido enviada",
            text:
              "Consulta el estado de tu reserva en la sección 'Mis reservas'"
          });
          self.$router.push("/reservas");
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    closeChat() {
      this.messages = [];
      this.openedChat = false;
      // this.getMatches();
    },
    cancelBooking() {
      this.request = false;
    },
    checkUserInChat(id1, id2) {
      if (this.id === id1) {
        return id2;
      } else {
        return id1;
      }
    },
    getUserInfo(id) {
      let self = this;

      axios
        .get("http://localhost:3001/user/" + id, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.userInfo = response.data.data;
          self.userInfo.profile.image1 =
            "http://localhost:3001/uploads/" + self.userInfo.profile.image1;

          // const userImage_1 = response.data.data.profile.image1;
          // const userImage_2 = response.data.data.profile.image2;
          // const userImage_3 = response.data.data.profile.image3;
          // const userImage_4 = response.data.data.profile.image4;
          // const userImage_5 = response.data.data.profile.image5;

          // const imagesArray = [
          //   userImage_1,
          //   userImage_2,
          //   userImage_3,
          //   userImage_4,
          //   userImage_5
          // ];

          // if (self.userInfo.room.length) {
          //   const roomImage_1 = response.data.data.room[0].image_1;
          //   const roomImage_2 = response.data.data.room[0].image_2;
          //   const roomImage_3 = response.data.data.room[0].image_3;
          //   const roomImage_4 = response.data.data.room[0].image_4;
          //   const roomImage_5 = response.data.data.room[0].image_5;
          //   imagesArray.push(
          //     roomImage_1,
          //     roomImage_2,
          //     roomImage_3,
          //     roomImage_4,
          //     roomImage_5
          //   );
          // }

          // const imagesToFront = [];

          // for (const image of imagesArray) {
          //   if (image) {
          //     imagesToFront.push("http://localhost:3001/uploads/" + image);
          //   } else {
          //     imagesToFront.push(null);
          //   }
          // }
          // if (!response.data.data.profile.image1) {
          //   self.userInfo.image_1 =
          //     "http://localhost:3001/uploads/roomie-profile.jpg";
          // } else {
          //   self.userInfo.profile.image_1 = imagesToFront[0];
          //   self.userInfo.profile.image_2 = imagesToFront[1];
          //   self.userInfo.profile.image_3 = imagesToFront[2];
          //   self.userInfo.profile.image_4 = imagesToFront[3];
          //   self.userInfo.profile.image_5 = imagesToFront[4];
          //   if (self.userInfo.room.length > 0) {
          //     if (!self.userInfo.room[0].image_1) {
          //     } else {
          //       self.userInfo.room[0].image_1 = imagesToFront[5];
          //       self.userInfo.room[0].image_2 = imagesToFront[6];
          //       self.userInfo.room[0].image_3 = imagesToFront[7];
          //       self.userInfo.room[0].image_4 = imagesToFront[8];
          //       self.userInfo.room[0].image_5 = imagesToFront[9];
          //     }
          //   }
          // }

          self.openUserModal();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    openUserModal() {
      this.userModal = true;
    },
    closeModal() {
      this.userModal = false;
    }
  },
  created() {
    this.messages = [];
    this.openedChat = false;
    this.matches = [];
    this.getMatches();
  }
};
</script>

<style>
#matches {
  height: 100vh;
}

ul {
  list-style: none;
}
.eu {
  background-color: lightcoral;
  border: 1px solid lightcoral;
  color: white;
  display: flex;
  flex-direction: column;
  border-radius: 1rem;
}

.outro {
  display: flex;
  flex-direction: column;
  border: 1px solid lightcoral;
  border-radius: 1rem;
}

img {
  width: 200px;
}

i {
  font-size: 0.8rem;
}

h2 {
  margin: 0;
}

.chatContainer {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-content: center;
  align-items: center;
  /* margin: 0 auto; */
}

.chat {
  margin: 2rem;
}

.homeButton {
  border: none;
  margin-bottom: 3rem;
  background-color: white;
  font-size: 0.8rem;
  color: #2c3e50;
}

.homeButton a:hover {
  color: lightcoral;
}

.messagesContainer {
  display: flex;
}

.chatOptions {
  margin: 2rem auto;
}

#messages {
  width: 400px;
  margin: 0 auto;
  margin-bottom: 1rem;
  overflow-y: auto;
  height: 400px;
  padding: 1rem;
}

#messages::-webkit-scrollbar {
  width: 0.2em;
}

#messages::-webkit-scrollbar-thumb {
  background-color: lightcoral;
}

#messages li {
  padding: 1rem 1rem;
  margin: 0;
}

#messages li b {
  margin-bottom: 1rem;
}

#messageText input {
  margin: 0 auto;
  border: none;
  border-bottom: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 2rem;
  text-align: center;
  width: 200px;
  margin-top: 0.5rem;
}

textarea {
  margin: 0 auto;
  border: none;
  border: 1px solid lightcoral;
  background-color: white;
  font-family: raleway;
  margin-bottom: 1rem;
  width: 400px;
}

fieldset label {
  font-family: raleway;
  font-weight: 800;
  margin: 0;
  margin-bottom: 0.5rem;
}

fieldset input {
  margin: 0 auto;
  border: none;
  border-bottom: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 2rem;
  text-align: center;
  width: 200px;
}

#planta4 {
  position: fixed;
  right: 0;
  bottom: 0;
  z-index: -2;
  width: 200px;
}

.userMatchName:hover {
  color: lightcoral;
}

#chat h1 {
  text-align: left;
  margin-left: 8rem;
}

.matchContainer {
  height: 100vh;
}
</style>
