<template>
  <div>
    <section id="cards">
      
      <article class="brewery-card" 
        v-for="brewery in breweries" 
        v-bind:key="brewery.breweryId"
        v-on:click="viewBreweryDetail(brewery.breweryId)"
      >
        <div class="info">
          <h2>{{ brewery.breweryName }}</h2>
          <p><i class="fa-solid fa-location-dot blue"></i> {{ brewery.address }}</p>
          <p style="flex-grow:1;"><i class="fa-solid fa-phone blue"></i> {{ brewery.phoneNumber }}</p>
          <p><i class="fa-solid blue fa-clock"></i> {{brewery.hours}}</p>
          <h4 v-if="brewery.numOfReviews===0">No Ratings</h4>
        <h4 v-if="brewery.numOfReviews!==0">Average Rating: <i class="fa-solid fa-star"></i> {{brewery.rating}} | {{brewery.numOfReviews}} Review<span v-if="brewery.numOfReviews>1">s</span></h4>
        </div>
        <img v-bind:src="brewery.imageURL" class="brewery-image" />
      </article>
    </section>
  </div>
</template>

<script>
import breweryService from "../services/BreweryService";
export default {
  name: "brewery-list",
  data() {
    return {
      breweries: [],
    };
  },
  methods: {
    viewBreweryDetail(breweryID) {
      this.$router.push(`/brewery/${breweryID}`)
    }
  },
  created() {
    breweryService.getBreweries().then((response) => {
      this.breweries = response.data;
    });
  },
};
</script>
