<template>
  <div>
    <vue-headful title="Mis hobbies" description="Mis hobbies" />
    <menucustom></menucustom>
    <h2>Selecciona tus 5 hobbies y cuenta por qué te gustan:</h2>
    <ul class="hobbyContainer">
      <li v-for="(hobby, index) in hobbies" :key="hobby.id_hobby">
        <button
          value="hobby.name"
          :class="{
            activado: hobby.status === 1,
            desactivado: hobby.status === 0,
          }"
          @click="selectHobby(index)"
        >
          {{ hobby.name }}
        </button>
      </li>
    </ul>
    <p v-show="many">Sólo puedes elegir 5 aficiones</p>
    <p v-if="selectedHobbiesNames.length < 5">Tienes que elegir 5 aficiones</p>
    <ul>
      <li
        v-for="selectedHobby in selectedHobbies"
        :key="selectedHobby.id_hobby"
      >
        <h3>{{ selectedHobby.name }}</h3>
        <textarea
          name
          id
          cols="30"
          rows="10"
          :placeholder="selectedHobby.description"
          v-model="selectedHobby.description"
        ></textarea>
      </li>
    </ul>
    <button @click="editUserHobbies()">Guardar cambios</button>
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
  name: "UserHobby",
  components: { menucustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      hobbies: [],
      selectedHobbies: [],
      selectedHobbiesNames: [],
      many: false,
    };
  },
  methods: {
    getUserHobbies() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/hobby", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: { id: self.id },
        })
        .then(function(response) {
          self.hobbies = response.data.hobbies;
          self.selectedHobbies = self.hobbies.filter(
            (hobby) => hobby.status === 1
          );
          for (const hobbyName of self.selectedHobbies) {
            self.selectedHobbiesNames.push(hobbyName.name);
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
    selectHobby(index) {
      if (this.selectedHobbies.length <= 5) {
        this.many = false;
      }
      if (this.selectedHobbiesNames.includes(this.hobbies[index].name)) {
        this.hobbies[index].status = 0;
        this.selectedHobbies = this.selectedHobbies.filter(
          (hobby) => hobby.name !== this.hobbies[index].name
        );
        this.selectedHobbiesNames.splice(
          this.selectedHobbiesNames.indexOf(this.hobbies[index].name),
          1
        );
      } else {
        if (this.selectedHobbies.length < 5) {
          this.selectedHobbies.push({
            description: "",
            name: this.hobbies[index].name,
            status: 1,
          });
          this.hobbies[index].status = 1;
          this.selectedHobbiesNames.push(this.hobbies[index].name);
        } else {
          this.many = true;
        }
      }
    },
    editUserHobbies() {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/hobby",
          {
            hobby1: self.selectedHobbies[0].name,
            description1: self.selectedHobbies[0].description,
            hobby2: self.selectedHobbies[1].name,
            description2: self.selectedHobbies[1].description,
            hobby3: self.selectedHobbies[2].name,
            description3: self.selectedHobbies[2].description,
            hobby4: self.selectedHobbies[3].name,
            description4: self.selectedHobbies[3].description,
            hobby5: self.selectedHobbies[4].name,
            description5: self.selectedHobbies[4].description,
          },
          {
            headers: { authorization: localStorage.getItem("authorization") },
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Aficiones actualizadas correctamente",
            text: "Completa tu perfil al máximo :)",
          });
          self.getUserHobbies();
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
    this.getUserHobbies();
  },
};
</script>

<style>
.activado {
  background-color: lightgreen;
  border: none;
}
.desactivado {
  background-color: lightgrey;
  border: none;
}

.hobbyContainer {
  list-style: none;
  display: flex;
  justify-content: center;
  flex-direction: row;
  flex-wrap: wrap;
}

.hobbyContainer li {
  margin: 0.5rem;
}

ul {
  display: flex;
  list-style: none;
  flex-wrap: wrap;
  justify-content: center;
}
ul li {
  margin: 0.5rem;
}
</style>
