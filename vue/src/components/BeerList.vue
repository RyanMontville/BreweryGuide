<template>
  <div id="page-main">
    <section class="beerHeader">
    <h2>Our Beers</h2>
    <router-link to="/beerForm" v-show="brewerStatus===true" class="button">Add a beer</router-link>
    </section>
    <div v-for="beer in beers" v-bind:key="beer.beerId" class="beer">
      <article>
      <div class="beer-info">
        <h3 v-on:click="viewBeerDetail(beer.beerId)" v-bind:beer="beer" class="beer-link" >{{ beer.name }}</h3>
        <h4>{{ beer.style }}</h4>
        <h4>ABV: {{ beer.abv }}</h4>
        <h4>${{ beer.price }}</h4>
        <p>{{ beer.description }}</p>
      </div>
      <div class="beer-image-container">
        <img v-bind:src="beer.image" v-if="beer.image !== null" v-on:click="viewBeerDetail(beer.beerId)" class="beer-image"/>
        <img src="../assets/mug.png" v-if="beer.image === null" v-on:click="viewBeerDetail(beer.beerId)" class="beer-image"/>
      </div>
    </article>
    <div class="brewer-btns" v-show="brewerStatus===true">
      <button v-on:click="updateBeer(beer)" class="button">Update Beer</button>
      <button v-on:click="deleteBeer(beer.beerId)" class="button">Delete Beer</button>
    </div>
    </div>
    
  </div>
</template>

<script>
import beerService from "../services/BeerService";
export default {
  name: "beer-list",
  methods:{
    deleteBeer(beerId){
      beerService.deleteBeer(beerId).then(response=>{
        if(response.status===200||response.status===201){
      this.getBeers();
        }
      }); 
    },
    updateBeer(beer){
      this.$store.state.beer = beer
      this.$router.push('/updateBeerForm')
    },
    getBeers(){
      beerService.getBeerForBrewery(this.$route.params.id).then((response) => {
      this.beers = response.data;
      this.brewerStatus = this.isBrewer()
    });
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
    viewBeerDetail(beerId) {
      this.$router.push(`/beer/${beerId}`)
    }
  },
  data() {
    return {
      beers: [],
      brewerStatus: false
    };
  },
  created() {
    this.getBeers();
  },
};
</script>

<style>
</style>