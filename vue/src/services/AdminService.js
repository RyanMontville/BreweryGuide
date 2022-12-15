import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {
  
  getUnapprovedBreweries() {
      return http.get('/admin',{headers:{Authorization:'Bearer ' + localStorage.getItem('token')}});
  },
  updateBrewery(breweryId,brewery) {
    return http.put(`/admin/${breweryId}`, brewery,{headers:{Authorization:'Bearer ' + localStorage.getItem('token')}});
  },
  deleteBrewery(breweryId) {
    return http.delete(`/admin/${breweryId}`,{headers:{Authorization:'Bearer ' + localStorage.getItem('token')}});
  },
  getAllUsers() {
    return http.get('/user')
  }
}
