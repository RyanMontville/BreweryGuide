package com.techelevator.controller;

import com.techelevator.dao.JdbcBreweryDao;
import com.techelevator.dao.JdbcUserDao;
import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@PreAuthorize("isAuthenticated()")
@CrossOrigin
public class AdminController {

    //create userDao and breweryDao
    private JdbcBreweryDao breweryDao;
    private JdbcUserDao userDao;

    public AdminController(JdbcUserDao userDao, JdbcBreweryDao breweryDao) {
        this.userDao = userDao;
        this.breweryDao = breweryDao;
    }

    //Admin can view list of all breweries
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(path = "/admin", method = RequestMethod.GET)
    public List<Brewery> getBrewer(){
        return breweryDao.getAllUnapprovedBreweries();
    }

    //Admin can update existing breweries approved status to true or false
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(path = "/admin/{breweryId}", method = RequestMethod.PUT)
    public Brewery update(@RequestBody Brewery brewery, @PathVariable int breweryId) {
        Brewery updateBrewery = breweryDao.updateBreweryAdmin(breweryId, brewery);
        if(brewery.getIsApproved()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Brewery Not Found");
        }else {
            return updateBrewery;
        }
    }

    //Admin can delete a brewery by brewery id
    @PreAuthorize("hasRole('ADMIN')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/admin/{breweryId}", method = RequestMethod.DELETE)
    public void delete(@PathVariable int breweryId) {
        breweryDao.delete(breweryId);
    }
}
