import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBreweries() {
    return http.get('/brewery')
  },

  getBrewery(breweryID) {
    return http.get(`/brewery/${breweryID}`)
  },
  updateBrewery(breweryId,brewery){
    return http.put(`/brewery/${breweryId}`,brewery)
  },
  deleteBrewery(breweryId) {
    return http.delete(`/brewery/${breweryId}`)
  }
  
}
