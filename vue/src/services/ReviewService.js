import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

    getReviewsForBeer(beerId) {
      return http.get(`/reviews/${beerId}`)
    },
    getReviewsForUser(userId) {
      return http.get(`/user/${userId}/reviews`)
    },
    addReview(review) {
        return http.post('/review', review)
    },
    deleteReview(reviewId){
      return http.delete(`/reviews/${reviewId}`)
    }
  }