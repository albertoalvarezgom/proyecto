<template>
  <div>
    <menucustom></menucustom>
    <!-- <logincustom
      :email="email"
      :password="password"
      :newPass="newPass"
      :restore="restore"
      :newEmail="newEmail"
      v-on:login="login"
      v-on:show="showInput"
      v-on:restore="restorePassword"
    ></logincustom> -->
    <div class="login">
      <fieldset>
        <input type="email" placeholder="Email" v-model="email" />
        <input type="password" placeholder="Contraseña" v-model="password" />
        <button @click="login()">Login</button>
      </fieldset>
      <p>¿Has olvidado tu contraseña?</p>
      <button @click="showInput()">Reestablecer contraseña</button>
      <label for="mail" v-show="restore">Escribe tu email:</label>
      <input type="email" name="mail" v-show="restore" v-model="newEmail" />
      <button v-show="restore" @click="restorePassword()">
        Enviar
      </button>
      <p v-show="newPass">Haz login con tu nueva contraseña</p>
    </div>
  </div>
</template>

<script>
import Swal from "sweetalert2";
import { loginUser } from "../api/utils.js";
import menucustom from "@/components/MenuCustom.vue";
// import logincustom from "@/components/LoginCustom.vue";
import axios from "axios";

export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      newPass: false,
      restore: false,
      newEmail: "",
    };
  },
  components: {
    menucustom,
    // logincustom,
  },
  methods: {
    async login() {
      try {
        //Intentamos hacer login
        await loginUser(this.email, this.password);
        //Lanzamos cuadro de diálogo de éxito :)
        Swal.fire({
          position: "center",
          icon: "success",
          title: "Login correcto. ¡Bienvenido/a!",
          showConfirmButton: false,
          timer: 1500,
        });
        //Si funciona nos vamos a la home
        this.$router.push("/");
      } catch (error) {
        Swal.fire({
          icon: "error",
          title: error.response.status,
          text: error.response.data.message,
        });
      }
    },
    showInput() {
      this.restore = true;
    },
    restorePassword(email) {
      let self = this;
      axios
        .put("http://localhost:3001/user/restore", {
          email: email,
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Hemos enviado tu nueva contraseña a tu email",
            text: "¡Revisa tu carpeta de spam por si acaso!",
          });
          this.newPass = true;
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
};
</script>

<style></style>
