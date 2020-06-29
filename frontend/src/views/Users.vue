<template>
  <div>
    <h1>USUARIOS</h1>
    <div class="users" v-for="user in users" :key="user.id_user">
      <h1>{{ user.perfil[0].first_name }}, {{ user.perfil[0].age }}</h1>
      <h3>{{ user.perfil[0].rating }}</h3>
      <img :src="user.perfil[0].image_1" alt />
      <ul
        v-for="personalidad in user.personalidad"
        :key="personalidad.id_personality"
      >
        <li>{{ personalidad.name }}</li>
      </ul>
      <ul v-for="hobby in user.hobbies" :key="hobby.id_hobby">
        <li>{{ hobby.name }}</li>
        <li>{{ hobby.description }}</li>
      </ul>
      <ul v-for="rule in user.rules" :key="rule.id_rule">
        <li>{{ rule.name }}</li>
      </ul>
      <ul v-for="room in user.room" :key="room.id_room">
        <li>{{ room.title }}</li>
        <li>{{ room.price }}</li>
        <li>{{ room.address }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Users",
  data() {
    return {
      users: [],
    };
  },
  methods: {
    getUsers() {
      let self = this;
      axios
        .get("http://localhost:3001/user", {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          self.users = response.data.data;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
    },
  },
  created() {
    this.getUsers();
  },
};
</script>

<style scoped></style>
