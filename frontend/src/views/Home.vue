<template>
  <div class="home">
    <vue-headful title="Home" description="Página de inicio" />
    <menucustom></menucustom>
    <form v-show="!search">
      <p>¿Qué buscas?</p>
      <fieldset>
        <select name="gender" id="gender" v-model="gender">
          <option value="chico">chico</option>
          <option value="chica">chica</option>
        </select>
      </fieldset>
      <fieldset>
        <select name="couple" id="couple" v-model="couple">
          <option value="1">con pareja</option>
          <option value="0">sin pareja</option>
        </select>
      </fieldset>
      <fieldset>
        <select name="occupationStatus" id="occupationStatus" v-model="occupationStauts">
          <option value="trabajando">trabajando</option>
          <option value="estudiando">estudiando</option>
          <option value="estudiando y trabajando">ambas</option>
        </select>
      </fieldset>
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
          <option value="amante de los animales">amante de los animales</option>
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
    </form>
    <button @click="getUsers()" type="submit" v-show="!search">BUSCAR</button>
    <button @click="deleteSearch()" v-show="search">Borrar búsqueda</button>
    <div class="users" v-for="user in users" :key="user.id_user" v-show="search">
      <h1>{{ user.perfil[0].first_name }}, {{ user.perfil[0].age }}</h1>
      <h3>{{ user.perfil[0].rating }}</h3>
      <img :src="user.perfil[0].image_1" alt />
      <ul v-for="personalidad in user.personalidad" :key="personalidad.id_personality">
        <li>{{personalidad.name}}</li>
      </ul>
      <ul v-for="hobby in user.hobbies" :key="hobby.id_hobby">
        <li>{{hobby.name}}</li>
        <li>{{hobby.description}}</li>
      </ul>
      <ul v-for="rule in user.rules" :key="rule.id_rule">
        <li>{{rule.name}}</li>
      </ul>
      <ul v-for="room in user.room" :key="room.id_room">
        <li>{{room.title}}</li>
        <li>{{room.price}}</li>
        <li>{{room.address}}</li>
      </ul>
      <button @click="likeUser(user.perfil[0].id_user)">Like</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";

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
      rule: ""
    };
  },
  components: { menucustom },
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
            rule: self.rule
          }
        })
        .then(function(response) {
          self.users = response.data.data;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            text: error.response.data.message
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
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.getUsers();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
      self.getUsers();
    }
  }
};
</script>

<style>
fieldset {
  border: none;
}
</style>