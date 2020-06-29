<template>
  <div>
    <vue-headful title="Mis valoraciones" description="Mis valoraciones" />
    <menucustom></menucustom>
    <button @click="showSubmitedVotes()">Valoraciones emitidas</button>
    <button @click="showReceivedVotes()">Valoraciones recibidas</button>
    <ul class="sumbitedVotes" v-show="votes === 'enviados'">
      <p v-show="emptySubmited">Todavía no has votado a ningún usuario</p>
      <li v-for="submitedVote in submitedVotes" :key="submitedVote.id_rating">
        <img :src="submitedVote.image_1" />
        <p>{{ submitedVote.first_name }}</p>
        <h3>{{ submitedVote.rate }}</h3>
        <p>{{ submitedVote.comment }}</p>
      </li>
    </ul>
    <ul class="receivedVotes" v-show="votes === 'recibidos'">
      <p v-show="emptyReceived">Todavía no te ha votado ningún usuario</p>
      <li v-for="receivedVote in receivedVotes" :key="receivedVote.id_rating">
        <img :src="receivedVote.image_1" />
        <p>{{ receivedVote.first_name }}</p>
        <h3>{{ receivedVote.rate }}</h3>
        <p>{{ receivedVote.comment }}</p>
      </li>
    </ul>
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
  name: "UserVotes",
  components: { menucustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      submitedVotes: [],
      receivedVotes: [],
      votes: "enviados",
      emptySubmited: false,
      emptyReceived: false,
    };
  },
  methods: {
    getSubmitedVotes() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/submited-votes", {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          self.submitedVotes = response.data.votes.map((vote) => {
            vote.image_1 = "http://localhost:3001/uploads/" + vote.image_1;
            return vote;
          });

          if (self.submitedVotes.length === 0) {
            self.emptySubmited = true;
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
    },
    getReceivedVotes() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/received-votes", {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          self.receivedVotes = response.data.votes.map((vote) => {
            vote.image_1 = "http://localhost:3001/uploads/" + vote.image_1;
            return vote;
          });
          if (self.receivedVotes.length === 0) {
            self.emptyReceived = true;
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
    },
    showSubmitedVotes() {
      this.votes = "enviados";
    },
    showReceivedVotes() {
      this.votes = "recibidos";
    },
  },
  created() {
    this.getSubmitedVotes();
    this.getReceivedVotes();
  },
};
</script>

<style>
ul {
  list-style: none;
}
</style>
