<template>
  <section class="form">
    <form @submit.prevent="addNewReview" class="form-beer">
      <h1>Add Review</h1>
      <div>
        <label for="rating">Rating: </label>
        <select name="rating" id="cars"  v-model="review.rating" placeholder="5">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
      </div>
      <div>
          <label class="sr-only">Review:</label>
          <textarea v-model="review.review" placeholder="Type your review here" type="textarea"></textarea>
      </div>
      <div>
        <button type="submit" class="button">Submit</button>
        <button v-on:click.prevent="resetForm" class="button">Cancel</button>
      </div>
    </form>
  </section>
</template>

<script>
import ReviewService from "../services/ReviewService";
export default {
    methods:{
    addNewReview() {
      ReviewService.addReview(this.review)
        .then((response) => {
          if (response.status ===201 || response.status===200) {
            this.$router.push(`/beer/${this.$store.state.beer.beerId}`)
          }
        })
        .catch((error) => {
          alert(error.response);
        });
    },
    resetForm() {
      this.$router.push(`/brewery/${this.$store.state.brewery.breweryId}`);
    },
    },
  name: "new-review",
  data() {
    return {
      message: "",
      review: {
        beerId: this.$store.state.beer.beerId,
        username: this.$store.state.user.username,
        userId: this.$store.state.user.id,
        breweryId: this.$store.state.brewery.breweryId,
        rating: 0,
        review: ''
        }
    };
  },
};
</script>

<style>
</style>