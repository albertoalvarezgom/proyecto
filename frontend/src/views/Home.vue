<template>
  <div class="home">
    <vue-headful title="Home" description="Página de inicio" />
    <img src="../assets/planta8.jpg" alt="Imagen de introducción" id="planta8" />
    <menucustom></menucustom>
    <div class="content">
      <img src="../assets/planta1.jpg" alt="Imagen de introducción" id="planta1" />
      <!-- CONTENIDO EN LA HOME PARA ANÓNIMOS -->
      <div id="intro" v-show="!checkLogin()">
        <!-- <h1 id="titulo">¡Bienvenido/a a roomie!</h1> -->
        <div class="bloque">
          <!-- <img src="../assets/amiga.jpg" alt="Imagen de introducción" class="introImagen" /> -->
          <div class="texto">
            <h1>- 1 -</h1>
            <h2>Busca por personalidad, aficiones o normas de convevencia.</h2>
          </div>
        </div>
        <div class="bloque">
          <div class="texto">
            <h1>- 2 -</h1>
            <h2>
              Elige a tus favoritos, espera a que ellos hagan lo mismo y empezad
              a chatear.
            </h2>
          </div>
          <!-- <img src="../assets/salon.jpg" alt="Imagen de introducción" class="introImagen" /> -->
        </div>
        <div class="bloque">
          <!-- <img src="../assets/intro.jpg" alt="Imagen de introducción" class="introImagen" /> -->
          <div class="texto">
            <h1>- 3 -</h1>
            <h2>
              Confirmad la reserva de la habitación...
              <h2>¡Y a disfrutar!</h2>
            </h2>
          </div>
        </div>
      </div>
      <!-- /CONTENIDO EN LA HOME PARA ANÓNIMOS -->
      <!-- BUSCADOR DE USUARIOS -->
      <div id="search" v-show="checkLogin()">
        <div class="homeContainer">
          <div id="searchContainer" v-show="!search">
            <form v-show="!search">
              <div id="userSearch">
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
                        v-model="occupationStatus"
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
                <div id="ruleSearch">
                  <label for="rule">Normas:</label>
                  <fieldset>
                    <select name="rule" id="rule" v-model="rule">
                      <option value="mascotas">mascotas</option>
                      <option value="fumador">fumador</option>
                      <option value="vegetariano">vegetariano</option>
                      <option value="alergias">alergias</option>
                    </select>
                  </fieldset>
                  <!-- <fieldset>
                <p>Ordenar por:</p>
                <select name="sort" id="sort" v-model="sort">
                  <option value="views">vistas</option>
                  <option value="age">edad</option>
                  <option value="rating">rating</option>
                </select>
                  </fieldset>-->
                </div>
                <div id="hobbySearch">
                  <label for="hobby">Hobbies:</label>
                  <fieldset>
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
              <div id="personalitySearch">
                <label for="personality">Personalidad:</label>
                <fieldset>
                  <select name="personality" v-model="personality">
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
              </div>
            </form>
            <div id="buttonSearch">
              <button @click="getUsers()" type="submit" v-show="!search">Buscar</button>
            </div>
          </div>
          <div class="claim" v-show="!search">
            <h1>Busca.</h1>
            <h1>Habla.</h1>
            <h1>Comparte.</h1>
          </div>
        </div>
        <!-- /BUSCADOR DE USUARIOS -->
        <button @click="deleteSearch()" v-show="search" id="deleteSearch">Borrar búsqueda</button>
        <noresults v-show="search && users.length===0"></noresults>
        <!-- COMPONENTE FICHAS DE USUSARIO -->
        <usercomponent
          :users="users"
          :userInfo="userInfo"
          :roomInfo="roomInfo"
          :userModal="userModal"
          :roomModal="roomModal"
          v-show="search"
          v-on:like="likeUser"
          v-on:view="getUserInfo"
          v-on:close="closeModal"
          v-on:room="getRoomInfo"
        ></usercomponent>
        <!-- /COMPONENTE FICHAS DE USUSARIO -->
        <!-- COMPONENTE FOOTER -->
        <footercustom v-show="search && !userModal && !roomModal"></footercustom>
        <!-- /COMPONENTE FOOTER -->
      </div>
    </div>
    <footercustom v-show="!search"></footercustom>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import usercomponent from "@/components/UserComponent.vue";
import noresults from "@/components/NoResults.vue";
import { isLoggedIn } from "@/api/utils.js";

export default {
  name: "Home",
  data() {
    return {
      search: false,
      users: [],
      userInfo: {},
      roomInfo: {},
      gender: "",
      couple: "",
      sort: "",
      occupationStatus: "",
      personality: "",
      hobby: "",
      rule: "",
      userModal: false,
      roomModal: false
    };
  },
  components: {
    menucustom,
    usercomponent,
    footercustom,
    noresults
  },
  methods: {
    checkLogin() {
      return isLoggedIn();
    },
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
            occupationStatus: self.occupationStatus,
            personality: self.personality,
            hobby: self.hobby,
            rule: self.rule
          }
        })
        .then(function(response) {
          self.users = response.data.data;
          self.users = response.data.data.map(user => {
            const imagesArray = [
              user.perfil[0].image_1,
              user.perfil[0].image_2,
              user.perfil[0].image_3,
              user.perfil[0].image_4,
              user.perfil[0].image_5
            ];

            if (user.room.length > 0) {
              imagesArray.push(
                user.room[0].image_1,
                user.room[0].image_2,
                user.room[0].image_3,
                user.room[0].image_4,
                user.room[0].image_5
              );
            }

            const imagesToFront = [];

            for (const image of imagesArray) {
              if (image) {
                imagesToFront.push("http://localhost:3001/uploads/" + image);
              } else {
                imagesToFront.push(null);
              }
            }
            user.perfil[0].image_1 = imagesToFront[0];
            user.perfil[0].image_2 = imagesToFront[1];
            user.perfil[0].image_3 = imagesToFront[2];
            user.perfil[0].image_4 = imagesToFront[3];
            user.perfil[0].image_5 = imagesToFront[4];

            if (user.room.length > 0) {
              user.room[0].image_1 = imagesToFront[5];
              user.room[0].image_2 = imagesToFront[6];
              user.room[0].image_3 = imagesToFront[7];
              user.room[0].image_4 = imagesToFront[8];
              user.room[0].image_5 = imagesToFront[9];
            }
            return user;
          });
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
      this.gender = "";
      this.couple = "";
      this.sort = "";
      this.occupationStatus = "";
      this.personality = "";
      this.hobby = "";
      this.rule = "";
    },
    getUserInfo(user) {
      let self = this;

      axios
        .get("http://localhost:3001/user/" + user.perfil[0].id_user, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.userInfo = response.data.data;

          const userImage_1 = response.data.data.profile.image1;
          const userImage_2 = response.data.data.profile.image2;
          const userImage_3 = response.data.data.profile.image3;
          const userImage_4 = response.data.data.profile.image4;
          const userImage_5 = response.data.data.profile.image5;

          const imagesArray = [
            userImage_1,
            userImage_2,
            userImage_3,
            userImage_4,
            userImage_5
          ];

          if (self.userInfo.room.length) {
            const roomImage_1 = response.data.data.room[0].image_1;
            const roomImage_2 = response.data.data.room[0].image_2;
            const roomImage_3 = response.data.data.room[0].image_3;
            const roomImage_4 = response.data.data.room[0].image_4;
            const roomImage_5 = response.data.data.room[0].image_5;
            imagesArray.push(
              roomImage_1,
              roomImage_2,
              roomImage_3,
              roomImage_4,
              roomImage_5
            );
          }

          const imagesToFront = [];

          for (const image of imagesArray) {
            if (image) {
              imagesToFront.push("http://localhost:3001/uploads/" + image);
            } else {
              imagesToFront.push(null);
            }
          }
          if (!response.data.data.profile.image1) {
            self.userInfo.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
          } else {
            self.userInfo.profile.image_1 = imagesToFront[0];
            self.userInfo.profile.image_2 = imagesToFront[1];
            self.userInfo.profile.image_3 = imagesToFront[2];
            self.userInfo.profile.image_4 = imagesToFront[3];
            self.userInfo.profile.image_5 = imagesToFront[4];
            if (self.userInfo.room.length > 0) {
              if (!self.userInfo.room[0].image_1) {
              } else {
                self.userInfo.room[0].image_1 = imagesToFront[5];
                self.userInfo.room[0].image_2 = imagesToFront[6];
                self.userInfo.room[0].image_3 = imagesToFront[7];
                self.userInfo.room[0].image_4 = imagesToFront[8];
                self.userInfo.room[0].image_5 = imagesToFront[9];
              }
            }
          }
          // console.log(self.userInfo);
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
    getRoomInfo(user) {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + user.perfil[0].id_user + "/room", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.roomInfo = response.data.data;
          const roomImage_1 = response.data.data.room.image_1;
          const roomImage_2 = response.data.data.room.image_2;
          const roomImage_3 = response.data.data.room.image_3;
          const roomImage_4 = response.data.data.room.image_4;
          const roomImage_5 = response.data.data.room.image_5;

          const imagesArray = [
            roomImage_1,
            roomImage_2,
            roomImage_3,
            roomImage_4,
            roomImage_5
          ];

          const imagesToFront = [];

          for (const image of imagesArray) {
            if (image) {
              imagesToFront.push("http://localhost:3001/uploads/" + image);
            } else {
              imagesToFront.push(null);
            }
          }

          self.roomInfo.room.image_1 = imagesToFront[0];
          self.roomInfo.room.image_2 = imagesToFront[1];
          self.roomInfo.room.image_3 = imagesToFront[2];
          self.roomInfo.room.image_4 = imagesToFront[3];
          self.roomInfo.room.image_5 = imagesToFront[4];

          self.openRoomModal();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    likeUser(user) {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + user.perfil[0].id_user + "/like",
          {},
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          self.getUsers();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            text: error.response.data.message
          });
        });
    },
    openUserModal() {
      this.userModal = true;
    },
    openRoomModal() {
      this.roomModal = true;
      // console.log(this.roomInfo);
    },
    closeModal() {
      this.roomModal = false;
      this.userModal = false;
      // this.userInfo = {};
    }
  },
  created() {
    // this.getUsers();
    this.users = [];
    this.userInfo = {};
    this.roomInfo = {};
    this.search = false;
  }
};
</script>

<style>
* {
  box-sizing: border-box;
}

html,
body {
  height: 100%;
}

.home {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.content {
  flex: 1 0 auto;
  padding: 0rem;
}

#searchContainer {
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  width: 400px;
  padding: 1rem 2rem;
  /* margin: 0 auto; */
  background-color: white;
  margin-top: 3rem;
  margin-right: 8rem;
}

#userSearch h2 {
  margin-bottom: 1rem;
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
  flex-direction: column;
  justify-content: space-evenly;
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
  color: #2c3e50;
}
#searchContainer button:hover {
  color: lightcoral;
}
title {
  position: absolute;
  z-index: -12;
}

h2 {
  font-family: "Dm Serif Display";
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  width: 100%;
}

.modalBox {
  overflow-y: auto;
  background: #fefefe;
  margin: 2rem auto;
  padding: 20px;
  border: 1px solid #888;
  width: 60%;
  height: 500px;
}

#deleteSearch {
  border: none;
  background-color: white;
  font-family: "Dm Serif Display";
  font-size: 1.2rem;
  color: lightcoral;
}

#deleteSearch:hover {
  color: #2c3e50;
}

#intro {
  padding: 2rem;
}

.introImagen {
  width: 300px;
  margin: 1rem;
}

.bloque {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 3rem;
}

.texto {
  width: 400px;
  padding: 2rem;
}

.texto h1 {
  font-size: 6rem;
  color: lightcoral;
}

#planta1 {
  position: fixed;
  right: 0;
  bottom: 0;
  z-index: -2;
  width: 340px;
}

#planta8 {
  position: fixed;
  left: 0;
  top: -6rem;
  z-index: -2;
  width: 300px;
  transform: rotate(90deg);
}

.homeContainer {
  display: flex;
  justify-content: center;
  align-content: center;
}

.claim {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;
}

.claim h1 {
  color: lightcoral;
  font-size: 4rem;
}
</style>
