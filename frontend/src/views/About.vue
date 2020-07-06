<template>
  <div>
    <menucustom></menucustom>
    <vue-headful title="About" description="Página sobre la web" />
    <img src="../assets/cactus.png" alt="Imagen de introducción" id="cactus" />
    <div id="container">
      <div>
        <img src="../assets/berto.jpg" alt="Imagen de about" id="berto" />
      </div>
      <div id="name">
        <h1 class="type">Alberto</h1>
        <h1>Álvarez</h1>
        <h1>Gómez</h1>
        <br />
        <br />
        <a href="https://github.com/albertoalvarezgom" target="_blank">Github</a>
        <a
          href="https://www.linkedin.com/in/alberto-%C3%A1lvarez-g%C3%B3mez-a48aba1a7/"
          target="_blank"
        >Linkedin</a>
      </div>
    </div>
    <footercustom></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
export default {
  name: "About",
  components: { menucustom, footercustom }
};
</script>

<style scoped>
#container {
  display: flex;
  justify-content: center;
  margin-top: 4rem;
  height: 100vh;
}

#berto {
  width: 500px;
  margin-right: 3rem;
}

#name {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

a:hover {
  color: lightcoral;
}

#cactus {
  position: fixed;
  bottom: -20rem;
  width: 100%;
  right: 0;
  z-index: -2;
}
</style>