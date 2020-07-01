<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="Publica tu habitación" description="Publica tu habitación" />
    <h2>Completa el formulario para publicar tu habitación</h2>
    <h4>¡No te olvides que todos los campos son obligatorios!</h4>
    <form>
      <fieldset>
        <label for="title">Título de tu anuncio</label>
        <input type="text" name="title" v-model="title" autocomplete="off" />
      </fieldset>
      <fieldset>
        <label for="description">Descripción de tu anuncio</label>
        <textarea name="description" cols="30" rows="10" v-model="description" autocomplete="off"></textarea>
      </fieldset>
      <fieldset>
        <label for="address">Dirección</label>
        <input type="text" name="address" v-model="address" autocomplete="off" />
      </fieldset>
      <fieldset>
        <label for="postalCode">Código postal</label>
        <input type="text" name="title" v-model="postalCode" autocomplete="off" />
      </fieldset>
      <fieldset>
        <label for="city">Ciudad</label>
        <input type="text" name="city" v-model="city" autocomplete="off" />
      </fieldset>
      <fieldset>
        <label for="flatMates">Compartes piso con...</label>
        <div>
          <input
            type="number"
            name="flatMates"
            min="0"
            max="5"
            v-model="flatmatesMasc"
            autocomplete="off"
          />
          chicos
          <input
            type="number"
            name="flatMates"
            min="0"
            max="5"
            v-model="flatmatesFem"
            autocomplete="off"
          />
          chicas
        </div>
      </fieldset>
      <fieldset>
        <label for="flatSize">Tamaño del piso</label>
        <input type="text" name="flatSize" v-model="flatSize" autocomplete="off" />
      </fieldset>
      <h2>¿Con quién buscas compartir?</h2>
      <fieldset>
        <label for="gender">Prefieres compartir con...</label>
        <select name="gender" v-model="preferenceGender">
          <option value="chico">Chico</option>
          <option value="chica">Chica</option>
          <option value="indiferente">Indiferente</option>
        </select>
      </fieldset>
      <fieldset>
        <label for="status">Prefieres compartir con alguien que esté...</label>
        <select name="status" v-model="status">
          <option value="trabajando">Trabajando</option>
          <option value="estudiando">Estudiando</option>
          <option value="estudiando y trabajando">Ambas</option>
          <option value="nada">Nada</option>
        </select>
      </fieldset>
      <fieldset>
        <label for="age">Edad</label>
        <div>
          mayor de
          <input
            type="number"
            name="age"
            min="18"
            max="50"
            v-model="minAge"
            autocomplete="off"
          />
          y menor de
          <input
            type="number"
            name="age"
            min="18"
            max="50"
            v-model="maxAge"
            autocomplete="off"
          /> años
        </div>
      </fieldset>
      <h2>La habitación</h2>
      <div class="formFlex">
        <fieldset>
          <label for="roomType">Tipo de habitación</label>
          <select name="roomType" v-model="roomType">
            <option value="privada">Privada</option>
            <option value="compartida">Compartida</option>
          </select>
        </fieldset>
        <fieldset>
          <label for="roomSize">Tamaño de la habitación</label>
          <input type="text" name="roomSize" v-model="roomSize" autocomplete="off" />
        </fieldset>
        <fieldset>
          <label for="bedType">Tipo de cama</label>
          <select name="bedType" v-model="bedType">
            <option value="doble">Doble</option>
            <option value="individual">Individual</option>
            <option value="sofa-cama">Sofá-cama</option>
            <option value="sin cama">Sin cama</option>
          </select>
        </fieldset>
      </div>
      <div class="formFlex">
        <fieldset>
          <label for="price">Precio</label>
          <input type="text" name="price" v-model="price" autocomplete="off" />
        </fieldset>
        <fieldset>
          <label for="billsInlcuded">Facturas incluidas</label>
          <input type="checkbox" name="billsIncluded" v-model="billsIncluded" autocomplete="off" />
        </fieldset>
      </div>
      <div class="formFlex">
        <fieldset>
          <label for="deposit">Depósito</label>
          <input type="checkbox" name="deposit" v-model="deposit" autocomplete="off" />
        </fieldset>
        <fieldset>
          <label for="depositAmmount">Cantidad de depósito</label>
          <input type="text" v-model="depositAmmount" autocomplete="off" />
        </fieldset>
      </div>
      <div class="formFlex">
        <fieldset>
          <label for="availabilityFrom">Disponible desde...</label>
          <input type="date" name="availabilityFrom" v-model="availabilityFrom" autocomplete="off" />
        </fieldset>
        <fieldset>
          <label for="availabilityUntil">Disponible hasta...</label>
          <input
            type="date"
            name="availabilityUntil"
            v-model="availabilityUntil"
            autocomplete="off"
          />
        </fieldset>
      </div>
      <fieldset>
        <label for="stay">Duración de la estancia (en meses)</label>
        <div>
          Mínima
          <input
            type="number"
            name="stay"
            min="1"
            max="24"
            v-model="minStay"
            autocomplete="off"
          />
          Máxima
          <input
            type="number"
            name="stay"
            min="1"
            max="24"
            v-model="maxStay"
            autocomplete="off"
          />
        </div>
      </fieldset>
      <h2>Sube tus imágenes</h2>
      <div class="formFlex">
        <fieldset>
          <label for="image_1" class="inputFile">
            Imagen 1
            <input type="file" id="image_1" ref="image_1" @change="handleImage()" />
          </label>
        </fieldset>
        <fieldset>
          <label for="image_2" class="inputFile">
            Imagen 2
            <input type="file" id="image_2" ref="image_2" @change="handleImage()" />
          </label>
        </fieldset>
        <fieldset>
          <label for="image_3" class="inputFile">
            Imagen 3
            <input type="file" id="image_3" ref="image_3" @change="handleImage()" />
          </label>
        </fieldset>
        <fieldset>
          <label for="image_4" class="inputFile">
            Imagen 4
            <input type="file" id="image_4" ref="image_4" @change="handleImage()" />
          </label>
        </fieldset>
        <fieldset>
          <label for="image_5" class="inputFile">
            Imagen 5
            <input type="file" id="image_5" ref="image_5" @change="handleImage()" />
          </label>
        </fieldset>
      </div>
    </form>
    <button @click="newRoom()" class="publishButton">Publicar habitación</button>
    <!-- <button>
      <router-link to="/">Volver a la home</router-link>
    </button>-->
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import menucustom from "@/components/MenuCustom.vue";

export default {
  name: "NewRoom",
  data() {
    return {
      id: localStorage.getItem("id"),
      title: "",
      description: "",
      address: "",
      postalCode: "",
      city: "",
      flatmatesMasc: null,
      flatmatesFem: null,
      flatSize: null,
      preferenceGender: "",
      status: "",
      minAge: null,
      maxAge: null,
      roomType: "",
      roomSize: null,
      bedType: "",
      price: null,
      billsIncluded: false,
      deposit: false,
      depositAmmount: null,
      availabilityFrom: null,
      availabilityUntil: null,
      minStay: null,
      maxStay: null,
      image_1: "",
      image_2: "",
      image_3: "",
      image_4: "",
      image_5: ""
    };
  },
  components: { menucustom },
  methods: {
    newRoom() {
      let self = this;
      let formData = new FormData();
      formData.append("title", self.title);
      formData.append("description", self.description);
      formData.append("address", self.address);
      formData.append("postalCode", self.postalCode);
      formData.append("city", self.city);
      formData.append("flatmatesMasc", self.flatmatesMasc);
      formData.append("flatmatesFem", self.flatmatesFem);
      formData.append("flatSize", self.flatSize);
      formData.append("preferenceGender", self.preferenceGender);
      formData.append("status", self.status);
      formData.append("minAge", self.minAge);
      formData.append("maxAge", self.maxAge);
      formData.append("roomType", self.roomType);
      formData.append("roomSize", self.roomSize);
      formData.append("bedType", self.bedType);
      formData.append("price", self.price);
      formData.append("billsIncluded", self.billsIncluded);
      formData.append("deposit", self.deposit);
      formData.append("depositAmmount", self.depositAmmount);
      formData.append("availabilityFrom", self.availabilityFrom);
      formData.append("availabilityUntil", self.availabilityUntil);
      formData.append("minStay", self.minStay);
      formData.append("maxStay", self.maxStay);
      formData.append("image_1", self.image_1);
      formData.append("image_2", self.image_2);
      formData.append("image_3", self.image_3);
      formData.append("image_4", self.image_4);
      formData.append("image_5", self.image_5);

      axios
        .post("http://localhost:3001/user/" + self.id + "/room", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            authorization: localStorage.getItem("authorization")
          }
        })
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Habitación publicada con éxito :)"
          });
          self.$router.push("/");
          localStorage.setItem("type", "buscando inquilino");
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
      this.image_2 = this.$refs.image_2.files[0];
      this.image_3 = this.$refs.image_3.files[0];
      this.image_4 = this.$refs.image_4.files[0];
      this.image_5 = this.$refs.image_5.files[0];
    }
  }
};
</script>
<style scoped>
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
  width: 20px;
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
}

.publishButton:hover {
  color: lightcoral;
}

label input[type="file"] {
  display: none;
  margin: 0;
}

.inputFile {
  border: none;
  border: 1px solid lightcoral;
  display: inline-block;
  cursor: pointer;
  padding-bottom: 12px;
  padding-top: 6px;
  height: 10px;
  width: 80px;
  margin: 0 auto;
}

.inputFile:hover {
  background-color: lightcoral;
  color: white;
}

.formFlex {
  display: flex;
  justify-content: center;
}
</style>