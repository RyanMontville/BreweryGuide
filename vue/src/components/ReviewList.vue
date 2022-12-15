<template>
  <div>
    <section class="beerHeader">
      <h2>Reviews</h2>
      <router-link to="/reviewForm" v-show="loggedIn === true && brewerStatus===false" class="button">Add Review</router-link>
    </section>
    <div v-for="review in reviews" v-bind:key="review.reviewId" class="review">
      <article>
        <div class="review-info">
          <h4>{{ review.username }} <i 
                class="fa-solid fa-star"
                v-for="n in review.rating"
                v-bind:key="n"
              ></i></h4>
          <p>{{ review.review }}</p>
        </div>
      </article> 
      
    </div>
  </div>
</template>

<script>
import reviewService from "../services/ReviewService";
export default {
  name: "review-list",
  methods: {
    getReviews() {
      reviewService
        .getReviewsForBeer(this.$route.params.id)
        .then((response) => {
          this.reviews = response.data;
          this.loggedIn = this.isLoggedIn();
          this.brewerStatus = this.isBrewer()
        });
    },
    isLoggedIn() {
      if (this.$store.state.token != '') {
        this.loggedIn = "loggedIn";
       return true;
      } else {
        this.loggedIn = "notLoggedIn";
        return false;
      }
    },
    isBrewer() {
      if(this.$store.state.user.id===this.$store.state.brewery.owner){
        this.brewerStatus = "Brewer"
        return true;
      } else {
        this.brewerStatus = "Not a Brewer"
        return false;
      }
    },    
  },
  data() {
    return {
      reviews: [],
      loggedIn: false,
      brewerStatus: false
    };
  },
  created() {
    this.getReviews();
  },
};
</script>

<style>
</style>