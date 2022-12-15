<template>
  <div>
    <section id="cards">
      <article v-on:click="addBrewery()">
        <div class="add">
          <div class="plus">+</div>
          <div>Add A New Brewery</div>
        </div>
      </article>
      <article
        class="brewery-card"
        v-for="brewery in breweries"
        v-bind:key="brewery.breweryId"
        v-on:click="viewBreweryDetail(brewery.breweryId)"
      >
        <div class="info">
          <h2>{{ brewery.breweryName }}</h2>
          <p>
            <i class="fa-solid fa-location-dot blue"></i> {{ brewery.address }}
          </p>
          <p style="flex-grow: 1">
            <i class="fa-solid fa-phone blue"></i> {{ brewery.phoneNumber }}
          </p>
          <p>
            <i class="fa fa-solid fa-clock blue" aria-hidden="true"></i
            >{{ brewery.hours }}
          </p>
          <h4 v-if="brewery.numOfReviews === 0">No Ratings</h4>
          <h4 v-if="brewery.numOfReviews !== 0">
            Average Rating: <i class="fa-solid fa-star"></i>
            {{ brewery.rating }} | {{ brewery.numOfReviews }} Review
            <span v-if="brewery.numOfReviews > 1">s</span>
          </h4>
        </div>
        <img v-bind:src="brewery.imageURL" class="brewery-image" />
      </article>
    </section>
  </div>
</template>

<script>
import brewerService from "../services/BrewerService.js";
export default {
  name: "brewer-list",
  data() {
    return {
      breweries: [],
    };
  },
  methods: {
    viewBreweryDetail(breweryID) {
      this.$router.push(`/brewery/${breweryID}`);
    },
    addBrewery() {
      this.$router.push(`/breweryForm`);
    },
  },
  created() {
    brewerService.getMyBreweries(this.$store.state.user.id).then((response) => {
      this.breweries = response.data;
    });
  },
};
</script>

<style>
</style>