<template>
  <section class="page">
    <brewery-detail />
    <beer-list />
  </section>
  
</template>

<script>
import BeerList from '../components/BeerList.vue'
import BreweryDetail from '../components/BreweryDetail.vue'
export default {
  components: { BreweryDetail, BeerList },

}
</script>

<style>

</style>