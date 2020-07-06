<template>
  <div>
    <vue-headful title="Mis hobbies" description="Mis hobbies" />
    <menucustom></menucustom>
    <img src="../assets/planta6.jpg" alt="Imagen de aficiones" id="planta6" />
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
        >{{ hobby.name }}</button>
      </li>
    </ul>
    <p v-show="many">Sólo puedes elegir 5 aficiones</p>
    <p v-if="selectedHobbiesNames.length < 5">Tienes que elegir 5 aficiones</p>
    <div id="userHobbies">
      <ul class="hobbyContainer">
        <li v-for="selectedHobby in selectedHobbies" :key="selectedHobby.id_hobby">
          <h2>{{ selectedHobby.name }}</h2>
          <div class="hobbyContainer">
            <textarea
              name
              id
              cols="30"
              rows="10"
              :placeholder="selectedHobby.description"
              v-model="selectedHobby.description"
            ></textarea>
          </div>
        </li>
      </ul>
    </div>
    <button @click="editUserHobbies()" class="updateButton">Guardar cambios</button>
    <br />
    <button class="homeButton">
      <router-link to="/">Volver a la home</router-link>
    </button>
    <footercustom></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "UserHobby",
  components: { menucustom, footercustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      hobbies: [],
      selectedHobbies: [],
      selectedHobbiesNames: [],
      many: false
    };
  },
  methods: {
    getUserHobbies() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/hobby", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: { id: self.id }
        })
        .then(function(response) {
          self.hobbies = response.data.hobbies;
          self.selectedHobbies = self.hobbies.filter(
            hobby => hobby.status === 1
          );
          for (const hobbyName of self.selectedHobbies) {
            self.selectedHobbiesNames.push(hobbyName.name);
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
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
          hobby => hobby.name !== this.hobbies[index].name
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
            status: 1
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
            description5: self.selectedHobbies[4].description
          },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Aficiones actualizadas correctamente",
            text: "Completa tu perfil al máximo :)"
          });
          self.getUserHobbies();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    }
  },
  created() {
    this.hobbies = [];
    this.selectedHobbies = [];
    this.selectedHobbiesNames = [];
    this.getUserHobbies();
  }
};
</script>

<style>
.hobbyContainer {
  width: 500px;
  list-style: none;
  display: flex;
  justify-content: center;
  flex-direction: row;
  flex-wrap: wrap;
  margin: 0 auto;
  margin-top: 1rem;
}

.hobbyContainer li {
  margin: 0.5rem;
}

/* .activado {
  background-color: lightcoral;
  border: 1px solid lightcoral;
  padding: 0.4rem 1.2rem;
  color: white;
  border-radius: 14px;
  font-weight: 700;
}
.desactivado {
  background-color: white;
  border: 1px solid lightcoral;
  font-family: "Raleway";
  color: #2c3e50;
  padding: 0.4rem 1.2rem;
  border-radius: 14px;
  font-weight: 700;
} */

.hobbyContainer ul {
  display: flex;
  list-style: none;
  flex-wrap: wrap;
  justify-content: center;
}

ul li {
  margin: 0.5rem;
}

textarea {
  margin: 0 auto;
  border: none;
  border: 1px solid lightcoral;
  font-family: raleway;
  margin: 1rem 0;
  width: 300px;
  height: 60px;
  text-align: center;
  background-color: white;
}

.updateButton {
  font-family: "Dm Serif Display";
  border: none;
  background-color: white;
  border-bottom: 2px solid lightcoral;
  font-size: 2rem;
  color: #2c3e50;
}

.updateButton:hover {
  color: lightcoral;
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

#planta6 {
  position: fixed;
  right: 0;
  bottom: 0;
  z-index: -2;
  width: 300px;
}
</style>
