<template>
    <div class="page">
        <div id="page-main">
        <beer-detail/>
        <review-list/>
        </div>
    </div>
</template>

<script>
import BeerDetail from '../components/BeerDetail.vue'
import ReviewList from '../components/ReviewList.vue'
export default {
  components: { BeerDetail, ReviewList },
}
</script>

<style>

</style>