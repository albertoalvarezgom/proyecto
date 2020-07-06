<template>
  <div>
    <vue-headful title="Mis valoraciones" description="Mis valoraciones" />
    <menucustom></menucustom>
    <img src="../assets/hojas.jpg" alt="Imagen de perfil" id="hojas" />
    <div class="votesButton">
      <button
        @click="showSubmitedVotes()"
        :class="{
            activado: votes === 'enviados',
            desactivado: votes === 'recibidos'
          }"
      >Valoraciones emitidas</button>
      <button
        @click="showReceivedVotes()"
        :class="{
            activado: votes === 'recibidos',
            desactivado: votes === 'enviados'
          }"
      >Valoraciones recibidas</button>
    </div>
    <div id="submitedVotes" v-show="votes === 'enviados'">
      <h2>Votaciones emitidas</h2>
      <h3 v-show="emptySubmited">Todavía no has votado a ningún usuario</h3>
      <ul class="votes" v-show="votes === 'enviados'">
        <li v-for="submitedVote in submitedVotes" :key="submitedVote.id_rating">
          <img :src="submitedVote.image_1" />
          <div class="nameRate">
            <h2>{{ submitedVote.first_name }}</h2>
            <p>Nota:</p>
            <h2 class="numberRate">{{ submitedVote.rate }}</h2>
          </div>
          <p class="comment">{{ submitedVote.comment }}</p>
        </li>
      </ul>
      <button class="homeButton">
        <router-link to="/">Volver a la home</router-link>
      </button>
      <footercustom v-show="votes === 'enviados'"></footercustom>
    </div>

    <div id="receivedVotes" v-show="votes === 'recibidos'">
      <h2>Votaciones recibidas</h2>
      <h3 v-show="emptyReceived">Todavía no te ha votado ningún usuario</h3>
      <ul class="votes" v-show="votes === 'recibidos'">
        <li v-for="receivedVote in receivedVotes" :key="receivedVote.id_rating">
          <img :src="receivedVote.image_1" />
          <div class="nameRate">
            <h2>{{ receivedVote.first_name }}</h2>
            <p>Nota:</p>
            <h2 class="numberRate">{{ receivedVote.rate }}</h2>
          </div>
          <p class="comment">{{ receivedVote.comment }}</p>
        </li>
      </ul>
      <button class="homeButton">
        <router-link to="/">Volver a la home</router-link>
      </button>
    </div>
    <footercustom v-show="votes === 'recibidos'"></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "UserVotes",
  components: {
    menucustom,
    footercustom
  },
  data() {
    return {
      id: localStorage.getItem("id"),
      submitedVotes: [],
      receivedVotes: [],
      votes: "enviados",
      emptySubmited: false,
      emptyReceived: false
    };
  },
  methods: {
    getSubmitedVotes() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/submited-votes", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.submitedVotes = response.data.votes.map(vote => {
            vote.image_1 = "http://localhost:3001/uploads/" + vote.image_1;
            return vote;
          });

          if (self.submitedVotes.length === 0) {
            self.emptySubmited = true;
          }
          // self.getSubmitedVotes();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    getReceivedVotes() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/received-votes", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.receivedVotes = response.data.votes.map(vote => {
            vote.image_1 = "http://localhost:3001/uploads/" + vote.image_1;
            return vote;
          });
          if (self.receivedVotes.length === 0) {
            self.emptyReceived = true;
          }
          // self.getReceivedVotes();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    showSubmitedVotes() {
      this.votes = "enviados";
      this.getSubmitedVotes();
    },
    showReceivedVotes() {
      this.votes = "recibidos";
      this.getReceivedVotes();
    }
  },
  created() {
    this.getSubmitedVotes();
    // this.getReceivedVotes();
  }
};
</script>

<style scoped>
ul {
  list-style: none;
}

.homeButton {
  border: none;
  margin: 1rem 0;
  background-color: white;
  font-size: 0.8rem;
  color: #2c3e50;
}

.homeButton a:hover {
  color: lightcoral;
}

.desactivado {
  font-family: "Raleway";
  color: #2c3e50;
  background-color: white;
  border: 1px solid lightcoral;
  margin: 0 1rem;
  padding: 0.2rem 0.8rem;
}

.activado {
  font-family: "Raleway";
  color: white;
  background-color: lightcoral;
  border: 1px solid lightcoral;
  margin: 0 1rem;
  padding: 0.2rem 0.8rem;
}

.votes {
  display: flex;
  justify-content: center;
  margin: 0 auto;
  width: 600px;
  flex-wrap: wrap;
}

.votes li {
  margin: 1rem;
}

.nameRate {
  display: flex;
  justify-content: center;
  align-content: center;
  align-items: baseline;
}

h2 {
  margin: 0 1rem;
}

.nameRate p {
  margin: 0 0.2rem;
}

.numberRate {
  color: lightcoral;
  margin: 0;
}

.comment {
  margin-top: 1rem;
}

#submitedVotes {
  margin-top: 2rem;
  height: 100vh;
}

#receivedVotes {
  margin-top: 2rem;
  height: 100vh;
}

#hojas {
  position: fixed;
  left: 0;
  top: 0;
  z-index: -2;
  width: 300px;
}
</style>
