<template>
  <div>
    <div id="page-header">
      <img v-bind:src="brewery.imageURL" />
      <div class="brewery-info">
          <h2>{{ brewery.breweryName }}</h2>
          <h3 id="address"><i class="fa-solid fa-location-dot blue"></i> {{ brewery.address }}</h3>
        <h3><i class="fa-solid fa-phone blue"></i> {{ brewery.phoneNumber }}</h3>
        <h3 id="hours"><i class="fa-solid fa-clock blue"></i> {{brewery.hours}}</h3>
        <h4 v-if="brewery.numOfReviews===0">No Ratings</h4>
        <h4 v-if="brewery.numOfReviews!==0">Average Rating: <i class="fa-solid fa-star"></i> {{brewery.rating}} | {{brewery.numOfReviews}} Review<span v-if="brewery.numOfReviews>1">s</span></h4>
      </div>
    </div>
    <div id="page-main">
      <h2>Our History</h2>
      <p>{{ brewery.description }}</p>
    </div>

  </div>
</template>

<script>
import breweryService from "../services/BreweryService";


export default {
  
  name: "brewery-detail",
  data() {
    return {
      errorMsg: "",
    };
  },
  methods: {
    retrieveBrewery() {
      breweryService
        .getBrewery(this.$route.params.id)
        .then(response => {
          this.$store.commit("SET_CURRENT_BREWERY", response.data);
        })
        .catch(error => {
          if (error.response && error.response.status === 404) {
            alert(
              "Brewery not available. It may have been deleted or you have entered an invalid brewery ID."
            );
          }
        });
    },
  },
  created() {
    this.retrieveBrewery();
  },
  computed: {
    brewery() {
      return this.$store.state.brewery;
    },
  },
};
</script>

<style>

</style>