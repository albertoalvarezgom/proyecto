<template>
  <div id="app">
    <router-view />
    <!-- <footercustom></footercustom> -->
  </div>
</template>

<script>
// import footercustom from "@/components/FooterCustom.vue";
export default {
  name: "App"
  // components: { footercustom }
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
body {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  height: 100%;
}

#app {
  font-family: Raleway;
  font-weight: 500;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: flex;
  flex-direction: column;
  height: 100vh;
}

body::-webkit-scrollbar {
  width: 0.2em;
}

body::-webkit-scrollbar-thumb {
  background-color: lightcoral;
}

#nav {
  padding: 0;
  margin: 0;
}

#nav a.router-link-exact-active {
  color: lightcoral;
}

a {
  color: #2c3e50;
}

ul {
  list-style: none;

  padding: 0;
}
h1 {
  text-decoration: none;
  font-family: "Dm Serif Display";
  font-size: 3rem;
}
a {
  text-decoration: none;
}
h1 {
  color: #2c3e50;
  margin-bottom: 0;
}
fieldset {
  border: none;
}

.activado {
  background-color: lightcoral;
  border: 1px solid lightcoral;
  padding: 0.4rem 1.2rem;
  color: white;
  border-radius: 14px;
  font-weight: 700;
}

.desactivado {
  background-color: white;
  border: 1px solid lightcoral;
  font-family: "Raleway";
  color: #2c3e50;
  padding: 0.4rem 1.2rem;
  border-radius: 14px;
  font-weight: 700;
}

.profileButton {
  border: 1px solid lightcoral;
  background-color: white;
  padding: 0.3rem 0.8rem;
  font-family: Raleway;
  font-weight: 500;
  margin: 1rem 0.5rem;
  border-radius: 16px;
  font-weight: 700;
  color: #2c3e50;
}

.profileButton:hover {
  border: 1px solid lightcoral;
  background-color: lightcoral;
  color: white;
}
</style>
