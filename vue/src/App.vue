<template>
  <div id="app">
    <header>
      <nav>
        <div>
          <!--<router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;-->
        </div>
        <div>
          <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
          <router-link v-bind:to="{name: 'login' }" v-if="$store.state.token == ''">Login</router-link>
          <span v-if="$store.state.token == ''">&nbsp;|&nbsp;</span>
          <router-link v-bind:to="{name: 'register' }" v-if="$store.state.token == ''">Register</router-link>
        </div>
      </nav>
    <h1><router-link v-bind:to="{ name: 'home' }">Philadelphia Brewery Guide</router-link></h1>
    </header>
    <main>
      <router-view />
    </main>
    
  </div>
</template>

<style>
:root{
    --yellow: #e5b435;
    --blue: #06038D;
    --site-background-color: rgba(30,30,30,1);
    --page-header-font: Montserrat, sans-serif;
    --site-header-font: Ubuntu, sans-serif;
    --main-font: Roboto Slab, sans-serif;
    --info-background: rgba(0,0,0,0.5);
}
*{
    padding: 0;
    margin: 0;
}
body {
    background-color: var(--site-background-color);
    font-family: var(--main-font);
}
/********************************************** Header **********************************************/
header {
    background-image: linear-gradient(to top, var(--site-background-color), rgba(0,0,0,0) 30%), url("assets/banner-cropped.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  height: 400px;
  position: relative;
}
header h1 {
    text-align: center;
    line-height: 300px;
    font-size: 7vw;
    font-family: var(--site-header-font);
    font-weight: 900;
}
header h1 a {
    color: var(--yellow);
    text-decoration: none;
    
    text-shadow: 2px 2px black;
}
/********************************************** Nav **********************************************/
nav {
    display: flex;
    justify-content: flex-end;
    color: white;
    padding: 20px;
}

nav div {
    display: flex;
    justify-content: center;
    gap: 5px;
}

nav a,
nav label,
#sort-options a {
    color: white;
}
/********************************************** Main **********************************************/
main {
    margin-top: -70px;
    position: relative;
    z-index: 1;
}
#sort-options {
    display: flex;
    justify-content: flex-start;
    gap: 5px;
    color: white;
    margin: 0 50px;
}
.fa-star {
  color: var(--yellow);
}
/********************************************** Brewery List Cards **********************************************/
main #cards {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
}
main #cards article {
    background-color: white;
    display: block;
    margin: 10px;
    width: 400px;
    height: 200px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    position: relative;
    overflow: hidden;
    cursor: pointer;
    font-family: var(--page-header-font);
    border: 1px solid var(--yellow);
}
.info {
    position: absolute;
    z-index: 2;
    padding: 0 5px;
    background-color: var(--info-background);
    color: white;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 5px;
}
.info h2 {
  color:var(--yellow);
}
/********************************************** Page **********************************************/
.page {
    max-width: 900px;
    margin: 0 auto;
    background-color: white;
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    position: relative;
    z-index: 1;
}
.page .header {
    display: flex;
    justify-content: space-around;
}
.page hr {
    margin: 10px 0;
    border-top: 5px solid var(--blue);
    border-radius: 10px;
}
.page p {
    margin: 15px 0;
}
#page-main {
  padding: 10px 20px;
}
/********************************************** Form **********************************************/
.form {
  max-width: 400px;
  margin: 0 auto;
  padding: 25px;
  border-radius: 20px;
  background-color: white;
  box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
}
.form-signin,
.form-register,
.form-beer {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}
.login h1, 
.form h1 {
  text-align: center;
  font-size: 40px;
  font-family: var(--page-header-font);
}
.alert {
  margin: 5px 0;
  padding: 5px;
  border-radius: 5px;
}
.alert-danger {
  background-color: red;
  color: white;
}
.alert-success {
  background-color: green;
  color: white;
}
.button {
  font-size: 15px;
  padding: 10px;
  border-radius: 5px;
  font-weight: bold;
  border: none;
  cursor: pointer;
  color: white;
  background-color: var(--blue);
  text-decoration: none;
  margin: 10px;
}
.blue {
  color: blue;
  -webkit-text-stroke: 2px white;
}
.brewery-image {
  width: 100%;
  position: relative;
  z-index: 1;
}

input[type="radio"] {
  display: none;
}

.radio-button {
  background-color: rgba(0,0,255,0.5);
  padding: 5px 10px;
  border-radius: 5px;
  color: white;
  box-shadow:inset 0 -0.6em 0 -0.35em rgba(0,0,0,0.17);
  cursor: pointer;
  margin: 0 5px;
}

input:checked + label {
  background-color: var(--blue);
}
input {
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  font-size: 16px;
  padding: 3px;
}
textarea {
    width: 100%;
  height: 150px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  font-size: 16px;
}

/********************************************** Brewery Page **********************************************/
#page-header {
  height: 400px;
  overflow: hidden;
}
#page-header img {
  width: 100%;
}
.brewery-info {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 2;
  background-color: var(--info-background);
  color: white;
  padding: 20px;
  height: 360px;
  font-family: var(--page-header-font);
  font-size: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 20px;
}
.brewery-info h2 {
  font-size: 30px;
  color: var(--yellow);
}
.brewery-info h3 {
  font-size: 30px;
}
.brewery-info #hours {
  flex-grow: 1;
}
.add {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  gap: 0 !important;
  background-color: grey;
  height: 100%;
  color: white;
  font-size: 30px;
}
.plus {
  font-size: 100px;
}
/************************* Beer List ********************************************/
.beerHeader {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.beer {
  border-bottom: 5px solid var(--blue);
}
.beer article {
  padding: 5px 0;
   display: flex;
  justify-content: space-between;
  align-items: center;
}
.beer:last-child {
  border: none;
}

.beer-info {
  display: block;
}
.beer-image-container {
  border: none;
}
.beer-image-container img {
  height: 200px;
  width: auto;
}
.brewer-btns {
  display: flex;
  justify-content: space-between;
}
.beer-link,
.beer-image {
  cursor:pointer;
}
.beer-link:hover {
  text-decoration: underline;
}
.review {
  border-bottom: 5px solid var(--blue);
}
.review:last-child {
  border: none;
}
/************************* Admin ********************************************/
table {
  width: 100%;
  border-collapse: collapse;
}
thead th {
  background-color: var(--blue);
  color: white;
}
tbody td,
tbody td {
    border: 1px solid #ddd;
    padding: 8px;
}
tbody tr:nth-child(even){background-color: #f2f2f2;}
tbody tr:hover {background-color: #ddd;}
table .button {
  margin:0;
}

/************************* Device Breakpoints (screen size) ********************************************/
@media screen and (max-width: 900px) {
    .brewery-card {
        width: 90% !important;
    }
}
</style>
