<template>
  <div class="footerBlock">
    <h1>roomie.</h1>
    <div id="me">
      <h2>Proyecto realizado por Alberto Álvarez</h2>
      <p>albertoalvarezgom@gmail.com</p>
      <p>675147983</p>
    </div>
    <nav id="links">
      <a href="https://github.com/albertoalvarezgom" target="_blank">Github</a>
      <a
        href="https://www.linkedin.com/in/alberto-%C3%A1lvarez-g%C3%B3mez-a48aba1a7/"
        target="_blank"
      >Linkedin</a>
    </nav>
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
  justify-content: space-around;
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
  /* margin-right: 5rem; */
}

.footerBlock h2 {
  color: white;
  margin-bottom: 0;
}

.footerBlock p {
  color: white;
  font-size: 0.8rem;
}

#me {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

#links {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  /* margin-left: 4rem; */
}
#links a {
  color: white;
  font-size: 0.8rem;
}
</style>