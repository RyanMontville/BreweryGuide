import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import Brewery from '../views/Brewery.vue'
import BeerForm from '../views/BeerForm.vue'
import UpdateBeerForm from '../views/UpdateBeerForm.vue'
import Beer from '../views/Beer.vue'
import ReviewForm from '../views/ReviewForm.vue'
import BreweryForm from '../views/BreweryForm.vue'
import UserReviews from '../views/UserReviews.vue'

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/brewery/:id",
      name: 'Brewery',
      component: Brewery,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/beerForm",
      name: 'BeerForm',
      component: BeerForm,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/updateBeerForm",
      name: "updateBeerForm",
      component: UpdateBeerForm,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/beer/:id",
      name: 'Beer',
      component: Beer,
      meta: {
        requiresAuth: false
      },
    },
    {
      path: "/reviewForm",
      name: 'ReviewForm',
      component: ReviewForm,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/breweryForm",
      name: 'BreweryForm',
      component: BreweryForm,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/user/:id",
      name: 'UserReviews',
      component: UserReviews,
      meta: {
        requiresAuth: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
