<template>
  <div>
      <h2>All Users</h2>
      <table>
          <thead>
              <tr>
                  <th>ID</th>
                  <th>Username</th>
                  <th>Role</th>
                  <th></th>
              </tr>
          </thead>
          <tbody>
              <tr v-for="user in users" v-bind:key="user.id">
                  <td>{{user.id}}</td>
                  <td>{{user.username}}</td>
                  <td>{{user.authorities[0].name}}</td>
                  <td><button class="button" v-on:click="viewUserReviews(user.id)" v-show="user.authorities[0].name===userRole">View User's Reviews</button></td>
              </tr>
          </tbody>
      </table>
  </div>
</template>

<script>
import adminService from '../services/AdminService';
export default {
    name: "get-users",
    data() {
        return {
            users: [],
            admin: 'ROLE_ADMIN',
            userRole: 'ROLE_USER',
        }
    },
    methods: {
        viewUserReviews(userId){
            this.$router.push(`/user/${userId}`)
        }
    },
    created() {
        adminService.getAllUsers().then(response =>{
            this.users = response.data;
            this.$store.commit("SET_USERS", response.data);
        }
        )
    }
}
</script>

<style>

</style>