<template>
  <div>
    <vue-headful title="Registro" description="Página de registro" />
    <!-- PÁRRAFO DE AVISO -->
    <p v-show="required">Todos los campos de este formulario son obligatorios : /</p>
    <!-- /PÁRRAFO DE AVISO -->
    <!-- FORMULARIO -->
    <div class="login">
      <h2>¡Vamos, regístrate!</h2>
      <form>
        <fieldset>
          <label for="name">Nombre:</label>
          <input type="text" name="name" placeholder="Escribe tu nombre" v-model="name" />
        </fieldset>
        <fieldset>
          <label for="nbirthday">Fecha de nacimiento:</label>
          <input type="date" name="birthday" v-model="birthday" />
        </fieldset>
        <fieldset>
          <label for="email">Email:</label>
          <input type="email" name="email" placeholder="Escribe tu email" v-model="email" />
        </fieldset>
        <fieldset>
          <label for="password">Contraseña:</label>
          <input
            type="password"
            name="password"
            placeholder="Escribe tu contraseña"
            v-model="password"
          />
        </fieldset>
        <fieldset>
          <label for="city">Ciudad:</label>
          <input type="text" name="city" placeholder="Escribe tu ciudad" v-model="city" />
        </fieldset>
        <fieldset>
          <label for="phone">Número de teléfono</label>
          <input type="text" name="phone" v-model="phone" placeholder="Escribe tu teléfono" />
        </fieldset>
      </form>
      <button @click="addUser(email, password)">Enviar</button>
      <h3 v-show="sent">¡Te hemos enviado un email de confirmación!</h3>
      <!-- /FORMULARIO -->
      <h4>¿Ya estás registrado?</h4>
      <button>
        <router-link :to="{ name: 'Login' }">¡Haz login!</router-link>
      </button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Register",
  data() {
    return {
      name: "",
      birthday: "",
      email: "",
      phone: "",
      password: "",
      city: "",
      correctData: false,
      required: false,
      sent: false
    };
  },
  methods: {
    //Función para comprobar que los inputs no van vacíos
    validatingData() {
      //Si algún campo va vacío...
      if (
        this.name === "" ||
        this.birthday === "" ||
        this.email === "" ||
        this.password === "" ||
        this.city === ""
      ) {
        this.correctData = false; //...datos incorrectos
        this.required = true; // y campos requeridos faltan
      } else {
        //Si están todos llenos...
        this.correctData = true; //...datos correctos
        this.required = false; // y ningún campo falta
      }
    },
    addUser(name, birthday, email, password, city) {
      //Validamos los datos con la función anterior
      this.validatingData();
      //Si los datos son correctos...
      if (this.correctData === true) {
        var self = this;
        //...hacemos la petición post y mandamos los datos
        axios
          .post("http://localhost:3001/user", {
            name: self.name,
            birthday: self.birthday,
            email: self.email,
            password: self.password,
            city: self.city,
            phone: self.phone
          })
          //y a continuación vaciamos los inputs
          .then(function(response) {
            self.sent = true;
            self.emptyFields();
          })
          //y miramos si hay algún error
          .catch(function(error) {
            Swal.fire({
              icon: "error",
              title: error.response.status,
              text: error.response.data.message
            });
          });
        //Lanzamos cuadro de diálogo de éxito :)
        Swal.fire({
          position: "center",
          icon: "success",
          title: "Usuario registrado con éxito :)",
          text: "Revisa tu email, valida tu registo y manos a la obra!",
          showConfirmButton: true
        });
        this.$router.push("/login");
      }
      //Si los datos no son correctos lanzamos un alert
      else {
        //Lanzamos cuadro de diálogo de éxito :)
        Swal.fire({
          position: "center",
          icon: "error",
          title: "Algo falló en el registro :(",
          showConfirmButton: false,
          timer: 1500
        });
      }
    },
    //Función para resetear y vaciar los campos del formulario
    emptyFields() {
      this.name = "";
      this.birthday = "";
      this.email = "";
      this.password = "";
      this.city = "";
    }
  }
};
</script>

<style scoped>
p {
  color: #d9048e;
}

.login {
  margin-top: 6rem;
}

fieldset {
  border: none;
}
</style>
