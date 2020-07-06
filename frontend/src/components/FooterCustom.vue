<template>
  <div class="footerBlock">
    <h1>roomie.</h1>
    <div>
      <h2>Proyecto realizado por Alberto Álvarez</h2>
      <p>albertoalvarezgom@gmail.com</p>
      <p>675147983</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "FooterCustom",
  data() {
    return {};
  }
};
</script>

<style>
.footerBlock {
  background-color: lightcoral;
  padding: 1rem 0;
  margin: 0 auto;
  margin-top: 2rem;
  display: flex;
  justify-content: center;
  align-items: center;
  /* position: absolute;
  bottom: 0; */
  width: 100%;
  /* flex-shrink: 0; */
  position: -webkit-sticky;
  position: sticky;
  top: -1px;
}
.footerBlock h1 {
  color: white;
  margin-right: 5rem;
}

.footerBlock h2 {
  color: white;
  margin-bottom: 0;
}

.footerBlock p {
  color: white;
  font-size: 0.8rem;
}
</style>