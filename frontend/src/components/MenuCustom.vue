<template>
  <div>
    <div id="nav">
      <router-link to="/">
        <h1>roomie.</h1>
      </router-link>
      <ul class="menu">
        <li>
          <router-link :to="{name:'Home'}">Home</router-link>
        </li>
        <li>
          <router-link :to="{name:'About'}">About</router-link>
        </li>
        <li>
          <router-link
            :to="{name:'NewRoom'}"
            v-show="!checkOwner() && checkLogin()"
          >Publica tu habitación</router-link>
        </li>
        <li>
          <router-link :to="{name:'Reservas'}" v-show="checkLogin()">Mis reservas</router-link>
        </li>
        <li>
          <router-link :to="{name:'Mensajes'}" v-show="checkLogin()">Mis mensajes</router-link>
        </li>
        <li>
          <div class="menudesplegable" v-show="checkLogin()">
            <button class="botonmenu">{{ name }}</button>
            <div class="desplegableenlaces">
              <router-link :to="{name:'UserProfile'}">Mis datos</router-link>
              <router-link :to="{name:'UserHobby'}">Mis aficiones</router-link>
              <router-link :to="{name:'UserPersonality'}">Mi personalidad</router-link>
              <router-link :to="{name:'UserVotes'}">Mis valoraciones</router-link>
              <router-link :to="{ name: 'Room' }" v-show="checkOwner()">Mi habitación</router-link>
              <button @click="logoutUser()" id="logout">Logout</button>
            </div>
          </div>
        </li>
        <li>
          <router-link :to="{name:'Login'}" v-show="!checkLogin()">Login</router-link>
        </li>
        <li>
          <router-link :to="{name:'Register'}" v-show="!checkLogin()">Regístrate</router-link>
        </li>
      </ul>
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
      this.$router.push("/login");
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
  background-color: white;
  color: lightcoral;
  padding: 6px 16px;
  font-size: 1rem;
  border: none;
  font-family: Raleway;
  font-weight: 700;
  border-left: 1px solid #2c3e50;
}

.menudesplegable {
  position: relative;
  display: inline-block;
}

.desplegableenlaces {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

.desplegableenlaces a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  border-bottom: 2px solid white;
  font-size: 0.9rem;
}

.desplegableenlaces a:hover {
  border-bottom: 2px solid lightcoral;
}

.menudesplegable:hover .desplegableenlaces {
  display: block;
}

.menudesplegable:hover .botonmenu {
  background-color: lightcoral;
  color: white;
  border-left: 1px solid lightcoral;
}

#logout {
  border: none;
  font-family: Raleway;
  font-weight: 500;
  font-size: 16px;
  padding: 0.5rem 1rem;
  width: 100%;
}

#logout:hover {
  background-color: lightcoral;
  color: white;
}

#nav {
  margin-bottom: 2rem;
}

#nav ul {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0;
}

#nav ul li {
  font-size: 0.9rem;
  margin: 0 1rem;
}

h1 {
  margin: 0;
}

.menu {
  margin: 0 auto;
}
</style>
