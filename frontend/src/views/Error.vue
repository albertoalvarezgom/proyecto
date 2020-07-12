<template>
  <div class="errorContainer">
    <vue-headful title="Error" description="Página de error" />
    <menucustom></menucustom>
    <img src="../assets/fento2.png" alt="Imagen de error" id="fento2" />
    <div id="errorCode">
      <h1 id="error">404</h1>
      <h2>La ruta seleccionada no existe</h2>
    </div>

    <footercustom></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
export default {
  name: "Error",
  components: {
    menucustom,
    footercustom
  }
};
</script>

<style>
.errorContainer {
  display: flex;
  flex-direction: column;
}

#errorCode {
  height: 100vh;
}

#error {
  color: lightcoral;
  font-size: 13rem;
  margin-bottom: 0;
}

#fento2 {
  position: fixed;
  bottom: -38rem;
  width: 600px;
  right: 0;
  z-index: -2;
  transform: rotate(-90deg);
}
</style>