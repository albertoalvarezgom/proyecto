<template>
  <div>
    <div class="login">
      <fieldset>
        <input type="email" placeholder="Email" v-model="email" />
        <input type="password" placeholder="Contraseña" v-model="password" />
        <button @click="loginEvent(email, password)">Login</button>
      </fieldset>
      <p>¿Has olvidado tu contraseña?</p>
      <button @click="showEvent">Reestablecer contraseña</button>
      <label for="mail" v-show="restore">Escribe tu email:</label>
      <input type="email" name="mail" v-show="restore" v-model="newEmail" />
      <button v-show="restore" @click="restoreEvent(newEmail)">
        Enviar
      </button>
      <p v-show="newPass">Haz login con tu nueva contraseña</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "LoginCustom",
  data() {
    return { email: "", password: "", newEmail: "" };
  },
  props: {
    newPass: Boolean,
    restore: Boolean,
  },
  methods: {
    loginEvent(email, password) {
      this.$emit("login", email, password);
    },
    restoreEvent(newEmail) {
      this.$emit("restore", newEmail);
    },
    showEvent() {
      this.$emit("show");
    },
  },
};
</script>

<style></style>
