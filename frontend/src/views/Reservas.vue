<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="Mis reservas" description="Mis reservas" />
    <h2>Tus reservas</h2>
    <div>
      <p v-if="bookings.length===0">Todavía no tienes ninguna reserva</p>
      <ul>
        <li v-for="(booking, index) in bookings" :key="booking.booking.confirmation_code">
          <div class="bookings">
            <h2>{{ booking.booking.title }}</h2>
            <h4>Código de reserva: {{booking.booking.confirmation_code}}</h4>
            <h5>Estado: {{ booking.booking.status }}</h5>
            <p
              v-show="booking.booking.start_date"
            >La reserva empieza: {{ booking.booking.start_date }}</p>
            <p
              v-show="booking.booking.finish_date"
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

          <div class="modal" v-show="modal">
            <div class="modalBox">
              <fieldset>
                <label for="rating">Vota a tu roomie</label>
                <input type="number" name="rating" min="1" max="5" v-model="rating" />
              </fieldset>
              <fieldset>
                <label for="comment">Añade un comentario</label>
                <textarea name="comment" id cols="30" rows="10" v-model="comment"></textarea>
              </fieldset>
              <button @click="closeModal()">Cerrar</button>
              <button @click="voteUser(rateBooking.id_user1, rateBooking.id_user1)">Enviar</button>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <button>
      <router-link to="/">Volver a la home</router-link>
    </button>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "Reservas",
  components: { menucustom },
  data() {
    return {
      id: Number(localStorage.getItem("id")),
      bookings: [],
      rating: null,
      comment: "",
      modal: false,
      rateBooking: {}
    };
  },
  methods: {
    getBookings() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/booking", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.bookings = response.data.bookings.map(booking => {
            booking.booking.user_image_1 =
              "http://localhost:3001/uploads/" + booking.booking.user_image_1;

            booking.otherUser[0].image_1 =
              "http://localhost:3001/uploads/" + booking.otherUser[0].image_1;

            booking.booking.image_1 =
              "http://localhost:3001/uploads/" + booking.booking.image_1;

            return booking;
          });
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
          // console.log(index1, index2);
          self.closeModal();
          self.$router.go();
        })
        .catch(function(error) {
          // console.log(index1, index2);
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    openModal(index) {
      this.rateBooking = this.bookings[index].booking;
      this.modal = true;
    },
    closeModal() {
      this.modal = false;
    }
  },
  created() {
    this.getBookings();
  }
};
</script>

<style>
ul {
  list-style: none;
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

h5 {
  margin: 0;
}

#bookingUsers {
  display: flex;
  justify-content: center;
  margin-bottom: 1rem;
}

#bookingUsers img {
  width: 300px;
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
  font-family: Raleway;
  border: none;
  background-color: white;
  font-size: 1.2rem;
  font-weight: 500;
  color: #2c3e50;
  border: 1px solid #2c3e50;
  margin-bottom: 1rem;
  padding: 0.2rem 1rem;
  border-radius: 8px;
}

.bookingButton:hover {
  color: lightcoral;
  border: 1px solid lightcoral;
}
</style>
