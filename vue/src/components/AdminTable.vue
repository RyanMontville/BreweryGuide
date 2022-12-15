<template>
  <section class="page">
    <div id="page-main">
      <h2>Breweries to approve</h2>
      <table v-if="this.breweries.length>0">
        <thead>
          <tr>
            <th>Brewery Name</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Hours</th>
            <th>Owner ID</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="brewery in breweries" v-bind:key="brewery.breweryId">
            <td>{{brewery.breweryName}}</td>
            <td>{{brewery.phoneNumber}}</td>
            <td>{{brewery.address}}</td>
            <td>{{brewery.hours}}</td>
            <td>{{brewery.owner}}</td>
            <td><button class="button" v-on:click="approveBrewery(brewery)">Approve</button></td>
            <td><button class="button" v-on:click="deleteBrewery(brewery.breweryId)">Delete</button></td>
          </tr>
        </tbody>
      </table>
      <p v-if="this.breweries.length===0">There are no breweries to approve.</p>
      <br />
      <get-users />
    </div>
  </section>
</template>

<script>
import adminService from '../services/AdminService';
import breweryService from "../services/BreweryService";
import GetUsers from './GetUsers.vue';
export default {
  components: { GetUsers },
    name: "admin-table",
    data() {
      return {
        breweries: [],
        userID: 5
      }
    },
    methods: {
      getUnapproved() {
        adminService.getUnapprovedBreweries().then(response =>{
        this.breweries = response.data;
      });
      },
      approveBrewery(brewery) {
        brewery.isApproved = true;
        breweryService.updateBrewery(brewery.breweryId,brewery).then(response => {
          if(response.status==201 || response.status==200){
            this.getUnapproved();
          }
        });
      },
      deleteBrewery(breweryId) {
        breweryService.deleteBrewery(breweryId).then(response =>{
          if(response.status===204){
            this.getUnapproved();
          }
        })
        this.getUnapproved();
      }
    },
    created() {
      this.getUnapproved();
    }
}
</script>

<style>

</style>