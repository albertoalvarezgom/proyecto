<template>
  <div>
    <div class="users" v-for="user in users" :key="user.id_user">
      <div class="container">
        <div class="name">
          <button @click="viewEvent(user)" class="profileButton">Ver perfil</button>
          <h1>{{ user.perfil[0].first_name }}, {{ user.perfil[0].age }}</h1>
          <h2>
            {{ user.perfil[0].rating }}
            <p>/ 5</p>
          </h2>
        </div>
        <div class="image">
          <img :src="user.perfil[0].image_1" alt />
        </div>
        <div class="info">
          <div class="listsInfo">
            <div>
              <h3>Personalidad</h3>
              <ul class="list">
                <li v-for="personalidad in user.personalidad" :key="personalidad.id_personality">
                  <p>{{ personalidad.name }}</p>
                </li>
              </ul>
            </div>
            <div>
              <h3>Hobbies</h3>
              <ul class="list">
                <li v-for="hobby in user.hobbies" :key="hobby.id_hobby">
                  <p>{{ hobby.name }}</p>
                </li>
              </ul>
            </div>
            <div>
              <h3 v-if="user.rules.length>0">Reglas</h3>
              <ul class="list">
                <li v-for="rule in user.rules" :key="rule.id_rule">
                  <p>{{ rule.name }}</p>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="room" v-if="user.room.length">
        <!-- <ul v-for="room in user.room" :key="room.id_room">
          <img :src="room.image_1" />
          <li>{{ room.title }}</li>
          <li>{{ room.price }} €</li>
          <li>{{ room.address }}</li>
          <li>{{ room.city }}</li>
        </ul>-->
        <h2 class="type">{{user.room[0].title}}</h2>

        <button @click="roomEvent(user)" class="profileButton" id="roomButton">Ver habitación</button>
      </div>
      <!-- <button>Siguiente</button> -->
      <div class="heartContainer">
        <button @click="likeEvent(user)" class="heart"></button>
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
          <p id="userType">{{ userInfo.profile.type }}</p>
          <br />
          <img :src="userInfo.profile.image_1" />
          <!-- <img :src="userInfo.profile.image_2" />
        <img :src="userInfo.profile.image_3" />
        <img :src="userInfo.profile.image_4" />
          <img :src="userInfo.profile.image_5" />-->
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
          <button @click="closeEvent" class="profileButton">Cerrar</button>
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
        <h2 class="type">Prestaciones</h2>
        <ul v-for="facility in roomInfo.facility" :key="facility.name">
          <li v-if="facility.status===1">{{facility.name}}</li>
        </ul>

        <br />
        <p>Habitación vista {{roomInfo.room.views}} veces</p>
        <button @click="closeEvent" class="profileButton">Cerrar</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "UserComponent",
  props: {
    users: Array,
    userModal: Boolean,
    roomModal: Boolean,
    userInfo: Object,
    roomInfo: Object
  },
  methods: {
    likeEvent(user) {
      this.$emit("like", user);
    },
    viewEvent(user) {
      this.$emit("view", user);
    },
    closeEvent() {
      this.$emit("close");
    },
    roomEvent(user) {
      this.$emit("room", user);
    }
  }
};
</script>

<style>
p {
  font-size: 1rem;
  margin: 0;
}

h3 {
  margin: 0;
}

img {
  width: 300px;
}

h2 {
  margin: 0;
}

.liked {
  color: lightcoral;
}

.users {
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  width: 800px;
  margin: 3rem auto;
  padding: 1rem;
  padding-bottom: 2rem;
}

.users img {
  width: 400px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  margin-top: 2rem;
}

.container {
  margin: 0 auto;
  display: flex;
  flex-direction: column;
}

.name {
  display: flex;
  justify-content: center;
  align-items: center;
}

.name h1 {
  margin: 0 6rem;
}

.name h2 {
  margin: 0 2rem;
}

.flex {
  display: flex;
  justify-content: space-around;
}

.list {
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
}

.list li {
  margin: 0;
  padding: 0;
}

.listsInfo {
  display: flex;
  justify-content: center;
  margin: 2rem 0;
}

.listsInfo div {
  margin: 0 2rem;
}

.info {
  display: flex;
  flex-direction: column;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  width: 100%;
}

.modalBoxUser {
  overflow-y: auto;
  background: #fefefe;
  margin: 0 auto;
  padding-top: 20px;
  border: 1px solid #888;
  width: 70%;
  height: 100%;
}

.modalBoxUser img {
  width: 100%;
  margin: 2rem 0;
  padding: 0;
}

.modalBoxUser p {
  width: 80%;
  margin: 0 auto;
}

.modalBoxUser::-webkit-scrollbar {
  width: 0.2em;
}

.modalBoxUser::-webkit-scrollbar-thumb {
  background-color: lightcoral;
}

#roomButton {
  margin-top: 1rem;
}

.likeButton {
  font-family: "Dm Serif Display";
  border: none;
  background-color: white;
  border-bottom: 2px solid lightcoral;
  font-size: 2rem;
  color: #2c3e50;
}

.likeButton:hover {
  color: lightcoral;
}

.heart {
  background-color: lightcoral;
  height: 20px;
  transform: rotate(-45deg);
  width: 20px;
  border: none;
  border-bottom-left-radius: 4px;
}

.heart:before {
  content: "";
  background-color: lightcoral;
  border-radius: 50%;
  height: 20px;
  position: absolute;
  width: 20px;
  top: -10px;
  left: 0;
}

.heart:after {
  content: "";
  background-color: lightcoral;
  border-radius: 50%;
  height: 20px;
  position: absolute;
  width: 20px;
  top: 0;
  left: 10px;
}

.type {
  color: lightcoral;
}

#hobbyName {
  margin-bottom: 0.5rem;
}
#hobbyDescription {
  width: 60%;
  margin: 0 auto;
  margin-bottom: 1rem;
}

#userType {
  color: lightcoral;
  text-align: center;
}
</style>