<template>
  <div>
    <vue-headful title="Mis datos personales" description="Mis datos personales" />
    <menucustom></menucustom>
    <img src="../assets/Jarrón.png" alt="Imagen de perfil" id="flores" />
    <div>
      <div v-show="!editInput">
        <img :src="user.image_1" id="profileImage" />
        <!-- <img :src="user.image_2" />
        <img :src="user.image_3" />
        <img :src="user.image_4" />
        <img :src="user.image_5" />-->
        <br />
        <p>Nombre:</p>
        <h2>{{ user.name }}</h2>
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
        <p v-show="ig">Perfil de instagram</p>
        <h2>{{ user.ig_profile }}</h2>
        <br />
        <p>Tipo de usuario:</p>
        <h2>{{ user.type }}</h2>
        <br />
        <h2 id="userStatus">Tu perfil está {{ user.hidden }}</h2>
      </div>
      <div v-show="editInput" class="userForm">
        <div class="formFlex">
          <fieldset>
            <img :src="user.image_1" class="thumb" />
            <label for="image_1" class="inputFile">
              Imagen 1
              <input type="file" id="image_1" ref="image_1" @change="handleImage()" />
            </label>
          </fieldset>
          <!-- <fieldset>
            <img :src="user.image_2" />
            <label for="image_2" class="inputFile">
              Imagen 2
              <input type="file" id="image_2" ref="image_2" @change="handleImage()" />
            </label>
          </fieldset>
          <fieldset>
            <img :src="user.image_3" />
            <label for="image_3" class="inputFile">
              Imagen 3
              <input type="file" id="image_3" ref="image_3" @change="handleImage()" />
            </label>
          </fieldset>
          <fieldset>
            <img :src="user.image_4" />
            <label for="image_4" class="inputFile">
              Imagen 4
              <input type="file" id="image_4" ref="image_4" @change="handleImage()" />
            </label>
          </fieldset>
          <fieldset>
            <img :src="user.userImage_5" />
            <label for="image_5" class="inputFile">
              Imagen 5
              <input type="file" id="image_5" ref="image_5" @change="handleImage()" />
            </label>
          </fieldset>-->
        </div>
        <fieldset>
          <label for="name">Nombre</label>
          <input type="text" :placeholder="[[user.name]]" v-model="newUser.name" />
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
            <option value="trabajando">trabajando</option>
            <option value="estudiando">estudiando</option>
            <option value="estudiando y trabajando">ambas</option>
            <option value="nada">nada</option>
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
          <input type="text" :placeholder="[[user.ig_profile]]" v-model="newUser.ig_profile" />
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
    <div>
      <div>
        <button
          @click="hideUser()"
          v-if="user.hidden === 'visible' && !editInput"
          class="profileButton"
        >Ocultar tu perfil</button>
        <button
          @click="showUser()"
          v-if="user.hidden === 'oculto' && !editInput"
          class="profileButton"
        >Mostrar tu perfil</button>
      </div>
      <br />
      <button v-show="!editInput" @click="showInput()" class="publishButton">Editar info</button>
      <button v-show="editInput" @click="hideInput()" class="publishButton">Cancelar</button>
      <button v-show="editInput" @click="updateUser()" class="publishButton">Guardar cambios</button>
    </div>
    <h2>Cambiar contraseña</h2>
    <br />
    <div class="formFlex">
      <fieldset>
        <label for="old">Contraseña actual</label>
        <input type="password" name="old" v-model="oldPassword" />
      </fieldset>
      <fieldset>
        <label for="old">Contraseña nueva</label>
        <input type="password" name="old" v-model="newPassword" />
      </fieldset>
    </div>
    <button @click="editPassword()" class="profileButton">Cambiar</button>
    <footercustom></footercustom>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import { getUserName } from "../api/utils.js";

export default {
  name: "UserProfile",
  components: { menucustom, footercustom },
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
      ig: true
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

          // if (self.newUser.occupation_status === "trabajando") {
          //   self.newUser.occupation_status = "Trabajando";
          // }

          // console.log(self.newUser.occupation_status);

          if (!self.user.ig_profile) {
            self.ig = false;
          }
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
        let formData = new FormData();
        formData.append("name", self.newUser.name);
        formData.append("birthday", self.newUser.birthday);
        formData.append("userCity", self.newUser.city);
        formData.append("email", self.newUser.email);
        formData.append("phone", self.newUser.phone);
        formData.append("occupationField", self.newUser.occupation_field);
        formData.append("occupationStatus", self.newUser.occupation_status);
        formData.append("couple", self.newUser.couple);
        formData.append("gender", self.newUser.gender);
        formData.append("ig_profile", self.newUser.ig_profile);
        formData.append("type", self.newUser.type);
        formData.append("image_1", self.image_1);
        // formData.append("image_2", self.image_2);
        // formData.append("image_3", self.image_3);
        // formData.append("image_4", self.image_4);
        // formData.append("image_5", self.image_5);

        axios
          .put("http://localhost:3001/user/" + self.id, formData, {
            headers: {
              authorization: localStorage.getItem("authorization"),
              "Content-Type": "multipart/form-data"
            }
          })
          .then(function(response) {
            self.user = self.newUser;
            Swal.fire({
              position: "center",
              icon: "success",
              title: "Usuario actualizado con éxito :)",
              showConfirmButton: false,
              timer: 1500
            });
            self.getUserInfo();
            self.editInput = false;
            // self.$router.go();
          })
          .catch(function(error) {
            Swal.fire({
              icon: "error",
              title: error.response.status,
              text: error.response.data.message
            });
          });
      } else {
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
        .put(
          "http://localhost:3001/user/" + self.id + "/password",
          { oldPassword: self.oldPassword, newPassword: self.newPassword },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Contraseña actualizada con éxito :)",
            showConfirmButton: false,
            timer: 1500
          });
          localStorage.removeItem("type");
          localStorage.removeItem("city");
          localStorage.removeItem("role");
          localStorage.removeItem("name");
          localStorage.removeItem("authorization");
          localStorage.removeItem("id");
          self.$router.push("/login");
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
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
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Tu perfil ha sido ocultado con éxito",
            text:
              "No olvides mostrarlo si quieres realizar búsquedas de usuarios",
            showConfirmButton: true
          });
          self.getUserInfo();
          self.editInput = false;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
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
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Tu perfil ha sido mostrado de nuevo",
            text: "Ya puedes empezar a buscar roomies",
            showConfirmButton: true
          });
          self.getUserInfo();
          self.editInput = false;
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
    this.user = [];
    this.newUser = [];
    this.getUserInfo();
  }
};
</script>

<style scoped>
#profileImage {
  width: 500px;
  margin: 3rem auto;
}

img {
  margin: 0 auto;
}

.userInfo {
  margin-bottom: 2rem;
}

.userForm {
  margin-bottom: 2rem;
}

#userStatus {
  color: lightcoral;
}

h2 {
  margin: 0;
}

h3 {
  margin: 1rem;
}
fieldset {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
fieldset label {
  font-family: raleway;
  font-weight: 800;
  margin: 0;
  margin-bottom: 0.5rem;
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

fieldset textarea {
  margin: 0 auto;
  border: none;
  border: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 1rem;
  width: 400px;
}

input[type="number"] {
  width: 30px;
  margin: 1rem;
}

fieldset select {
  margin: 0 auto;
  border: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 1rem;
}
fieldset checkbox {
  border: none;
  border: 1px solid lightcoral;
}

.publishButton {
  font-family: "Dm Serif Display";
  border: none;
  background-color: white;
  border-bottom: 2px solid lightcoral;
  font-size: 2rem;
  color: #2c3e50;
  margin: 3rem;
  margin-top: 0rem;
}

.publishButton:hover {
  color: lightcoral;
}

label input[type="file"] {
  display: none;
  margin: 0;
}

.inputFile {
  display: flex;
  background-color: white;
  border: none;
  border: 1px solid lightcoral;
  padding: 1rem 0.4rem;
  /* padding-bottom: 12px;
  padding-top: 6px; */
  height: 10px;
  width: 80px;
  margin: 0 auto;
  align-content: center;
  align-items: center;
  justify-content: center;
}

.inputFile:hover {
  background-color: lightcoral;
  color: white;
}
.formFlex {
  /* display: flex; */
  justify-content: center;
}

.thumb {
  width: 300px;
  margin-bottom: 1rem;
}

#flores {
  position: fixed;
  left: -10px;
  bottom: -90px;
  z-index: 0;
  width: 500px;
}
</style>
