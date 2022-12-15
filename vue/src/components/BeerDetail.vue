<template>
  <div class="beer">
     <article>
      <div class="beer-info">
        <h3 v-bind:beer=beer  >{{ beer.name }}</h3>
        <h4>{{ beer.style }}</h4>
        <h4>ABV: {{ beer.abv }}</h4>
        <h4>${{ beer.price }}</h4>
        <p>{{ beer.description }}</p>
      </div>
      <div class="beer-image-container">
        <img v-bind:src="beer.image" v-if="beer.image !== null" />
        <img src="../assets/mug.png" v-if="beer.image === null" />
      </div>
    </article>
  </div>
</template>

<script>
import BeerService from "../services/BeerService";


export default {
  
  name: "beer-detail",
  data() {
    return {
      errorMsg: "",
    };
  },
  methods: {
    retrieveBeer() {
      BeerService
        .getBeerDetail(this.$route.params.id)
        .then(response => {
          this.$store.commit("SET_CURRENT_BEER", response.data);
        })
        .catch(error => {
          if (error.response && error.response.status === 404) {
            alert(
              "Beer not available. It may have been deleted or you have entered an invalid brewery ID."
            );
          }
        });
    }
  },
  created() {
    this.retrieveBeer();
  },
  computed: {
    beer() {
      return this.$store.state.beer;
    },
  },
};
</script>

<style>

</style>