Z<template>
  <div>
    <vue-headful title="Mis mensajes" description="Mis mensajes" />
    <menucustom></menucustom>
    <div v-if="matches.length === 0">
      <h2>Todavía no tienes chats abiertos...</h2>
      <p>¡Dale a me gusta a tus perfiles favoritos para encontrar a tu roomie!</p>
    </div>

    <ul v-for="match in matches" :key="match.id_match" v-show="!openedChat">
      <li>
        <img :src="match.user[0].image_1" />
        <h2>{{ match.user[0].first_name }}</h2>
        <i>{{ match.match.status }}</i>
        <button @click="openChat(match.match.id_match)" v-if="match.match.status === 'match'">Hablar</button>
        <button @click="deleteChat(match.match.id_match)">Borrar chat</button>
      </li>
    </ul>

    <div v-show="openedChat">
      <ul v-for="message in messages" :key="message.id_message">
        <li :class="{ eu: id === message.id_user, outro: id !== message.id_user }">
          <p>{{ message.comment }}</p>
          <b>{{ message.first_name }}</b>
          <i>{{ message.creation_date }}</i>
        </li>
      </ul>
      <label for="message">Escribe tu mensaje:</label>
      <textarea name="message" id="message" cols="30" rows="10" v-model="message"></textarea>
      <button @click="sendMessage(matchid)">Enviar</button>
      <button @click="closeChat()">Cerrar</button>
      <div>
        <button @click="request = true">Solicitar reserva</button>
        <fieldset v-show="request">
          <label for="startDate">Fecha de inicio de la reserva</label>
          <input type="date" name="startDate" v-model="startDate" />
          <label for="finishDate">Fecha de fin de la reserva</label>
          <input type="date" name="finishDate" v-model="finishDate" />
        </fieldset>
        <button @click="requestBooking(matchid)" v-show="request">Enviar solicitud</button>
      </div>
    </div>
    <button>
      <router-link to="/">Volver a la home</router-link>
    </button>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Mensajes",
  components: { menucustom },
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
      finishDate: null
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
    openChat(matchId) {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/matches/" + matchId, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.messages = response.data.messages;
          self.openedChat = true;
          self.matchid = matchId;
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
          if (error.response.status === 401) {
            self.$router.push("/login");
          }
        });
    },
    sendMessage(matchId) {
      let self = this;
      axios
        .post(
          "http://localhost:3001/user/" + self.id + "/matches/" + matchId,
          { comment: self.message },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(self.openChat(matchId))
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
    }
  },
  created() {
    this.getMatches();
  }
};
</script>

<style>
ul {
  list-style: none;
}
.eu {
  background-color: lightblue;
}
.outro {
  border: 1px solid lightblue;
}

img {
  width: 400px;
}
</style>
