<template>
  <div>
    <vue-headful title="Mis datos personales" description="Mis datos personales" />
    <menucustom></menucustom>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Nombre:</p>
        <h2>{{user.name}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Nombre</label>
        <input type="text" :placeholder="[[user.name]]" v-model="newUser.name" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Fecha de nacimiento:</p>
        <h2>{{user.birthday}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="birthday">Fecha de nacimiento</label>
        <input type="date" v-model="newUser.birthday" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Ciudad:</p>
        <h2>{{user.city}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="city">Ciudad</label>
        <input type="text" v-model="newUser.city" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Email:</p>
        <h2>{{user.email}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="email">Email</label>
        <input type="email" v-model="newUser.email" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Teléfono:</p>
        <h2>{{user.phone}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="phone">Número de teléfono</label>
        <input type="phone" v-model="newUser.phone" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        Género:
        <h2>{{user.gender}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Género</label>
        <select name="gender" v-model="newUser.gender">
          <option value="chico">Masculino</option>
          <option value="chica">Femenino</option>
          <option value="otro">Otro</option>
        </select>
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Campo profesional:</p>
        <h2>{{user.occupation_field}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="occupationField">Campo profesional:</label>
        <input type="text" v-model="newUser.occupation_field" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Estado laboral:</p>
        <h2>{{user.occupation_status}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Estado laboral</label>
        <select name="occupationStatus" v-model="newUser.occupation_status">
          <option value="trabajando">Trabajando</option>
          <option value="estudiando">Estudiando</option>
          <option value="estudiando y trabajando">Ambas</option>
          <option value="nada">Nada</option>
        </select>
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Pareja:</p>
        <h2>{{user.couple}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Con pareja</label>
        <select name="couple" v-model="newUser.couple">
          <option value="1">Sí</option>
          <option value="0">No</option>
        </select>
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Perfil de instagram</p>
        <h2>{{user.ig_profile}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Perfil de instagram</label>
        <input type="text" :placeholder="[[user.ig_profile]]" v-model="newUser.ig_profile" />
      </fieldset>
    </div>
    <div class="images">
      <p>Imágenes</p>
      <div class="inputEdit" v-show="!editInput">
        <img :src="user.image_1" />
        <img :src="user.image_2" />
        <img :src="user.image_3" />
        <img :src="user.image_4" />
        <img :src="user.image_5" />
      </div>
      <fieldset v-show="editInput">
        <label for="name">Imagen 1</label>
        <input type="file" />
        <label for="name">Imagen 2</label>
        <input type="file" />
        <label for="name">Imagen 3</label>
        <input type="file" />
        <label for="name">Imagen 4</label>
        <input type="file" />
        <label for="name">Imagen 5</label>
        <input type="file" />
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Ocultar tu cuenta de usuario:</p>
        <h2>{{user.hidden}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">Ocultar cuenta de usuario</label>
        <select name="hidden" v-model="newUser.hidden">
          <option value="1">Sí</option>
          <option value="0">No</option>
        </select>
      </fieldset>
    </div>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Tipo de usuario:</p>
        <h2>{{user.type}}</h2>
      </div>
      <fieldset v-show="editInput">
        <label for="name">¿Qué estás buscando en roomie?</label>
        <select name="type" v-model="newUser.type">
          <option value="buscando inquilino">Buscando inquilino</option>
          <option value="buscando piso">Buscando piso</option>
        </select>
      </fieldset>
    </div>
    <button v-show="!editInput" @click="showInput()">Editar info</button>
    <button v-show="editInput" @click="hideInput()">Cancelar</button>
    <button v-show="editInput" @click="updateUser()">Guardar cambios</button>
    <div>
      <p>Cambiar contraseña</p>
      <label for="old">Contraseña actual</label>
      <input type="password" name="old" v-model="oldPassword" />
      <label for="old">Contraseña nueva</label>
      <input type="password" name="old" v-model="newPassword" />
      <button @click="editPassword()">Cambiar</button>
    </div>
    <div>
      <p>Ocultar tu cuenta de usuario</p>
      <fieldset>
        <button>Ocultar tu cuenta</button>
      </fieldset>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";
import { getUserName } from "../api/utils.js";

export default {
  name: "UserProfile",
  components: { menucustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      user: [],
      newUser: [],
      editInput: false,
      correctData: false,
      required: false,
      empty: false,
      oldPassword: "",
      newPassword: ""
    };
  },
  methods: {
    getUserInfo() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.user = response.data.data.profile;
          self.newUser = response.data.data.profile;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    //Función para comprobar que los inputs no van vacíos
    validatingData() {
      //Si algún campo va vacío...
      if (
        this.newUser.name === "" ||
        this.newUser.birthday === "" ||
        this.newUser.city === "" ||
        this.newUser.email === "" ||
        this.newUser.type === ""
      ) {
        this.correctData = false; //...datos incorrectos
        this.required = true; // y campos requeridos faltan
      } else {
        //Si están todos llenos...
        this.correctData = true; //...datos correctos
        this.required = false; // y ningún campo falta
      }
    },
    updateUser() {
      //Validamos los datos con la función anterior
      this.validatingData();
      //Si los datos son correctos...
      if (this.correctData === true) {
        let self = this;
        axios
          .put("http://localhost:3001/user/" + self.id, {
            headers: { authorization: localStorage.getItem("authorization") },
            name: self.newUser.name,
            birthday: self.newUser.birthday,
            userCity: self.newUser.city,
            email: self.newUser.email,
            phone: self.newUser.phone,
            occupationField: self.newUser.occupation_field,
            occupationStatus: self.newUser.occupation_status,
            couple: self.newUser.couple,
            gender: self.newUser.gender,
            ig_profile: self.newUser.ig_profile,
            type: self.newUser.type,
            hidden: self.newUser.hidden
          })
          .then()
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
          title: "Usuario actualizado con éxito :)",
          showConfirmButton: false,
          timer: 1500
        });

        this.$router.push("/");
      } //Si los datos no son correctos lanzamos un alert
      else {
        //Lanzamos cuadro de diálogo de éxito :)
        Swal.fire({
          position: "center",
          icon: "error",
          title: "Debes rellenar todos los campos del formulario :(",
          showConfirmButton: false,
          timer: 1500
        });
      }
    },
    showInput() {
      this.editInput = true;
      return this.editInput;
    },
    hideInput() {
      this.editInput = false;
      return this.editInput;
    },
    editPassword() {
      let self = this;
      axios
        .put("http://localhost:3001/user/" + self.id + "/password", {
          headers: { authorization: localStorage.getItem("authorization") },
          oldPassword: self.oldPassword,
          newPassword: self.newPassword
        })
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Contraseña actualizada con éxito :)",
            showConfirmButton: false,
            timer: 1500
          });
          self.$router.push("/login");
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
    this.getUserInfo();
  }
};
</script>

<style>
.editButton {
  width: 10px;
  height: 13px;
  border-radius: 20px;
  border: 1px solid red;
  margin-left: 1rem;
}

.inputEdit {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>