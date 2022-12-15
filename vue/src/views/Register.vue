<template>
  <div id="register" class="text-center">
    <section class="form">
      <form class="form-register" @submit.prevent="register">
        <h1>Create Account</h1>
        <div class="alert alert-danger" role="alert" v-if="registrationErrors">
          {{ registrationErrorMsg }}
        </div>
        <div id="username">
          <label for="username" class="sr-only">Username</label>
          <input
            type="text"
            id="username"
            class="form-control"
            placeholder="Username"
            v-model="user.username"
            required
            autofocus
          />
        </div>
        <div id="password">
          <label for="password" class="sr-only">Password</label>
          <input
            type="password"
            id="password"
            class="form-control"
            placeholder="Password"
            v-model="user.password"
            required
          />
        </div>
        <div id="confirm">
          <input
            type="password"
            id="confirmPassword"
            class="form-control"
            placeholder="Confirm Password"
            v-model="user.confirmPassword"
            required
          />
        </div>
        <div>
          <label >Choose a type of account: </label>
          <input type="radio" value="user" v-model="user.role" id="user" name="role" />
          <label for="user" class="radio-button"> user </label>
          <input type="radio" value="brewer" v-model="user.role" id="brewer" name="role"/>
          <label for="brewer" class="radio-button"> brewer </label>
        </div>
        <router-link :to="{ name: 'login' }">Have an account?</router-link>
        <button class="button" type="submit">
          Create Account
        </button>
      </form>
    </section>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "register",
  data() {
    return {
      user: {
        username: "",
        password: "",
        confirmPassword: "",
        role: "user",
      },
      registrationErrors: false,
      registrationErrorMsg: "There were problems registering this user.",
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = "Password & Confirm Password do not match.";
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: "/login",
                query: { registration: "success" },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = "Bad Request: Validation Errors";
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = "There were problems registering this user.";
    },
  },
};
</script>

<style></style>
