<template>
  <div>
    <div class="login">
      <menucustom></menucustom>
      <fieldset>
        <input type="email" placeholder="Email" v-model="email" />
        <input type="password" placeholder="Contraseña" v-model="password" />
        <button @click="login()">Login</button>
      </fieldset>
      <p>¿Has olvidado tu contraseña?</p>
      <button @click="showInput()">Reestablecer contraseña</button>
      <label for="mail" v-show="restoreEmail">Escribe tu email:</label>
      <input type="email" name="mail" v-show="restoreEmail" v-model="newEmail" />
      <button v-show="restoreEmail" @click="restorePassword()">Enviar</button>
      <p v-show="newPass">Haz login con tu nueva contraseña</p>
    </div>
  </div>
</template>

<script>
import Swal from "sweetalert2";
import { loginUser } from "../api/utils.js";
import menucustom from "@/components/MenuCustom.vue";
import axios from "axios";

export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      newPass: false,
      restoreEmail: false,
      newEmail: ""
    };
  },
  components: { menucustom },
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
          timer: 1500
        });
        //Si funciona nos vamos a la página de productos
        this.$router.push("/");
      } catch (error) {
        Swal.fire({
          icon: "error",
          title: error.response.status,
          text: error.response.data.message
        });
      }
    },
    showInput() {
      this.restoreEmail = true;
    },
    restorePassword() {
      let self = this;
      axios
        .put("http://localhost:3001/user/restore", {
          email: self.newEmail
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Hemos enviado tu nueva contraseña a tu email",
            text: "¡Revisa tu carpeta de spam por si acaso!"
          });
          this.newPass = true;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    }
  }
};
</script>

<style></style>
