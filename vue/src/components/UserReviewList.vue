<template>
<section class="page">
    <div id="page-main">
        <p v-show="this.reviews.length==0">There are no reviews by this user</p>
  <div v-for="review in reviews" v-bind:key="review.reviewId" class="review">
      <article>
        <div class="review-info">
          <h4>{{ review.username }} <i 
                class="fa-solid fa-star"
                v-for="n in review.rating"
                v-bind:key="n"
              ></i></h4>
          <p>{{ review.review }}</p>
          <button class="button" v-on:click="deleteReview(review.reviewId)">Delete Review</button>
        </div>
      </article>
    </div>
    </div>
</section>
</template>

<script>
import reviewService from "../services/ReviewService";
export default {
    name: "user-review-list",
    data(){
        return {
            reviews: []
        }
    },
    methods: {
        getReviews() {
            reviewService.getReviewsForUser(this.$route.params.id).then(response =>{
            this.reviews = response.data;
        });
        },
        deleteReview(reviewId) {
            reviewService.deleteReview(reviewId).then(response =>{
                if(response.status==200|| response.status==201){
                    this.getReviews();
                }
            })
        }
    },
    created() {
        this.getReviews();
    }
}
</script>

<style>

</style>