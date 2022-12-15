import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBeerForBrewery(breweryID) {
    return http.get(`/${breweryID}/beer`)
  },
  getBeerDetail(beerId) {
    return http.get(`/beer/${beerId}`)
  },
  addBeer(beer){
    return http.post(`/beer`, beer)
  },
  deleteBeer(beerId){
    return http.delete(`/beer/${beerId}`)
  },
  updateBeer(beerId, beer){
    return http.put(`/beer/${beerId}`, beer)
  }
}