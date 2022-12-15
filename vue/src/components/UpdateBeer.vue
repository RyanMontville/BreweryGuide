<template>
  <section class="form">
    <form @submit.prevent="updateBeer" class="form-beer">
      <h1>Update Beer</h1>
      <div>
        <label class="sr-only">Name</label>
        <input v-model="beer.name" placeholder="Name" type="text" />
      </div>
      <div>
        <label class="sr-only"> Beer Style</label>
        <input v-model="beer.style" placeholder="Beer Style" type="text" />
      </div>
      <div>
        <label class="sr-only">Price</label>
        <input v-model="beer.price" placeholder="Price" type="text" />
      </div>
      <label class="sr-only"> ABV</label>
      <input v-model="beer.abv" placeholder="ABV" type="text" />
      <div>
        <label class="sr-only">Image URL</label>
        <input v-model="beer.image" placeholder="Image URL" type="text" />
      </div>
      <label class="sr-only">Description</label>
      <textarea v-model="beer.description" placeholder="Description" type="text"></textarea>
      <div>
        <button type="submit" class="button">Submit</button>
        <button v-on:click.prevent="resetForm" class="button">Cancel</button>
      </div>
    </form>
  </section>
</template>

<script>
import BeerService from "../services/BeerService";
export default {
    methods:{
    updateBeer() {
      BeerService.updateBeer(this.beer.beerId, this.beer)
        .then((response) => {
          if (response.status ===201 || response.status===200) {
            this.$router.push(`/brewery/${this.$store.state.brewery.breweryId}`)
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
  name: "update-beer",
  data() {
    return {
      message: "",
      beer: {
        breweryId: this.$store.state.brewery.breweryId,
        beerId: this.$store.state.beer.beerId,
        name: this.$store.state.beer.name,
        style: this.$store.state.beer.style,
        price: this.$store.state.beer.price,
        abv: this.$store.state.beer.abv,
        image: this.$store.state.beer.image,
        description: this.$store.state.beer.description,
      },
    };
  },
};
</script>

<style>
</style>