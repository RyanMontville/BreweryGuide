import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    users: [],
    user: currentUser || {},
    showForm:false,
    brewery: {
      breweryId: 0,
      breweryName: '',
      imageURL: '',
      phoneNumber: '',
      address: '',
      description: '',
      isApproved:false,
      owner:'',
      hours:"",
      rating: 0,
      numOfReviews: 0
    },
    beers: [],
    beer: {
      beerId: 0,
      breweryId: 0,
      name: '',
      style: '',
      price: 0,
      abv: 0,
      image: '',
      description: ''
    },
    reviews: [],
    review: {
      review_id: 0,
      beerId: 0,
      username: '',
      userId: 0,
      breweryId: 0,
      rating: 0,
      review: ''
    }
  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USERS(state, data){
      state.users = data;
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_CURRENT_BREWERY(state, data) {
      state.brewery = data;
    },
    SET_CURRENT_BEERS(state, data) {
      state.beers = data;
    },
    SET_CURRENT_BEER(state, data) {
      state.beer = data;
    },
    SET_CURRENT_REVIEW(state, data) {
      state.review = data;
    }
  }
})
