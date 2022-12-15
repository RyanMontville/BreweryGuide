import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBrewery(breweryID) {
    return http.get(`/brewery/${breweryID}`)
  },
  getMyBreweries(brewerId){
    return http.get(`/brewer/${brewerId}`,{headers:{Authorization:'Bearer ' + localStorage.getItem('token')}});
  },
  addBrewery(brewery){
    return http.post(`/brewery`,brewery)
  }
}
