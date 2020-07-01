import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import { isLoggedIn, checkAdmin } from "../api/utils";
import Swal from "sweetalert2";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    meta: {
      allowAnonymous: true,
    },
  },
  {
    path: "/about",
    name: "About",
    component: () => import("../views/About.vue"),
    meta: {
      allowAnonymous: true,
    },
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("../views/Login.vue"),
    meta: {
      allowAnonymous: true,
    },
  },
  {
    path: "/registro",
    name: "Register",
    component: () => import("../views/Register.vue"),
    meta: {
      allowAnonymous: true,
    },
  },
  {
    path: "/publicar",
    name: "NewRoom",
    component: () => import("../views/NewRoom.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/reservas",
    name: "Reservas",
    component: () => import("../views/Reservas.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/mensajes",
    name: "Mensajes",
    component: () => import("../views/Mensajes.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/datos-personales",
    name: "UserProfile",
    component: () => import("../views/UserProfile.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/hobbies",
    name: "UserHobby",
    component: () => import("../views/UserHobby.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/personalidad",
    name: "UserPersonality",
    component: () => import("../views/UserPersonality.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/valoraciones",
    name: "UserVotes",
    component: () => import("../views/UserVotes.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
  {
    path: "/room",
    name: "Room",
    component: () => import("../views/Room.vue"),
    meta: {
      allowAnonymous: false,
    },
  },
];

const router = new VueRouter({
  routes,
});

// COMPROBAMOS LAS URLS Y ANALIZAMOS EL USUARIO
router.beforeEach((to, from, next) => {
  //Si la ruta no es pública y el usuario no está logueado...
  if (!to.meta.allowAnonymous && !isLoggedIn()) {
    next({
      //Lo redirigimos a la página de login
      path: "/login",
      query: { redirect: to.fullPath },
    });
    Swal.fire({
      position: "center",
      icon: "warning",
      title: "Lo sentimos. Esta ruta es sólo para usuarios resgistrados",
      showConfirmButton: true,
    });
  } else {
    next();
  }
});

export default router;
