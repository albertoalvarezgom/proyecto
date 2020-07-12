<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="Mis reservas" description="Mis reservas" />
    <img src="../assets/planta5.jpg" alt="Imagen de reserva" id="planta5" />
    <h2>Tus reservas</h2>
    <div class="body">
      <p v-if="bookings.length===0">Todavía no tienes ninguna reserva</p>
      <ul class="bookingContainer" v-if="bookings.length">
        <li
          v-for="(booking, index) in bookings"
          :key="booking.booking.confirmation_code"
          class="bookings"
        >
          <div>
            <h2>{{ booking.booking.title }}</h2>
            <h5>Código de reserva: {{booking.booking.confirmation_code}}</h5>
            <br />
            <p id="bookingStatus">Estado: {{ booking.booking.status }}</p>
            <p
              v-show="booking.booking.status === 'aceptada'"
            >La reserva empieza: {{ booking.booking.start_date }}</p>
            <p
              v-show="booking.booking.finish_date"
              v-if="booking.booking.status==='aceptada'"
            >La reserva termina: {{ booking.booking.finish_date }}</p>
            <!-- <img :src="booking.booking.image_1" /> -->
            <div id="bookingUsers">
              <div>
                <h2 class="userName">{{ booking.booking.name1 }}</h2>
                <img :src="booking.booking.user_image_1" class />
                <p v-show="booking.booking.status === 'aceptada'">{{ booking.booking.email }}</p>
                <p v-show="booking.booking.status === 'aceptada'">{{ booking.booking.phone }}</p>
              </div>
              <div>
                <h2 class="userName">{{ booking.otherUser[0].first_name }}</h2>
                <img :src="booking.otherUser[0].image_1" />
                <p v-show="booking.booking.status === 'aceptada'">{{ booking.otherUser[0].email }}</p>
                <p v-show="booking.booking.status === 'aceptada'">{{ booking.otherUser[0].phone }}</p>
              </div>
            </div>
            <button
              class="profileButton"
              id="profileUser"
              @click="getUserInfo(booking.otherUser[0].id_user)"
            >Ver perfil de {{booking.otherUser[0].first_name}}</button>
            <button
              class="profileButton"
              v-if="booking.booking.status!== 'cancelada'"
              @click="getRoomInfo(booking.otherUser[0].id_user)"
            >Ver habitación</button>
            <br />
            <button
              @click="acceptBooking(index, booking.booking.id_match)"
              v-show="
              id !== booking.booking.id_user_sending &&
                booking.booking.status === 'enviada'
            "
              class="bookingButton"
            >Aceptar reserva</button>
            <button
              @click="cancelBooking(index, booking.booking.id_match)"
              v-show="booking.booking.status === 'enviada'"
              class="bookingButton"
            >Cancelar reserva</button>
            <button
              @click="finishBooking(index, booking.booking.id_match)"
              v-show="booking.booking.status === 'aceptada'"
              class="bookingButton"
            >Finalizar reserva</button>
            <button
              @click="openModal(index)"
              v-show="
              booking.booking.status === 'terminada' &&
                booking.booking.voted === 0
            "
              class="bookingButton"
            >Votar usuario</button>
            <p v-show="booking.booking.voted === 1">¡Ya has votado a este usuario!</p>
          </div>
          <div class="voteModal" v-show="modal">
            <div class="voteModalBox">
              <fieldset>
                <label for="rating">Vota a tu roomie</label>
                <br />
                <select name="ratgin" id="rating" v-model="rating">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                </select>
              </fieldset>
              <fieldset>
                <label for="comment">Añade un comentario</label>
                <textarea name="comment" id="voteComment" cols="30" rows="10" v-model="comment"></textarea>
              </fieldset>
              <button @click="closeModal()" class="profileButton">Cerrar</button>
              <button
                @click="voteUser(rateBooking.id_user1, rateBooking.id_user2)"
                class="profileButton"
              >Enviar</button>
            </div>
          </div>
        </li>
      </ul>
      <div v-if="bookings.length">
        <button class="homeButton">
          <router-link to="/">Volver a la home</router-link>
        </button>
        <footercustom></footercustom>
      </div>
    </div>
    <div class="modal" v-if="userModal">
      <div class="modalBoxUser">
        <div class="userInfo">
          <div class="name">
            <h4 class="type">{{ userInfo.profile.ig_profile }}</h4>
            <br />
            <h1>{{ userInfo.profile.name }}, {{ userInfo.profile.age }}</h1>
            <h2>
              {{ userInfo.profile.rating }}
              <p>/ 5</p>
            </h2>
          </div>
          <p class="type">{{ userInfo.profile.type }}</p>
          <br />
          <img :src="userInfo.profile.image1" />
          <br />
          <div class="flex">
            <div>
              <p>Campo profesional:</p>
              <h2>{{ userInfo.profile.occupation_field }}</h2>
            </div>
            <div>
              <p>Estado laboral:</p>
              <h2>{{ userInfo.profile.occupation_status }}</h2>
            </div>
            <div>
              <p>Pareja:</p>
              <h2>{{ userInfo.profile.couple }}</h2>
            </div>
          </div>
          <br />
          <h2 class="type">Personalidad</h2>
          <ul class="flex">
            <li v-for="personalidad in userInfo.personality" :key="personalidad.id_personality">
              <p>{{ personalidad.name }}</p>
            </li>
          </ul>
          <h2 class="type">Hobbies</h2>
          <ul>
            <li v-for="hobby in userInfo.hobbies" :key="hobby.id_hobby">
              <h3 id="hobbyName">{{ hobby.name }}</h3>
              <p id="hobbyDescription">{{ hobby.description }}</p>
            </li>
          </ul>
          <h2 class="type">Reglas</h2>
          <ul class="flex">
            <li v-for="rule in userInfo.rules" :key="rule.id_rule">
              <p>{{ rule.name }}</p>
            </li>
          </ul>
          <button @click="closeModal()" class="profileButton">Cerrar</button>
        </div>
      </div>
    </div>
    <div class="modal" v-if="roomModal">
      <div class="modalBoxUser">
        <div class="name">
          <h2>{{roomInfo.room.title}}</h2>
          <h2 class="type">{{roomInfo.room.price}} €</h2>
        </div>
        <img :src="roomInfo.room.image_1" />
        <p>{{roomInfo.room.description}}</p>
        <br />
        <h2 class="type">Dirección</h2>
        <p>{{roomInfo.room.address}}</p>
        <p>{{roomInfo.room.postal_code}}</p>
        <p>{{roomInfo.room.city}}</p>
        <br />
        <h2 class="type">El piso</h2>
        <p>El piso mide {{roomInfo.room.flat_size}} m2</p>
        <p
          v-if="roomInfo.room.flatmates_masc && roomInfo.room.flatmates_fem"
        >Comparto piso con {{roomInfo.room.flatmates_masc}} chicos y {{roomInfo.room.flatmates_fem}} chicas</p>
        <p
          v-if="roomInfo.room.flatmates_masc && !roomInfo.room.flatmates_fem"
        >Comparto piso con {{roomInfo.room.flatmates_masc}} chicos</p>
        <p
          v-if="roomInfo.room.flatmates_fem && !roomInfo.room.flatmates_masc"
        >Comparto piso con {{roomInfo.room.flatmates_fem}} chicas</p>
        <br />
        <h2 class="type">Busco...</h2>
        <p
          v-if="roomInfo.room.preference_gender!=='indiferente'"
        >Preferiblemente que sea {{roomInfo.room.preference_gender}},</p>
        <p
          v-if="roomInfo.room.status ==='trabajando' || roomInfo.room.status==='estudiando'"
        >que esté {{roomInfo.room.status}}</p>
        <p
          v-if="roomInfo.room.min_age && roomInfo.room.max_age"
        >y que tenga entre {{roomInfo.room.min_age}} y {{roomInfo.room.max_age}} años</p>
        <p v-if="!roomInfo.room.min_age">y que tenga menos de {{roomInfo.room.max_age}} años</p>
        <p v-if="!roomInfo.room.max_age">y que tenga más de {{roomInfo.room.min_age}} años</p>
        <br />
        <h2 class="type">La habitación</h2>
        <p>La habitación es {{roomInfo.room.room_type}} y tiene {{roomInfo.room.room_size}} m2</p>
        <p>La cama es {{roomInfo.room.bed_type}}</p>
        <p v-if="roomInfo.room.bills_included">Las facturas están incluidas en el precio</p>
        <p v-if="roomInfo.room.deposit">Se pide un depósito de {{roomInfo.room.deposit_ammount}}€</p>
        <p>La habitación está disponible desde el {{roomInfo.room.availability_from}} hasta el {{roomInfo.room.availability_until}}</p>
        <br />
        <p>La estancia mínima es de {{roomInfo.room.min_stay}} meses y la máxima de {{roomInfo.room.max_stay}} meses</p>
        <br />
        <p>Habitación vista {{roomInfo.room.views}} veces</p>
        <button @click="closeModal()" class="profileButton">Cerrar</button>
      </div>
    </div>
    <div v-if="!bookings.length">
      <button class="homeButton">
        <router-link to="/">Volver a la home</router-link>
      </button>
      <footercustom></footercustom>
    </div>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Reservas",
  components: { menucustom, footercustom },
  data() {
    return {
      id: Number(localStorage.getItem("id")),
      bookings: [],
      rating: null,
      comment: "",
      modal: false,
      rateBooking: {},
      userInfo: {},
      roomInfo: {},
      userModal: false,
      roomModal: false
    };
  },
  methods: {
    getBookings() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/booking", {
          headers: {
            authorization: localStorage.getItem("authorization")
          }
        })
        .then(function(response) {
          self.bookings = response.data.bookings;
          if (!response.data.bookings) {
            self.empty = true;
          } else {
            self.bookings = response.data.bookings.map(booking => {
              booking.booking.user_image_1 =
                "http://localhost:3001/uploads/" + booking.booking.user_image_1;
              booking.otherUser[0].image_1 =
                "http://localhost:3001/uploads/" + booking.otherUser[0].image_1;
              booking.booking.image_1 =
                "http://localhost:3001/uploads/" + booking.booking.image_1;
              return booking;
            });
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
    acceptBooking(index, idmatch) {
      let self = this;
      axios
        .get("http://localhost:3001/matches/" + idmatch + "/booking/accept", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: { code: self.bookings[index].booking.confirmation_code }
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "¡Reserva aceptada con éxito!",
            text:
              "Te hemos enviado por mail la confirmación. ¡Disfruta de tu roomie!"
          });
          self.getBookings();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    cancelBooking(index, idmatch) {
      let self = this;
      axios
        .get("http://localhost:3001/matches/" + idmatch + "/booking/cancel", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: { code: self.bookings[index].booking.confirmation_code }
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "La reserva ha sido cancelada",
            text: "¡Buena suerte buscando a tu roomie!"
          });
          self.getBookings();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    finishBooking(index, idmatch) {
      let self = this;
      axios
        .get("http://localhost:3001/matches/" + idmatch + "/booking/finish", {
          headers: { authorization: localStorage.getItem("authorization") },
          params: { code: self.bookings[index].booking.confirmation_code }
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "La reserva ha sido finalizada",
            text: "¿A qué esperas para buscar tu próximo roomie?"
          });
          self.getBookings();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    checkUserToVote(id1, id2) {
      if (this.id === id1) {
        return id2;
      } else {
        return id1;
      }
    },
    voteUser(index1, index2) {
      let self = this;
      axios
        .post(
          "http://localhost:3001/user/" +
            self.checkUserToVote(index1, index2) +
            "/vote",
          { rating: self.rating, comment: self.comment },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "¡Gracias!",
            text: "Tu voto ha sido enviado :)"
          });

          self.closeModal();
          self.$router.go();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    getUserInfo(id) {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + id, {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.userInfo = response.data.data;
          self.userInfo.profile.image1 =
            "http://localhost:3001/uploads/" + self.userInfo.profile.image1;
          self.openUserModal();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    getRoomInfo(id) {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + id + "/room", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.roomInfo = response.data.data;
          console.log(self.roomInfo);

          const roomImage_1 = response.data.data.room.image_1;

          if (self.roomInfo.room.image_1) {
            self.roomInfo.room.image_1 =
              "http://localhost:3001/uploads/" + self.roomInfo.room.image_1;
          } else {
            self.roomInfo.room.image_1 =
              "http://localhost:3001/uploads/roomie-profile.jpg";
          }

          self.openRoomModal();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    openUserModal() {
      this.userModal = true;
    },
    openRoomModal() {
      this.roomModal = true;
    },
    openModal(index) {
      this.rateBooking = this.bookings[index].booking;
      this.modal = true;
    },
    closeModal() {
      this.modal = false;
      this.userModal = false;
      this.roomModal = false;
    }
  },
  created() {
    this.bookings = [];
    this.getBookings();
  }
};
</script>

<style>
ul {
  list-style: none;
}
.voteModal {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.2);
  width: 100%;
}

.voteModalBox {
  background: #fefefe;
  margin: 8rem auto;
  padding: 20px;
  padding-bottom: 3rem;
  border: 1px solid #888;
  width: 30%;
  height: 350px;
}

select {
  margin: 0 auto;
  border: 1px solid lightcoral;
  font-family: raleway;
  margin-bottom: 1rem;
}

h5 {
  margin: 0;
}

#bookingUsers {
  display: flex;
  justify-content: center;
  margin-bottom: 1rem;
}

#bookingUsers div img {
  width: 240px;
}

#bookingUsers div {
  margin: 0.5rem;
}

.bookings {
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  width: 600px;
  padding: 1rem 2rem;
  margin: 2rem auto;
  background-color: white;
}

.userName {
  margin-bottom: 0.5rem;
}

.bookingButton {
  font-family: "Dm Serif Display";
  border: none;
  background-color: white;
  border-bottom: 2px solid lightcoral;
  font-size: 1.5rem;
  color: #2c3e50;
  margin: 1rem;
}

.bookingButton:hover {
  color: lightcoral;
}

.homeButton {
  border: none;
  margin-bottom: 3rem;
  background-color: white;
  font-size: 0.8rem;
  color: #2c3e50;
}

.homeButton a:hover {
  color: lightcoral;
}

#planta5 {
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: -2;
  width: 300px;
}

#voteComment {
  width: 200px;
  height: 100px;
  border: 1px solid lightcoral;
  background-color: white;
}

.bookingContainer {
  display: flex;
  flex-direction: column;
}

#bookingStatus {
  color: lightcoral;
}

.body {
  height: 100vh;
}
</style>
