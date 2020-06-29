<template>
  <div class="home">
    <vue-headful title="Home" description="Página de inicio" />
    <menucustom></menucustom>
    <div id="searchContainer" v-show="!search">
      <form v-show="!search">
        <div id="userSearch">
          <p>¿Qué roomie buscas?</p>
          <div id="userInfo">
            <div id="userGender">
              <label for="gender">¿Chico o chica?</label>
              <fieldset>
                <select name="gender" id="gender" v-model="gender">
                  <option value="chico">chico</option>
                  <option value="chica">chica</option>
                </select>
              </fieldset>
            </div>
            <div id="userCouple">
              <label for="couple">¿Con pareja?</label>
              <fieldset>
                <select name="couple" id="couple" v-model="couple">
                  <option value="1">con pareja</option>
                  <option value="0">sin pareja</option>
                </select>
              </fieldset>
            </div>
            <div id="userStatus">
              <label for="occupationStatus">¿Trabajando?</label>
              <fieldset>
                <select
                  name="occupationStatus"
                  id="occupationStatus"
                  v-model="occupationStauts"
                >
                  <option value="trabajando">trabajando</option>
                  <option value="estudiando">estudiando</option>
                  <option value="estudiando y trabajando">ambas</option>
                </select>
              </fieldset>
            </div>
          </div>
        </div>
        <div id="personalityHobbies">
          <div id="personalitySearch">
            <fieldset>
              <p>Personalidad:</p>
              <select name="personality" id="personality" v-model="personality">
                <option value="activo">activo</option>
                <option value="tranquilo">tranquilo</option>
                <option value="considerado">considerado</option>
                <option value="feliz">feliz</option>
                <option value="generoso">generoso</option>
                <option value="creativo">creativo</option>
                <option value="de trato facil">de trato fácil</option>
                <option value="empático">empático</option>
                <option value="entusiasta">entusiasta</option>
                <option value="divertido">amable</option>
                <option value="divertido">divertido</option>
                <option value="sincero">sincero</option>
                <option value="optimista">optimista</option>
                <option value="organizado">organizado</option>
                <option value="apasionado">apasionado</option>
                <option value="proactivo">proactivo</option>
                <option value="sensato">sensato</option>
                <option value="tolerante">tolerante</option>
                <option value="sociable">sociable</option>
                <option value="sensible">sensible</option>
                <option value="familiar">familiar</option>
                <option value="saludable">saludable</option>
                <option value="gamer">gamer</option>
                <option value="foodie">foodie</option>
                <option value="workaholic">workaholic</option>
                <option value="madrugador">madrugador</option>
                <option value="aventurero">aventurero</option>
                <option value="paciente">paciente</option>
                <option value="party animal">party animal</option>
                <option value="comprador">comprador</option>
                <option value="amante de los animales"
                  >amante de los animales</option
                >
                <option value="solitario">solitario</option>
                <option value="nocturno">nocturno</option>
                <option value="practico">práctico</option>
                <option value="improvisador">improvisador</option>
                <option value="casero">casero</option>
                <option value="amante de la moda">amante de la moda</option>
                <option value="friki">friki</option>
                <option value="hater">hater</option>
                <option value="emprendedor">emprendedor</option>
              </select>
            </fieldset>
          </div>
          <div id="hobbySearch">
            <fieldset>
              <p>Hobbies:</p>
              <select name="hobby" id="hobby" v-model="hobby">
                <option value="cine">cine</option>
                <option value="musica">musica</option>
                <option value="fotografia">fotografia</option>
                <option value="naturaleza">naturaleza</option>
                <option value="deportes">deportes</option>
                <option value="literatura">literatura</option>
                <option value="cocina">cocina</option>
                <option value="series">series</option>
                <option value="videojuegos">videojuegos</option>
                <option value="moda">moda</option>
                <option value="arte">arte</option>
                <option value="tecnologia">tecnología</option>
                <option value="aventura">aventura</option>
                <option value="viajar">viajar</option>
                <option value="manualidades">manualidades</option>
              </select>
            </fieldset>
          </div>
        </div>
        <div id="ruleSearch">
          <fieldset>
            <p>Normas de convivencia:</p>
            <select name="rule" id="rule" v-model="rule">
              <option value="mascotas">mascotas</option>
              <option value="fumador">fumador</option>
              <option value="vegetariano">vegetariano</option>
              <option value="alergias">alergias</option>
            </select>
          </fieldset>
          <fieldset>
            <p>Ordenar por:</p>
            <select name="sort" id="sort" v-model="sort">
              <option value="views">vistas</option>
              <option value="age">edad</option>
              <option value="rating">rating</option>
            </select>
          </fieldset>
        </div>
      </form>
      <div id="buttonSearch">
        <button @click="getUsers()" type="submit" v-show="!search">
          Buscar
        </button>
      </div>
    </div>
    <titlecustom id="title"></titlecustom>
    <button @click="deleteSearch()" v-show="search">Borrar búsqueda</button>
    <div
      class="users"
      v-for="user in users"
      :key="user.id_user"
      v-show="search"
    >
      <h1>{{ user.perfil[0].first_name }}, {{ user.perfil[0].age }}</h1>
      <h3>{{ user.perfil[0].rating }}</h3>
      <img :src="user.perfil[0].image_1" alt />
      <h3>Personalidad</h3>
      <ul
        v-for="personalidad in user.personalidad"
        :key="personalidad.id_personality"
      >
        <li>{{ personalidad.name }}</li>
      </ul>
      <h3>Hobbies</h3>
      <ul v-for="hobby in user.hobbies" :key="hobby.id_hobby">
        <li>{{ hobby.name }}</li>
        <!-- <li>{{ hobby.description }}</li> -->
      </ul>
      <ul v-for="rule in user.rules" :key="rule.id_rule">
        <li>{{ rule.name }}</li>
      </ul>
      <ul v-for="room in user.room" :key="room.id_room">
        <li>{{ room.title }}</li>
        <li>{{ room.price }}</li>
        <li>{{ room.address }}</li>
      </ul>
      <button>Siguiente</button>
      <button @click="likeUser(user.perfil[0].id_user)">Like</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";
import titlecustom from "@/components/TitleCustom.vue";

export default {
  name: "Home",
  data() {
    return {
      search: false,
      users: [],
      gender: "",
      couple: "",
      sort: "",
      occupationStauts: "",
      personality: "",
      hobby: "",
      rule: "",
    };
  },
  components: { menucustom, titlecustom },
  methods: {
    getUsers() {
      let self = this;
      self.search = true;
      axios
        .get("http://localhost:3001/user", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: {
            gender: self.gender,
            couple: self.couple,
            sort: self.sort,
            occupationStauts: self.occupationStauts,
            personality: self.personality,
            hobby: self.hobby,
            rule: self.rule,
          },
        })
        .then(function(response) {
          self.users = response.data.data.map((user) => {
            user.perfil[0].image_1 =
              "http://localhost:3001/uploads/" + user.perfil[0].image_1;
            user.perfil[0].image_2 =
              "http://localhost:3001/uploads/" + user.perfil[0].image_2;
            user.perfil[0].image_3 =
              "http://localhost:3001/uploads/" + user.perfil[0].image_3;
            user.perfil[0].image_4 =
              "http://localhost:3001/uploads/" + user.perfil[0].image_4;
            user.perfil[0].image_5 =
              "http://localhost:3001/uploads/" + user.perfil[0].image_5;
            return user;
          });
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            text: error.response.data.message,
          });
        });
    },
    deleteSearch() {
      this.search = false;
    },
    likeUser(index) {
      let self = this;
      axios
        .put("http://localhost:3001/user/" + index + "/like", {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          self.getUsers();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
      self.getUsers();
    },
  },
};
</script>

<style>
#searchContainer {
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  width: 350px;
  padding: 1rem 2rem;
  position: absolute;
  left: 65vh;
  top: 12rem;
  z-index: 12;
  background-color: white;
}

#userInfo {
  display: flex;
  justify-content: space-between;
}
label {
  font-size: 0.8rem;
}

#personalityHobbies {
  display: flex;
  justify-content: space-between;
}

#ruleSearch {
  display: flex;
  justify-content: space-evenly;
  margin-bottom: 1rem;
}

#searchContainer button {
  margin-bottom: 0.5rem;
  border: none;
  border-bottom: 1px solid lightcoral;
  background-color: white;
  font-family: "Dm Serif Display";
  font-weight: 500;
  padding: 0.2rem 1rem;
  font-size: 2rem;
  color: lightcoral;
}
#searchContainer button:hover {
  color: #2c3e50;
}
title {
  position: absolute;
  z-index: -12;
}
</style>
