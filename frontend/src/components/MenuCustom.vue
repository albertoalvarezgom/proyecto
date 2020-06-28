<template>
  <div>
    <div id="nav">
      <router-link to="/">roomie</router-link>
      <router-link to="/publicar">Publica tu habitación</router-link>
      <router-link to="/reservas" v-show="checkLogin()">Mis reservas</router-link>
      <router-link to="/mensajes" v-show="checkLogin()">Mis mensajes</router-link>
      <div class="menudesplegable" v-show="checkLogin()">
        <button class="botonmenu">{{ name }}</button>
        <div class="desplegableenlaces">
          <router-link to="/datos-personales">Mis datos</router-link>
          <router-link to="/hobbies">Mis aficiones</router-link>
          <router-link to="/personalidad">Mi personalidad</router-link>
          <router-link to="/valoraciones">Mis valoraciones</router-link>
          <router-link :to="{name: 'Room'}" v-show="checkOwner()">Mi habitación</router-link>
          <button @click="logoutUser()">Logout</button>
        </div>
      </div>
      <router-link to="/login" v-show="!checkLogin()">Login</router-link>
      <router-link to="/registro" v-show="!checkLogin()">Regístrate</router-link>
    </div>
  </div>
</template>

<script>
import {
  clearLogin,
  isLoggedIn,
  checkAdmin,
  getUserName,
  getUserType
} from "@/api/utils.js";

export default {
  name: "MenuCustom",
  data() {
    return {
      name: ` ${getUserName()}`
    };
  },
  methods: {
    logoutUser() {
      if (this.$router.currentRoute.name === "Home") {
        this.$router.go();
      } else {
        this.$router.push("/");
      }
      return clearLogin();
    },
    checkLogin() {
      return isLoggedIn();
    },
    checkIsAdmin() {
      return checkAdmin();
    },
    checkOwner() {
      if (getUserType() === "buscando piso") {
        return false;
      } else {
        return true;
      }
    }
  }
};
</script>

<style>
.botonmenu {
  background-color: #4caf50;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.menudesplegable {
  position: relative;
  display: inline-block;
}

.desplegableenlaces {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

.desplegableenlaces a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.desplegableenlaces a:hover {
  background-color: #ddd;
}

.menudesplegable:hover .desplegableenlaces {
  display: block;
}

.menudesplegable:hover .botonmenu {
  background-color: #3e8e41;
}
</style>