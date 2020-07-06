<template>
  <div>
    <div id="personality">
      <vue-headful title="Mi personalidad" description="Mi personalidad" />
      <menucustom></menucustom>
      <img src="../assets/planta7.jpg" alt="Imagen de personalidad" id="planta7" />
      <h3>Personalidad:</h3>
      <ul class="personalityContainer">
        <li v-for="(personality, index) in personalities" :key="personality.id_personality">
          <button
            value="personality.name"
            :class="{
              activado: personality.status === 1,
              desactivado: personality.status === 0,
            }"
            @click="selectPersonality(index)"
          >{{ personality.name }}</button>
        </li>
      </ul>
      <p v-show="warning">Sólo puedes elegir 5 personalidades</p>
      <p v-show="warning2">Debes elegir 5 personalidades</p>
      <button @click="editUserPersonalities()" class="updateButton">Guardar cambios</button>
    </div>
    <div id="rules">
      <h3>Reglas de convivencia:</h3>
      <ul class="ruleContainer">
        <li v-for="(rule, index) in rules" :key="rule.id_rule">
          <button
            value="rule.name"
            :class="{
              activado: rule.status === 1,
              desactivado: rule.status === 0,
            }"
            @click="selectRule(index)"
          >{{ rule.name }}</button>
        </li>
      </ul>
      <button @click="editUserRules()" class="updateButton">Guardar cambios</button>
    </div>
    <button class="homeButton">
      <router-link to="/">Volver a la home</router-link>
    </button>
    <footercustom></footercustom>
  </div>
</template>

<script>
import menucustom from "@/components/MenuCustom.vue";
import footercustom from "@/components/FooterCustom.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "UserPersonality",
  components: { menucustom, footercustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      personalities: [],
      selectedPersonalities: [],
      selectedPersonalitiesNames: [],
      warning: false,
      warning2: false,
      rules: [],
      selectedRules: [],
      selectedRulesNames: []
    };
  },
  methods: {
    getPersonality() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/personality", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.personalities = response.data.personalities;
          self.selectedPersonalities = self.personalities.filter(
            personality => personality.status === 1
          );
          for (const personalityName of self.selectedPersonalities) {
            self.selectedPersonalitiesNames.push(personalityName.name);
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    selectPersonality(index) {
      if (this.selectedPersonalities.length <= 5) {
        this.warning = false;
      }
      if (
        this.selectedPersonalitiesNames.includes(this.personalities[index].name)
      ) {
        this.personalities[index].status = 0;
        this.selectedPersonalities = this.selectedPersonalities.filter(
          personality => personality.name !== this.personalities[index].name
        );
        this.selectedPersonalitiesNames.splice(
          this.selectedPersonalitiesNames.indexOf(
            this.personalities[index].name
          ),
          1
        );
      } else {
        if (this.selectedPersonalities.length < 5) {
          this.selectedPersonalities.push({
            description: "",
            name: this.personalities[index].name,
            status: 1
          });
          this.personalities[index].status = 1;
          this.selectedPersonalitiesNames.push(this.personalities[index].name);
        } else {
          this.warning = true;
        }
      }
    },
    editUserPersonalities() {
      if (this.selectedPersonalities.length < 5) {
        this.warning2 = true;
        return;
      }
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/personality",
          {
            personality1: self.selectedPersonalities[0].name,
            personality2: self.selectedPersonalities[1].name,
            personality3: self.selectedPersonalities[2].name,
            personality4: self.selectedPersonalities[3].name,
            personality5: self.selectedPersonalities[4].name
          },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Personalidad actualizada correctamente",
            text: "Completa tu perfil al máximo :)",
            timer: 1500
          });
          self.getPersonality();
          self.warning2 = false;
          self.warning = false;
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    getUserRule() {
      let self = this;
      axios
        .get("http://localhost:3001/user/" + self.id + "/rule", {
          headers: { authorization: localStorage.getItem("authorization") }
        })
        .then(function(response) {
          self.rules = response.data.rules;
          self.selectedRules = self.rules;
          for (const ruleName of self.selectedRules) {
            if (ruleName.status === 1) {
              self.selectedRulesNames.push(ruleName.name);
            }
          }
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    },
    selectRule(index) {
      if (this.selectedRulesNames.includes(this.rules[index].name)) {
        this.rules[index].status = 0;
        this.selectedRules[index].status = 0;
        this.selectedRulesNames.splice(
          this.selectedRulesNames.indexOf(this.rules[index].name),
          1
        );
      } else {
        this.rules[index].status = 1;
        this.selectedRules[index].status = 1;
        this.selectedRulesNames.push(this.rules[index].name);
      }
    },
    editUserRules() {
      let self = this;
      axios
        .put(
          "http://localhost:3001/user/" + self.id + "/rule",
          {
            rule1: self.selectedRules[0].name,
            status1: self.selectedRules[0].status,
            rule2: self.selectedRules[1].name,
            status2: self.selectedRules[1].status,
            rule3: self.selectedRules[2].name,
            status3: self.selectedRules[2].status,
            rule4: self.selectedRules[3].name,
            status4: self.selectedRules[3].status
          },
          {
            headers: { authorization: localStorage.getItem("authorization") }
          }
        )
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Reglas actualizadas correctamente",
            text: "Completa tu perfil al máximo :)"
          });
          self.getUserRule();
        })
        .catch(function(error) {
          Swal.fire({
            icon: "error",
            title: error.response.status,
            text: error.response.data.message
          });
        });
    }
  },
  created() {
    this.getPersonality();
    this.getUserRule();
  }
};
</script>

<style>
/* .activado {
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
} */

.personalityContainer {
  width: 90%;
  list-style: none;
  display: flex;
  justify-content: center;
  flex-direction: row;
  flex-wrap: wrap;
  margin: 1rem auto 0;
}

ul {
  display: flex;
  list-style: none;
  flex-wrap: wrap;
  justify-content: center;
}
ul li {
  margin: 0.5rem;
}

.homeButton {
  border: none;
  margin: 1rem 0;
  background-color: white;
  font-size: 0.8rem;
  color: #2c3e50;
}

.homeButton a:hover {
  color: lightcoral;
}

.updateButton {
  font-family: "Dm Serif Display";
  border: none;
  background-color: white;
  border-bottom: 2px solid lightcoral;
  font-size: 2rem;
  color: #2c3e50;
}

.updateButton:hover {
  color: lightcoral;
}

#personality {
  margin-bottom: 3rem;
}

#planta7 {
  position: fixed;
  left: 0;
  bottom: 0;
  z-index: -2;
  width: 300px;
}
</style>
