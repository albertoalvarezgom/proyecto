// AUTENTICACIÓN

// IMPORTS - Importamos módulos
import axios from "axios";
import jwt from "jwt-decode";

// CONST -  API y Token
const ENDPOINT = "http://localhost:3001";
const AUTH_TOKEN_KEY = "authorization";
let ROLE = "role";
let USER = "user";

// FUNCION PARA LOGIN
export function loginUser(email, password) {
  return new Promise(async (resolve, reject) => {
    try {
      //Mandamos la info de usuario con axios a la ruta de autenticación
      let res = await axios({
        url: `${ENDPOINT}/user/login`,
        method: "POST",
        data: {
          email: email,
          password: password,
        },
      });
      //Guardamos el token de usuario
      setAuthToken(res.data.data);
      localStorage.setItem("id", res.data.user.id);
      localStorage.setItem("role", res.data.user.role);
      localStorage.setItem("city", res.data.user.city);
      localStorage.setItem("name", res.data.user.name);
      localStorage.setItem("type", res.data.user.type);
      resolve();
    } catch (error) {
      console.error("Error en login -> ", error);
      reject(error);
    }
  });
}

// FUNCIÓN PARA GUARDAR TOKEN EN LOCALSTORAGE
export function setAuthToken(token) {
  //Creamos el token
  axios.defaults.headers.common["authorization"] = `Bearer ${token}`;
  //Lo enviamos a localStorage
  localStorage.setItem(AUTH_TOKEN_KEY, token);
}

// FUNCIÓN PARA LOGOUT
export function clearLogin() {
  //Declaramos el header de token vacío...
  axios.defaults.headers.common["authorization"] = "";
  //...y borramos los datos de usuario del localStorage
  localStorage.removeItem(AUTH_TOKEN_KEY);
  localStorage.removeItem("id");
  localStorage.removeItem("role");
  localStorage.removeItem("city");
  localStorage.removeItem("name");
  //Con esta función borramos el rol de usuario del localStorage
  clearAdmin();
}

// FUNCIÓN PARA COGER EL TOKEN
export function getAuthToken() {
  return localStorage.getItem(AUTH_TOKEN_KEY);
}

// FUNCIÓN PARA CONSEGUIR LA FECHA DE EXPIRACIÓN DEL TOKEN
export function getTokenExpirationDate(encodedToken) {
  let token = jwt(encodedToken);
  //Si no hay token, mandamos null
  if (!token.exp) {
    return null;
  } else {
    //Si hay token, sacamos la fecha en segundos
    let date = new Date(0);
    date.setUTCSeconds(token.exp);
    //Mandamos la fecha
    return date;
  }
}

// FUNCIÓN PARA COMPROBAR SI EL TOKEN ES VIGENTE O EXPIRÓ
export function isTokenExpired(token) {
  //Cogemos la fecha del token con la función anterior
  let expirationDate = getTokenExpirationDate(token);
  //Y la mandamos si es menor a la actual
  return expirationDate < new Date();
}

// FUNCIÓN PARA COMPROBAR SI EL USUARIO ESTÁ LOGUEADO
export function isLoggedIn() {
  //Cogemos el token del usuario
  let authToken = getAuthToken();
  //Enviamos en caso de que haya token y no esté expirado
  return !!authToken && !isTokenExpired(authToken);
}

//// FUNCIONES PARA COMPROBAR DATOS DE USUARIO

// FUNCIÓN PARA GUARDAR EN LOCALSTORAGE SI EL USUARIO ES ADMIN
export function setIsAdmin(isAdmin) {
  localStorage.setItem(ROLE, isAdmin);
}

// FUNCIÓN PARA BORRAR EL ROL DEL USUARIO DEL LOCALSTORAGE
export function clearAdmin() {
  return localStorage.removeItem(ROLE);
}

// FUNCIÓN PARA RECUPERAR EL ROL DEL USUARIO DESDE EL LOCALSTORAGE
export function getIsAdmin() {
  return localStorage.getItem(ROLE);
}

// FUNCIÓN PARA RECUPERAR EL NOMBRE DE USUARIO DESDE EL LOCALSTORAGE
export function getUserName() {
  return localStorage.getItem("name");
}

// FUNCIÓN PARA RECUPERAR EL TIPO DE USUARIO DESDE EL LOCALSTORAGE
export function getUserType() {
  return localStorage.getItem("type");
}

// FUNCIÓN PARA COMPROBAR EL ROL DEL USUSARIO
export function checkAdmin() {
  let role = false;
  //Comprobamos si es admin
  let isAdmin = getIsAdmin();
  //Si lo es mandamos true....
  if (isAdmin === "true") {
    role = true;
  } else {
    //si no, mandamos false
    role = false;
  }
  // console.log(role);
  return role;
}
