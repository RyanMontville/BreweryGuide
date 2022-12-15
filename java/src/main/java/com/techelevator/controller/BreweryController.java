package com.techelevator.controller;

import com.techelevator.dao.BreweryDao;
import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@CrossOrigin
public class BreweryController {
    private BreweryDao breweryDao;

    public BreweryController(BreweryDao breweryDao){
        this.breweryDao = breweryDao;
    }

    @RequestMapping(path = "/brewery", method = RequestMethod.GET)
    public List<Brewery> getAllBreweries(){
        return breweryDao.getAllBreweries();
    }

    @RequestMapping(path = "/brewery/{breweryId}", method = RequestMethod.GET)
    public Brewery getAllBreweriesById(@PathVariable int breweryId){
        return breweryDao.getBreweryById(breweryId);
    }

    @RequestMapping(path = "/brewery", method = RequestMethod.POST)
    public Brewery addBrewery(@RequestBody Brewery brewery) {
        if (brewery != null) {
            breweryDao.addBrewery(brewery);
        }
        return brewery;
    }

    @RequestMapping(path = "/brewery/{breweryId}", method = RequestMethod.PUT)
    public void updateBrewery(@PathVariable int breweryId, @RequestBody Brewery brewery){
        if(breweryId != brewery.getBreweryId()){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Brewery Id not found");
        }
        breweryDao.updateBreweryAdmin(breweryId, brewery);
    }

@ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/brewery/{breweryId}", method = RequestMethod.DELETE)
    public boolean delete(@PathVariable int breweryId) {
    if (!breweryDao.delete(breweryId)) {
        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Brewery " + breweryId + " not found");
    } else {
        return breweryDao.delete(breweryId);
    }
}

}
