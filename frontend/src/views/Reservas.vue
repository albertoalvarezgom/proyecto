<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="Mis reservas" description="Mis reservas" />
    <h1>Aquí verás y podrás gestionar tus reservas</h1>
    <div>
      <ul v-for="(booking, index) in bookings" :key="booking.id_booking">
        <li>
          <p>{{booking.booking.title}}</p>
          <img :src="booking.booking.image_1" />
          <p>Reserva creada con fecha: {{booking.booking.creation_date}}</p>
          <p v-show="booking.booking.start_date">La reserva empieza: {{booking.booking.start_date}}</p>
          <p
            v-show="booking.booking.finish_date"
          >La reserva termina: {{booking.booking.finish_date}}</p>
          <div>
            <p>{{booking.booking.name1}}</p>
            <p>{{booking.booking.id_user1}}</p>
            <img :src="booking.booking.user_image1" />
            <p v-show="booking.booking.status==='aceptada'">{{booking.booking.email}}</p>
            <p v-show="booking.booking.status==='aceptada'">{{booking.booking.phone}}</p>
          </div>
          <div>
            <p>{{booking.otherUser[0].first_name}}</p>
            <p>{{booking.booking.id_user2}}</p>
            <img :src="booking.otherUser[0].user_image1" />
            <p v-show="booking.booking.status==='aceptada'">{{booking.otherUser[0].email}}</p>
            <p v-show="booking.booking.status==='aceptada'">{{booking.otherUser[0].phone}}</p>
          </div>
          <p>{{booking.booking.status}}</p>
          <button
            @click="acceptBooking(index, booking.booking.id_match)"
            v-show="id !== booking.booking.id_user_sending && booking.booking.status==='enviada'"
          >Aceptar reserva</button>
          <button
            @click="cancelBooking(index, booking.booking.id_match)"
            v-show="booking.booking.status==='enviada'"
          >Cancelar reserva</button>
          <button
            @click="finishBooking(index, booking.booking.id_match)"
            v-show="booking.booking.status==='aceptada'"
          >Finalizar reserva</button>
          <button
            @click="openModal()"
            v-show="booking.booking.status==='terminada' && booking.booking.voted===0"
          >Votar usuario</button>
          <p v-show="booking.booking.voted===1">¡Ya has votado a este usuario!</p>
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
              <button
                @click="voteUser(booking.otherUser[0].id_user, booking.booking.id_user_sending)"
              >Enviar</button>
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
      otherUsers: [],
      rating: null,
      comment: "",
      modal: false
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
          self.bookings = response.data.bookings;
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
    checkUserToVote(index1, index2) {
      if (self.id === index1) {
        return index2;
      } else {
        return index1;
      }
    },
    voteUser(index1, index2) {
      let self = this;
      axios
        .post(
          "http://localhost:3001/user/" +
            self.checkUserToVote(index1, index2) +
            "/vote",
          {
            headers: { authorization: localStorage.getItem("authorization") },
            rating: self.rating,
            comment: self.comment
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "¡Gracias!",
            text: "Tu voto ha sido enviado :)"
          });
          console.log(index1, index2);
          self.closeModal();
          self.getBookings();
        })
        .catch(function(error) {
          console.log(index1, index2);
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
li {
  border: 1px solid red;
}
</style>