<template>
  <div>
    <menucustom></menucustom>
    <vue-headful
      title="Publica tu habitación"
      description="Publica tu habitación"
    />
    <h1>Aquí se publican las habitaciones. Mola bastante, la verdad</h1>
    <form v-show="checkLogin()">
      <fieldset>
        <label for="title">Título de tu anuncio</label>
        <input type="text" name="title" v-model="title" />
      </fieldset>
      <fieldset>
        <label for="description">Descripción de tu anuncio</label>
        <textarea
          name="description"
          cols="30"
          rows="10"
          v-model="description"
        ></textarea>
      </fieldset>
      <fieldset>
        <label for="address">Dirección</label>
        <input type="text" name="address" v-model="address" />
      </fieldset>
      <fieldset>
        <label for="postalCode">Código postal</label>
        <input type="text" name="title" v-model="postalCode" />
      </fieldset>
      <fieldset>
        <label for="city">Ciudad</label>
        <input type="text" name="city" v-model="city" />
      </fieldset>
      <fieldset>
        <label for="flatMates">Compartes piso con...</label>
        <input
          type="number"
          name="flatMates"
          min="0"
          max="5"
          v-model="flatmatesMasc"
        />
        chicos
        <input
          type="number"
          name="flatMates"
          min="0"
          max="5"
          v-model="flatmatesFem"
        />
        chicas
      </fieldset>
      <fieldset>
        <label for="flatSize">Tamaño del piso</label>
        <input type="text" name="flatSize" v-model="flatSize" /> m2
      </fieldset>
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
        <input type="number" name="age" min="18" max="50" v-model="minAge" />
        <input type="number" name="age" min="18" max="50" v-model="maxAge" />
      </fieldset>
      <fieldset>
        <label for="roomType">Tipo de habitación</label>
        <select name="roomType" v-model="roomType">
          <option value="privada">Privada</option>
          <option value="compartida">Compartida</option>
        </select>
      </fieldset>
      <fieldset>
        <label for="roomSize">Tamaño de la habitación</label>
        <input type="text" name="roomSize" v-model="roomSize" /> m2
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
      <fieldset>
        <label for="price">Precio</label>
        <input type="text" name="price" v-model="price" /> €
      </fieldset>
      <fieldset>
        <label for="billsInlcuded">Facturas incluidas</label>
        <input type="checkbox" name="billsIncluded" v-model="billsIncluded" />
      </fieldset>
      <fieldset>
        <label for="deposit">Depósito</label>
        <input type="checkbox" name="deposit" v-model="deposit" />
      </fieldset>
      <fieldset>
        <label for="depositAmmount">Cantidad de depósito</label>
        <input type="text" v-model="depositAmmount" /> €
      </fieldset>
      <fieldset>
        <label for="availabilityFrom">Disponible desde...</label>
        <input type="date" name="availabilityFrom" v-model="availabilityFrom" />
        <label for="availabilityUntil">Disponible hasta...</label>
        <input
          type="date"
          name="availabilityUntil"
          v-model="availabilityUntil"
        />
      </fieldset>
      <fieldset>
        <label for="stay">Duración de la estancia (en meses)</label>
        Mínima
        <input type="number" name="stay" min="1" max="24" v-model="minStay" />
        Máxima
        <input type="number" name="stay" min="1" max="24" v-model="maxStay" />
      </fieldset>
      <fieldset>
        <label>Sube las mejores imágenes de tu piso</label>
        <input type="file" />
        <input type="file" />
        <input type="file" />
        <input type="file" />
        <input type="file" />
      </fieldset>
    </form>
    <button @click="newRoom()">Publicar habitación</button>
    <button>
      <router-link to="/">Volver a la home</router-link>
    </button>
  </div>
</template>

<script>
import { isLoggedIn } from "@/api/utils.js";
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
    };
  },
  components: { menucustom },
  methods: {
    checkLogin() {
      return isLoggedIn();
    },
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

      axios
        .post("http://localhost:3001/user/" + self.id + "/room", formData, {
          headers: { authorization: localStorage.getItem("authorization") },
        })
        .then(function(response) {
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Habitación publicada con éxito :)",
          });
          self.$router.push("/");
          localStorage.setItem("type", "buscando inquilino");
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
