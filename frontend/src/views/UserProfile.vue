<template>
  <div>
    <vue-headful
      title="Mis datos personales"
      description="Mis datos personales"
    />
    <menucustom></menucustom>
    <div>
      <div class="inputEdit" v-show="!editInput">
        <p>Nombre:</p>
        <h2>{{ user.name }}</h2>
        <br />
        <img :src="user.image_1" />
        <img :src="user.image_2" />
        <img :src="user.image_3" />
        <img :src="user.image_4" />
        <img :src="user.image_5" />
        <br />
        <p>Fecha de nacimiento:</p>
        <h2>{{ user.birthday }}</h2>
        <br />
        <p>Ciudad:</p>
        <h2>{{ user.city }}</h2>
        <br />
        <p>Email:</p>
        <h2>{{ user.email }}</h2>
        <br />
        <p>Teléfono:</p>
        <h2>{{ user.phone }}</h2>
        <br />
        <p>Género:</p>
        <h2>{{ user.gender }}</h2>
        <br />
        <p>Campo profesional:</p>
        <h2>{{ user.occupation_field }}</h2>
        <br />
        <p>Estado laboral:</p>
        <h2>{{ user.occupation_status }}</h2>
        <br />
        <p>Pareja:</p>
        <h2>{{ user.couple }}</h2>
        <br />
        <p>Perfil de instagram</p>
        <h2>{{ user.ig_profile }}</h2>
        <br />
        <p>Tu perfil está {{ user.hidden }}</p>
        <br />
        <p>Tipo de usuario:</p>
        <h2>{{ user.type }}</h2>
      </div>
      <div v-show="editInput">
        <fieldset>
          <label for="name">Nombre</label>
          <input
            type="text"
            :placeholder="[[user.name]]"
            v-model="newUser.name"
          />
        </fieldset>
        <fieldset>
          <label for="birthday">Fecha de nacimiento</label>
          <input type="date" v-model="newUser.birthday" />
        </fieldset>
        <fieldset>
          <label for="city">Ciudad</label>
          <input type="text" v-model="newUser.city" />
        </fieldset>
        <fieldset>
          <label for="city">Ciudad</label>
          <input type="text" v-model="newUser.city" />
        </fieldset>
        <fieldset>
          <label for="email">Email</label>
          <input type="email" v-model="newUser.email" />
        </fieldset>
        <fieldset>
          <label for="phone">Número de teléfono</label>
          <input type="phone" v-model="newUser.phone" />
        </fieldset>
        <fieldset>
          <label for="name">Género</label>
          <select name="gender" v-model="newUser.gender">
            <option value="chico">Masculino</option>
            <option value="chica">Femenino</option>
            <option value="otro">Otro</option>
          </select>
        </fieldset>
        <fieldset>
          <label for="occupationField">Campo profesional:</label>
          <input type="text" v-model="newUser.occupation_field" />
        </fieldset>
        <fieldset>
          <label for="name">Estado laboral</label>
          <select name="occupationStatus" v-model="newUser.occupation_status">
            <option value="Trabajando">Trabajando</option>
            <option value="Estudiando">Estudiando</option>
            <option value="Estudiando y trabajando">Ambas</option>
            <option value="Nada">Nada</option>
          </select>
        </fieldset>
        <fieldset>
          <label for="name">Con pareja</label>
          <select name="couple" v-model="newUser.couple">
            <option value="Sí">Sí</option>
            <option value="No">No</option>
          </select>
        </fieldset>
        <fieldset>
          <label for="name">Perfil de instagram</label>
          <input
            type="text"
            :placeholder="[[user.ig_profile]]"
            v-model="newUser.ig_profile"
          />
        </fieldset>
        <fieldset>
          <img :src="user.image_1" />
          <label for="image_1">Imagen 1</label>
          <input
            type="file"
            id="image_1"
            ref="image_1"
            @change="handleImage()"
          />
          <img :src="user.image_2" />
          <label for="image_2">Imagen 2</label>
          <input
            type="file"
            id="image_2"
            ref="image_2"
            @change="handleImage()"
          />
          <img :src="user.image_3" />
          <label for="image_3">Imagen 3</label>
          <input
            type="file"
            id="image_3"
            ref="image_3"
            @change="handleImage()"
          />
          <img :src="user.image_4" />
          <label for="image_4">Imagen 4</label>
          <input
            type="file"
            id="image_4"
            ref="image_4"
            @change="handleImage()"
          />
          <img :src="user.userImage_5" />
          <label for="image_5">Imagen 5</label>
          <input
            type="file"
            id="image_5"
            ref="image_5"
            @change="handleImage()"
          />
        </fieldset>
        <fieldset>
          <label for="name">¿Qué estás buscando en roomie?</label>
          <select name="type" v-model="newUser.type">
            <option value="buscando inquilino">Buscando inquilino</option>
            <option value="buscando piso">Buscando piso</option>
          </select>
        </fieldset>
      </div>
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
      <button @click="hideUser()" v-if="user.hidden === 'visible'">
        Ocultar tu perfil
      </button>
      <button @click="showUser()" v-if="user.hidden === 'oculto'">
        Mostrar tu perfil
      </button>
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
      newPassword: "",
      image_1: "",
      image_2: "",
      image_3: "",
      image_4: "",
      image_5: "",
    };
  },
  methods: {
    getUserInfo() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id, {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          self.user = response.data.data.profile;
          self.newUser = response.data.data.profile;
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
            userImage_5,
          ];

          const imagesToFront = [];

          for (const image of imagesArray) {
            if (image) {
              imagesToFront.push("http://localhost:3001/uploads/" + image);
            } else {
              imagesToFront.push(null);
            }
          }

          if (!self.user) {
            self.user.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
            self.newUser.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
          } else {
            self.user.image_1 = imagesToFront[0];
            self.user.image_2 = imagesToFront[1];
            self.user.image_3 = imagesToFront[2];
            self.user.image_4 = imagesToFront[3];
            self.user.image_5 = imagesToFront[4];
            self.newUser.image_1 = imagesToFront[0];
            self.newUser.image_2 = imagesToFront[1];
            self.newUser.image_3 = imagesToFront[2];
            self.newUser.image_4 = imagesToFront[3];
            self.newUser.image_5 = imagesToFront[4];
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
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

        let formData = new FormData();
        formData.append("name", self.newUser.name);
        formData.append("birthday", self.newUser.birthday);
        formData.append("userCity", self.newUser.city);
        formData.append("email", self.newUser.email);
        formData.append("phone", self.newUser.phone);
        formData.append("occupationField", self.newUser.occupation_field);
        formData.append("occupationstatus", self.newUser.occupation_status);
        formData.append("couple", self.newUser.occupation_couple);
        formData.append("gender", self.newUser.gender);
        formData.append("ig_profile", self.newUser.ig_profile);
        formData.append("type", self.newUser.type);
        formData.append("hidden", self.newUser.hidden);
        formData.append("image_1", self.image_1);
        formData.append("image_2", self.image_2);
        formData.append("image_3", self.image_3);
        formData.append("image_4", self.image_4);
        formData.append("image_5", self.image_5);
        console.log(self.newUser.gender);
        axios
          .put("http://localhost:3001/user/" + self.id, formData, {
            headers: {
              "Content-Type": "multipart/form-data",
              authorization: localStorage.getItem("authorization"),
            },
          })
          .then(function(response) {
            self.user = self.newUser;
            Swal.fire({
              position: "center",
              icon: "success",
              title: "Usuario actualizado con éxito :)",
              showConfirmButton: false,
              timer: 1500,
            });
            self.$router.go();
          })
          .catch(function(error) {
            Swal.fire({
              icon: "error",
              title: error.response.status,
              text: error.response.data.message,
            });
          });
      } //Si los datos no son correctos lanzamos un alert
      else {
        //Lanzamos cuadro de diálogo de éxito :)
        Swal.fire({
          position: "center",
          icon: "error",
          title: "Debes rellenar todos los campos del formulario :(",
          showConfirmButton: false,
          timer: 1500,
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
        .put(
          "http://localhost:3001/user/" + self.id + "/password",
          { oldPassword: self.oldPassword, newPassword: self.newPassword },
          {
            headers: { authorization: localStorage.getItem("authorization") },
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Contraseña actualizada con éxito :)",
            showConfirmButton: false,
            timer: 1500,
          });
          self.$router.push("/login");
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
    },
    handleImage() {
      this.image_1 = this.$refs.image_1.files[0];
    },
    hideUser() {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/hide",
          {},
          {
            headers: { authorization: localStorage.getItem("authorization") },
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Tu perfil ha sido ocultado con éxito",
            text:
              "No olvides mostrarlo si quieres realizar búsquedas de usuarios",
            showConfirmButton: true,
          });
          self.getUserInfo();
          // self.$router.go();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message,
          });
        });
    },
    showUser() {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/show",
          {},
          {
            headers: { authorization: localStorage.getItem("authorization") },
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Tu perfil ha sido mostrado de nuevo",
            text: "Ya puedes empezar a buscar roomies",
            showConfirmButton: true,
          });
          self.getUserInfo();
          // self.$router.go();
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
  created() {
    this.getUserInfo();
  },
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

/* .inputEdit {
  display: flex;
  justify-content: center;
  align-items: center;
} */
</style>
