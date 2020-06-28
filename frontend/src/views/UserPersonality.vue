<template>
  <div>
    <vue-headful title="Mi personalidad" description="Mi personalidad" />
    <menucustom></menucustom>
    <h3>Personalidad:</h3>
    <ul class="personalityContainer">
      <li v-for="(personality, index) in personalities" :key="personality.id_personality">
        <button
          value="personality.name"
          :class="{ activado: personality.status === 1, desactivado: personality.status === 0 }"
          @click="selectPersonality(index)"
        >{{personality.name}}</button>
      </li>
    </ul>
    <p v-show="warning">Sólo puedes elegir 5 personalidades</p>
    <button @click="editUserPersonalities()">Guardar cambios</button>
    <h3>Reglas de convivencia:</h3>
    <ul class="ruleContainer">
      <li v-for="(rule, index) in rules" :key="rule.id_rule">
        <button
          value="rule.name"
          :class="{ activado: rule.status === 1, desactivado: rule.status === 0 }"
          @click="selectRule(index)"
        >{{rule.name}}</button>
      </li>
    </ul>
    <button @click="editUserRules()">Guardar cambios</button>
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
  name: "UserPersonality",
  components: { menucustom },
  data() {
    return {
      id: localStorage.getItem("id"),
      personalities: [],
      selectedPersonalities: [],
      selectedPersonalitiesNames: [],
      warning: false,
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
          headers: { authorization: localStorage.getItem("authorization") },
          params: { id: self.id }
        })
        .then(function(response) {
          self.personalities = response.data.personalities;
          self.selectedPersonalities = self.personalities.filter(
            personality => personality.status === 1
          );
          console.log(self.personalities);
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
      let self = this;
      axios
        .put("http://localhost:3001/user/" + self.id + "/personality", {
          headers: { authorization: localStorage.getItem("authorization") },
          personality1: self.selectedPersonalities[0].name,
          personality2: self.selectedPersonalities[1].name,
          personality3: self.selectedPersonalities[2].name,
          personality4: self.selectedPersonalities[3].name,
          personality5: self.selectedPersonalities[4].name
        })
        .then(function(response) {
          Swal.fire({
            icon: "success",
            title: "Personalidad actualizada correctamente",
            text: "Completa tu perfil al máximo :)",
            timer: 1500
          });
          self.getPersonality();
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
          headers: { authorization: localStorage.getItem("authorization") },
          params: { id: self.id }
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
        console.log(this.selectedRules);
        console.log(this.selectedRulesNames);
      } else {
        this.rules[index].status = 1;
        this.selectedRules[index].status = 1;
        this.selectedRulesNames.push(this.rules[index].name);
        console.log(this.selectedRules);
        console.log(this.selectedRulesNames);
      }
    },
    editUserRules() {
      let self = this;
      axios
        .put("http://localhost:3001/user/" + self.id + "/rule", {
          headers: { authorization: localStorage.getItem("authorization") },
          rule1: self.selectedRules[0].name,
          status1: self.selectedRules[0].status,
          rule2: self.selectedRules[1].name,
          status2: self.selectedRules[1].status,
          rule3: self.selectedRules[2].name,
          status3: self.selectedRules[2].status,
          rule4: self.selectedRules[3].name,
          status4: self.selectedRules[3].status
        })
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
.activado {
  background-color: lightgreen;
  border: none;
}
.desactivado {
  background-color: lightgrey;
  border: none;
}

.personalityContainer {
  list-style: none;
  display: flex;
  justify-content: center;
  flex-direction: row;
  flex-wrap: wrap;
  margin: 0.5rem;
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
</style>