<template>
  <section class="form">
    <form @submit.prevent="addNewBrewery" class="form-beer">
      <h1>Add Brewery</h1>
      <label for="name" class="sr-only">Name: </label>
      <input
        id="name"
        v-model="brewery.breweryName"
        placeholder="Name"
        type="text"
      />
      <label for="url" class="sr-only">Image URL: </label>
      <input
        id="url"
        v-model="brewery.imageURL"
        placeholder="Image URL"
        type="text"
      />
      <label for="phone" class="sr-only">Phone Number</label>
      <input
        id="phone"
        v-model="brewery.phoneNumber"
        placeholder="Phone Number"
        type="text"
      />
      <label for="address" class="sr-only">Address</label>
      <input
        id="address"
        v-model="brewery.address"
        placeholder="Address"
        type="text"
      />
      <label for="description" class="sr-only">description: </label>
      <textarea
        id="description"
        v-model="brewery.description"
        placeholder="Description"
        type="text"
      ></textarea>
      <label for="hours" class="sr-only">Hours: </label>
      <input
        id="hours"
        v-model="brewery.hours"
        placeholder="hours"
        type="text"
      />
      <div>
        <button type="submit" class="button">Submit</button>
        <button v-on:click.prevent="resetForm" class="button">Cancel</button>
      </div>
    </form>
  </section>
</template>

<script>
import brewerService from "../services/BrewerService.js";
export default {
  name: "new-brewery",
  data() {
    return {
      brewery: {
        breweryId: 0,
        breweryName: "",
        imageURL: "",
        phoneNumber: "",
        address: "",
        description: "",
        isApproved: false,
        owner: this.$store.state.user.id,
        hours: "",
      },
    };
  },
  methods: {
      resetForm() {
          this.brewery = {
        breweryId: 0,
        breweryName: "",
        imageURL: "",
        phoneNumber: "",
        address: "",
        description: "",
        isApproved: false,
        owner: this.$store.state.user.id,
        hours: "",
      }
      },
      addNewBrewery() {
          brewerService.addBrewery(this.brewery).then(response =>{
              if(response.status ===201 || response.status===200) {
                  this.$router.push({ path: `/`})
              }
          })
      }
  }
};
</script>

<style>
</style>