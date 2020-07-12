<template>
  <div>
    <!-- MENÚ -->
    <menucustom></menucustom>
    <vue-headful title="Login" description="Página de login" />
    <!-- FORMULARIO DE LOGIN -->
    <div class="login">
      <img src="../assets/planta3.jpg" alt="Imagen de registro" id="planta3" />
      <img src="../assets/planta2.jpg" alt="Imagen de login" id="planta2" />
      <div>
        <h2>¡Entra y encuentra a tu roomie!</h2>
        <fieldset>
          <input type="email" placeholder="Email" v-model="email" />
          <input type="password" placeholder="Contraseña" v-model="password" />
          <button @click="login()" class="profileButton">Login</button>
        </fieldset>
        <p id="forgotten">¿Has olvidado tu contraseña?</p>
        <button @click="showInput()" class="passButton">Reestablecer contraseña</button>
        <fieldset>
          <label for="mail" v-show="restore">Escribe tu email:</label>
          <input type="email" name="mail" v-show="restore" v-model="newEmail" />
          <button v-show="restore" @click="restorePassword()" class="profileButton">Enviar</button>
          <p v-show="newPass">Haz login con tu nueva contraseña</p>
        </fieldset>
      </div>
      <!-- /FORMULARIO DE LOGIN -->
    </div>
    <footercustom></footercustom>
  </div>
</template>

<script>
import Swal from "sweetalert2";
import { loginUser } from "../api/utils.js";
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";

import axios from "axios";

export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      newPass: false,
      restore: false,
      newEmail: ""
    };
  },
  components: {
    menucustom,
    footercustom
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
          timer: 1500
        });
        //Si funciona nos vamos a la home
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
      this.restore = true;
    },
    restorePassword(email) {
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
          self.newPass = true;
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

<style scoped>
.login {
  margin-top: 3rem;
  height: 61vh;
}

fieldset {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
fieldset label {
  font-family: raleway;
  font-weight: 800;
  margin: 0;
  margin-bottom: 0.5rem;
}
fieldset button {
  margin: 0 auto;
}
fieldset input {
  margin: 0 auto;
  border: none;
  border-bottom: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 2rem;
  text-align: center;
  width: 200px;
}

.passButton {
  border: none;
  margin-bottom: 3rem;
  background-color: white;
  font-size: 0.8rem;
  color: lightcoral;
}

.passButton:hover {
  color: #2c3e50;
}

#planta2 {
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: -2;
  width: 600px;
}

#planta3 {
  position: fixed;
  right: 0;
  bottom: 0;
  z-index: -2;
  width: 500px;
}
</style>
