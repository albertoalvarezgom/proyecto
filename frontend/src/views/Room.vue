<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="Mi habitación" description="Página de tu habitación" />
    <!-- <img src="../assets/flor.jpg" alt="Imagen de habitación" id="flor" /> -->
    <img src="../assets/fento.png" alt="Imagen de habitación" id="fento" />
    <p v-show="!room">Todavía no tienes una habitación publicada</p>
    <div class="room">
      <h2>{{ room.title }}</h2>
      <h2 class="type">{{ room.price }} €/mes</h2>
      <br />
      <img :src="room.image_1" id="roomImage" />

      <p id="description">{{ room.description }}</p>
      <br />
      <h2 class="type">Dirección</h2>
      <p>{{ room.address }}</p>
      <p>{{ room.postal_code }}</p>
      <p>{{ room.city }}</p>
      <br />
      <h2 class="type">El piso</h2>
      <p>El piso tiene {{ room.flat_size }} m2</p>
      <div v-show="sharing">
        <p>Comparto piso con</p>
        <p>{{ room.flatmates_masc }} chicos</p>
        <p>{{ room.flatmates_fem }} chicas</p>
      </div>
      <p v-show="!sharing">No comparto piso con nadie ahora mismo</p>
      <br />
      <h2 class="type">Busco...</h2>
      <p v-show="gender">Prefiero que mi roomie sea {{ room.preference_gender }}</p>
      <p v-show="status">Prefiero que mi roomie esté {{ room.status }}</p>
      <p v-show="age">
        Busco alguien que tenga entre {{ room.min_age }} y
        {{ room.max_age }} años
      </p>
      <p v-show="minAge">Busco alguien que tenga más de {{ room.min_age }}</p>
      <p v-show="maxAge">Busco alguien que tenga menos de {{ room.max_age }}</p>
      <br />
      <h2 class="type">La habitación</h2>
      <p>La habitación es {{ room.room_type }}</p>
      <p>La habitación tiene {{ room.room_size }} m2</p>
      <p v-show="bed">La cama es {{ room.bed_type }}</p>
      <p v-show="!bed">La habitacón no tiene cama</p>
      <p v-show="bills">Las facturas están incluidas en el precio</p>
      <p v-show="deposit">Se pide un depósito de {{ room.deposit_ammount }} €</p>
      <p>La habitación está disponible desde el {{ room.availability_from }} hasta el {{ room.availability_until }}</p>
      <p>La estancia mínima es de {{ room.min_stay }} meses y la máxima de {{ room.max_stay }}</p>
      <br />
      <p>Habitación vista {{ room.views }} veces</p>
      <br />
      <button @click="openModal()" class="profileButton">Editar habitación</button>
      <button @click="deleteRoom()" class="profileButton">Eliminar habitación</button>
    </div>
    <div class="modal" v-show="modal">
      <div class="modalBox">
        <form id="updateRoom">
          <fieldset>
            <label for="title">Título de tu anuncio</label>
            <input type="text" name="title" v-model="newRoom.title" />
          </fieldset>
          <fieldset>
            <label for="description">Descripción de tu anuncio</label>
            <textarea name="description" cols="30" rows="10" v-model="newRoom.description"></textarea>
          </fieldset>
          <fieldset>
            <label for="address">Dirección</label>
            <input type="text" name="address" v-model="newRoom.address" />
          </fieldset>
          <fieldset>
            <label for="postalCode">Código postal</label>
            <input type="text" name="postalCode" v-model="newRoom.postal_code" />
          </fieldset>
          <fieldset>
            <label for="city">Ciudad</label>
            <input type="text" name="city" v-model="newRoom.city" />
          </fieldset>
          <fieldset>
            <label for="flatMates">Compartes piso con...</label>
            <div>
              <input
                type="number"
                name="flatMates"
                min="0"
                max="5"
                v-model="newRoom.flatmates_masc"
              />
              chicos
              <input
                type="number"
                name="flatMates"
                min="0"
                max="5"
                v-model="newRoom.flatmates_fem"
              />
              chicas
            </div>
          </fieldset>
          <fieldset>
            <label for="flatSize">Tamaño del piso</label>
            <input type="text" name="flatSize" v-model="newRoom.flat_size" />
          </fieldset>
          <fieldset>
            <label for="gender">Prefiero compartir con...</label>
            <select name="gender" v-model="newRoom.preference_gender">
              <option value="chico">Chico</option>
              <option value="chica">Chica</option>
              <option value="indiferente">Indiferente</option>
            </select>
          </fieldset>
          <fieldset>
            <label for="status">Prefiero compartir con alguien que esté...</label>
            <select name="status" v-model="newRoom.status">
              <option value="trabajando">Trabajando</option>
              <option value="estudiando">Estudiando</option>
              <option value="estudiando y trabajando">Ambas</option>
            </select>
          </fieldset>
          <fieldset>
            <label for="age">Edad</label>
            <div>
              <input type="number" name="age" min="18" max="50" v-model="newRoom.min_age" />
              <input type="number" name="age" min="18" max="50" v-model="newRoom.max_age" />
            </div>
          </fieldset>
          <fieldset>
            <label for="roomType">Tipo de habitación</label>
            <select name="roomType" v-model="newRoom.room_type">
              <option value="privada">Privada</option>
              <option value="compartida">Compartida</option>
            </select>
          </fieldset>
          <fieldset>
            <label for="roomSize">Tamaño de la habitación</label>
            <input type="text" name="roomSize" v-model="newRoom.room_size" />
          </fieldset>
          <fieldset>
            <label for="bedType">Tipo de cama</label>
            <select name="bedType" v-model="newRoom.bed_type">
              <option value="doble">Doble</option>
              <option value="individual">Individual</option>
              <option value="sofá cama">Sofá-cama</option>
              <option value="sin cama">Sin cama</option>
            </select>
          </fieldset>
          <fieldset>
            <label for="price">Precio</label>
            <input type="text" name="price" v-model="newRoom.price" />
          </fieldset>
          <fieldset>
            <label for="billsInlcuded">Facturas incluidas</label>
            <input type="checkbox" name="billsIncluded" v-model="newRoom.bills_included" />
          </fieldset>
          <fieldset>
            <label for="deposit">Depósito</label>
            <input type="checkbox" name="deposit" v-model="newRoom.deposit" />
          </fieldset>
          <fieldset>
            <label for="depositAmmount">Cantidad de depósito</label>
            <input type="text" v-model="newRoom.deposit_ammount" />
          </fieldset>
          <fieldset>
            <label for="availabilityFrom">Disponible desde...</label>
            <input type="date" name="availabilityFrom" v-model="newRoom.availability_from" />
            <label for="availabilityUntil">Disponible hasta...</label>
            <input type="date" name="availabilityUntil" v-model="newRoom.availability_until" />
          </fieldset>
          <fieldset>
            <label for="stay">Duración de la estancia (en meses)</label>
            <div>
              Mínima
              <input type="number" name="stay" min="1" max="24" v-model="newRoom.min_stay" />
              Máxima
              <input
                type="number"
                name="stay"
                min="1"
                max="24"
                v-model="newRoom.max_stay"
              />
            </div>
          </fieldset>
          <h2>Sube las mejores imágenes de tu piso</h2>
          <fieldset>
            <img :src="room.image_1" />
            <label for="image_1" class="inputFile">
              <p>Imagen</p>
              <input type="file" id="image_1" ref="image_1" @change="handleImage()" />
            </label>
          </fieldset>
        </form>
        <button @click="updateRoom()" class="publishButton">Guardar cambios</button>
        <br />
        <button @click="closeModal()" class="profileButton">Cerrar</button>
      </div>
    </div>
    <div id="prestaciones">
      <h2>Prestaciones</h2>
      <ul class="facilityContainer">
        <li v-for="(facility, index) in facilities" :key="facility.id_facility">
          <button
            value="facility.name"
            :class="{
              activado: facility.status === 1,
              desactivado: facility.status === 0,
            }"
            @click="selectFacility(index)"
          >{{ facility.name }}</button>
        </li>
      </ul>
      <button @click="editRoomFacilities()" class="publishButton">Guardar cambios</button>
    </div>
    <footercustom></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";
export default {
  name: "Room",
  components: { menucustom, footercustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      room: [],
      newRoom: [],
      facilities: [],
      gender: true,
      sharing: true,
      status: true,
      age: false,
      minAge: false,
      maxAge: false,
      bed: true,
      bills: false,
      deposit: true,
      from: true,
      until: true,
      minStay: false,
      maxStay: false,
      modal: false,
      facilities: [],
      selectedFacilities: [],
      selectedFacilitiesNames: [],
      image_1: ""
      // image_2: "",
      // image_3: "",
      // image_4: "",
      // image_5: ""
    };
  },
  methods: {
    viewRoom() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/room", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.room = response.data.data.room;
          self.newRoom = self.room;

          console.log(self.newRoom);
          const roomImage_1 = response.data.data.room.image_1;
          const roomImage_2 = response.data.data.room.image_2;
          const roomImage_3 = response.data.data.room.image_3;
          const roomImage_4 = response.data.data.room.image_4;
          const roomImage_5 = response.data.data.room.image_5;

          const imagesArray = [
            roomImage_1,
            roomImage_2,
            roomImage_3,
            roomImage_4,
            roomImage_5
          ];

          const imagesToFront = [];

          for (const image of imagesArray) {
            if (image) {
              imagesToFront.push("http://localhost:3001/uploads/" + image);
            } else {
              imagesToFront.push(null);
            }
          }

          if (self.room.image_1 === null) {
            self.room.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
            self.newRoom.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
          } else {
            self.room.image_1 = imagesToFront[0];
            self.room.image_2 = imagesToFront[1];
            self.room.image_3 = imagesToFront[2];
            self.room.image_4 = imagesToFront[3];
            self.room.image_5 = imagesToFront[4];
            self.newRoom.image_1 = imagesToFront[0];
            self.newRoom.image_2 = imagesToFront[1];
            self.newRoom.image_3 = imagesToFront[2];
            self.newRoom.image_4 = imagesToFront[3];
            self.newRoom.image_5 = imagesToFront[4];
          }

          //CONTROLANDO Y FORMATEANDO INFO DEL PISO
          if (self.newRoom.preference_gender === "indiferente") {
            self.gender = false;
          }

          if (
            self.newRoom.flatmates_masc === 0 &&
            self.newRoom.flatmates_fem === 0
          ) {
            self.sharing = false;
          }
          if (!self.newRoom.status) {
            self.status = false;
          }
          if (!self.newRoom.min_age && !self.newRoom.max_age) {
            self.age = false;
          } else if (!self.newRoom.min_age) {
            self.age = false;
            self.maxAge = true;
            self.minAge = false;
          } else if (!self.newRoom.max_age) {
            self.age = false;
            self.minAge = true;
            self.maxAge = false;
          } else {
            self.age = true;
          }

          if (self.newRoom.bed_type === "sin cama") {
            self.bed = false;
          }
          if (!self.newRoom.bills_included) {
            self.bills = false;
          } else {
            self.bills = true;
          }
          if (!self.newRoom.deposit) {
            self.deposit = false;
          } else {
            self.deposit = true;
          }
          if (!self.newRoom.availability_from) {
            self.from = false;
          } else {
            self.from = true;
          }
          if (!self.newRoom.availability_until) {
            self.until = false;
          } else {
            self.until = true;
          }

          if (self.newRoom.min_stay) {
            self.minStay = true;
          }
          if (self.newRoom.max_stay) {
            self.maxStay = true;
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
    deleteRoom() {
      let self = this;
      axios
        .delete("http://localhost:3001/user/" + self.id + "/room", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "La habitación ha sido borrada"
          });
          localStorage.setItem("type", "buscando piso");
          self.$router.push("/datos-personales");
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    updateRoom() {
      let self = this;

      if (!self.newRoom.bills_included) {
        self.newRoom.bills_included = false;
      } else {
        self.newRoom.bills_included = true;
      }
      if (!self.newRoom.deposit) {
        self.newRoom.deposit = false;
      } else {
        self.newRoom.deposit = true;
      }

      let formData = new FormData();
      formData.append("title", self.newRoom.title);
      formData.append("description", self.newRoom.description);
      formData.append("address", self.newRoom.address);
      formData.append("postalCode", self.newRoom.postal_code);
      formData.append("city", self.newRoom.city);
      formData.append("flatmatesMasc", self.newRoom.flatmates_masc);
      formData.append("flatmatesFem", self.newRoom.flatmates_fem);
      formData.append("flatSize", self.newRoom.flat_size);
      formData.append("preferenceGender", self.newRoom.preference_gender);
      formData.append("status", self.newRoom.status);
      formData.append("minAge", self.newRoom.min_age);
      formData.append("maxAge", self.newRoom.max_age);
      formData.append("roomType", self.newRoom.room_type);
      formData.append("roomSize", self.newRoom.room_size);
      formData.append("bedType", self.newRoom.bed_type);
      formData.append("price", self.newRoom.price);
      formData.append("billsIncluded", self.newRoom.bills_included);
      formData.append("deposit", self.newRoom.deposit);
      formData.append("depositAmmount", self.newRoom.deposit_ammount);
      formData.append("availabilityFrom", self.newRoom.availability_from);
      formData.append("availabilityUntil", self.newRoom.availability_until);
      formData.append("minStay", self.newRoom.min_stay);
      formData.append("maxStay", self.newRoom.max_stay);
      formData.append("image_1", self.image_1);
      // formData.append("image_2", self.image_2);
      // formData.append("image_3", self.image_3);
      // formData.append("image_4", self.image_4);
      // formData.append("image_5", self.image_5);
      axios
        .put("http://localhost:3001/user/" + self.id + "/room", formData, {
          "Content-Type": "multipart/form-data",
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "¡Tu habitación ha sido actualizada con éxito!"
          });
          self.modal = false;
          self.viewRoom();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
          if (error.response.status === 401) {
            self.$router.push("/login");
          }
        });
    },
    getRoomFacilities() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/room/facilities", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.facilities = response.data.facilities;
          self.selectedFacilities = self.facilities.filter(
            facility => facility.status === 1
          );
          for (const facilityName of self.selectedFacilities) {
            self.selectedFacilitiesNames.push(facilityName.name);
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
    selectFacility(index) {
      if (this.selectedFacilitiesNames.includes(this.facilities[index].name)) {
        this.facilities[index].status = 0;
        this.selectedFacilities = this.selectedFacilities.filter(
          facility => facility.name !== this.facilities[index].name
        );
        this.selectedFacilitiesNames.splice(
          this.selectedFacilitiesNames.indexOf(this.facilities[index].name),
          1
        );
      } else {
        this.selectedFacilities.push({
          name: this.facilities[index].name,
          status: 1
        });
        this.facilities[index].status = 1;
        this.selectedFacilitiesNames.push(this.facilities[index].name);
      }
    },
    editRoomFacilities() {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/room/facilities",
          {
            facility1: self.facilities[0].name,
            status1: self.facilities[0].status,
            facility2: self.facilities[1].name,
            status2: self.facilities[1].status,
            facility3: self.facilities[2].name,
            status3: self.facilities[2].status,
            facility4: self.facilities[3].name,
            status4: self.facilities[3].status,
            facility5: self.facilities[4].name,
            status5: self.facilities[4].status,
            facility6: self.facilities[5].name,
            status6: self.facilities[5].status,
            facility7: self.facilities[6].name,
            status7: self.facilities[6].status,
            facility8: self.facilities[7].name,
            status8: self.facilities[7].status,
            facility9: self.facilities[8].name,
            status9: self.facilities[8].status,
            facility10: self.facilities[9].name,
            status10: self.facilities[9].status,
            facility11: self.facilities[10].name,
            status11: self.facilities[10].status,
            facility12: self.facilities[11].name,
            status12: self.facilities[11].status,
            facility13: self.facilities[12].name,
            status13: self.facilities[12].status,
            facility14: self.facilities[13].name,
            status14: self.facilities[13].status,
            facility15: self.facilities[14].name,
            status15: self.facilities[14].status,
            facility16: self.facilities[15].name,
            status16: self.facilities[15].status,
            facility17: self.facilities[16].name,
            status17: self.facilities[16].status,
            facility18: self.facilities[17].name,
            status18: self.facilities[17].status
          },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Prestaciones del piso actualizadas correctamente",
            text: "Completa tu perfil al máximo :)",
            timer: 1500
          });
          self.getRoomFacilities();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    openModal() {
      this.modal = true;
    },
    closeModal() {
      this.modal = false;
    },
    handleImage() {
      this.image_1 = this.$refs.image_1.files[0];
      this.image_2 = this.$refs.image_2.files[0];
      this.image_3 = this.$refs.image_3.files[0];
      this.image_4 = this.$refs.image_4.files[0];
      this.image_5 = this.$refs.image_5.files[0];
    }
  },
  created() {
    this.viewRoom();
    this.getRoomFacilities();
  }
};
</script>

<style>
.modalBox::-webkit-scrollbar {
  width: 0.2em;
}

.modalBox::-webkit-scrollbar-thumb {
  background-color: lightcoral;
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
  background-color: white;
  text-align: center;
}

input[type="number"] {
  width: 40px;
  margin: 1rem;
  text-align: center;
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

fieldset img {
  margin: 1rem auto;
}

ul {
  display: flex;
  list-style: none;
  flex-wrap: wrap;
  justify-content: center;
}
ul li {
  margin: 0.5rem;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  width: 100%;
}

.modalBox {
  overflow-y: auto;
  background: #fefefe;
  margin: 2rem auto;
  padding: 20px;
  border: 1px solid #888;
  width: 60%;
  height: 500px;
}

.facilityContainer {
  list-style: none;
  display: flex;
  justify-content: center;
  flex-direction: row;
  flex-wrap: wrap;
  margin: 0.5rem;
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

#prestaciones {
  width: 70%;
  margin: 3rem auto;
}

label input[type="file"] {
  display: none;
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
  display: flex;
  justify-content: center;
}

#updateRoom {
  margin-bottom: 2rem;
}

#description {
  width: 60%;
  margin: 0 auto;
}

#roomImage {
  width: 500px;
  margin-bottom: 2rem;
}

#flor {
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: -2;
  width: 400px;
}

#fento {
  position: fixed;
  right: -12rem;
  top: 0;
  z-index: -2;
  width: 400px;
  transform: rotate(-180deg);
}
</style>
