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
        <!-- {{user.room[0].title}} -->
        {{user.room[0].price}}
        {{user.room[0].address}}
        {{user.room[0].city}}
        <button
          @click="roomEvent(user)"
          class="profileButton"
          id="roomButton"
        >Ver habitación</button>
      </div>

      <!-- <button>Siguiente</button> -->
      <button @click="likeEvent(user)" class="likeButton">Me gusta</button>
    </div>
    <div class="modal" v-if="userModal">
      <div class="modalBox">
        <h2>Usuario</h2>
        <h2>{{ userInfo.profile.name }}</h2>
        <br />
        <img :src="userInfo.profile.image_1" />
        <img :src="userInfo.profile.image_2" />
        <img :src="userInfo.profile.image_3" />
        <img :src="userInfo.profile.image_4" />
        <img :src="userInfo.profile.image_5" />
        <br />
        <p>Ciudad:</p>
        <h2>{{ userInfo.profile.city }}</h2>
        <br />
        <p>Género:</p>
        <h2>{{ userInfo.profile.gender }}</h2>
        <br />
        <p>Campo profesional:</p>
        <h2>{{ userInfo.profile.occupation_field }}</h2>
        <br />
        <p>Estado laboral:</p>
        <h2>{{ userInfo.profile.occupation_status }}</h2>
        <br />
        <p>Pareja:</p>
        <h2>{{ userInfo.profile.couple }}</h2>
        <br />
        <p>Perfil de instagram</p>
        <h2>{{ userInfo.profile.ig_profile }}</h2>
        <br />
        <p>Tipo de usuario:</p>
        <h2>{{ userInfo.profile.type }}</h2>
        <h2>Personalidad:</h2>
        <ul class="list">
          <li v-for="personalidad in userInfo.personality" :key="personalidad.id_personality">
            <p>{{ personalidad.name }}</p>
          </li>
        </ul>
        <h2>Hobbies:</h2>
        <ul class="list">
          <li v-for="hobby in userInfo.hobbies" :key="hobby.id_hobby">
            <p>{{ hobby.name }}</p>
          </li>
        </ul>
        <h2>Reglas:</h2>
        <ul class="list">
          <li v-for="rule in userInfo.rules" :key="rule.id_rule">
            <p>{{ rule.name }}</p>
          </li>
        </ul>
        <button @click="closeEvent">Cerrar</button>
      </div>
    </div>
    <div class="modal" v-if="roomModal">
      <div class="modalBox">
        <h2>Habitación</h2>
        <img :src="roomInfo.room.image_1" />
        <!-- <h3>{{roomInfo.room.title}}</h3> -->
        <p>{{roomInfo.room.description}}</p>

        <button @click="closeEvent">Cerrar</button>
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
  width: 500px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
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

p {
  font-size: 0.8rem;
  margin: 0;
}

h3 {
  margin: 0;
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

.modalBox img {
  width: 100%;
  margin: 0;
  padding: 0;
}

img {
  width: 300px;
}

.profileButton {
  border: 1px solid lightcoral;
  background-color: white;
  padding: 0.3rem 0.8rem;
  font-family: Raleway;
  font-weight: 500;
}

.profileButton:hover {
  border: 1px solid lightcoral;
  background-color: lightcoral;
  color: white;
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
</style>