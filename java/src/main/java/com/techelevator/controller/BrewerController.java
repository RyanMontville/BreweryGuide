package com.techelevator.controller;


import com.techelevator.dao.JdbcBreweryDao;
import com.techelevator.dao.JdbcUserDao;
import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AuthorizationServiceException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@RestController

@CrossOrigin
public class BrewerController {

    //create userDao and breweryDao
    private JdbcBreweryDao breweryDao;
    private JdbcUserDao userDao;

    public BrewerController(JdbcUserDao userDao, JdbcBreweryDao breweryDao) {
        this.userDao = userDao;
        this.breweryDao = breweryDao;
    }

    // *GET* ALL BREWERIES OWNED BY BREWER (Must have role BREWER)
    @PreAuthorize("hasRole('BREWER')")
    @RequestMapping(path = "/brewer/{brewerId}", method = RequestMethod.GET)
    public List<Brewery> getBrewer(@PathVariable int brewerId){;

        return breweryDao.getAllBreweriesByUserId(brewerId);
    }
/*
    // *GET* A BREWERY (Must have role BREWER)
    @PreAuthorize("hasRole('BREWER')")
    @RequestMapping(path = "/brewer/{id}", method = RequestMethod.GET)
    public Brewery getBrewerBreweryById(@PathVariable int id) {
        return breweryDao.getBreweryById(id);
    }
*/
    // *CREATE* A BREWERY (Must have role BREWER)
    @PreAuthorize("hasRole('BREWER')")
    @RequestMapping(path = "/brewer", method = RequestMethod.POST)
    public Brewery createBrewery(@RequestBody Brewery brewery, Principal principal) {
        return breweryDao.create(brewery, userDao.findIdByUsername(principal.getName()));
    }

    // *UPDATE* A BREWERY (Must have role brewer AND brewery must be owned by user)
    @PreAuthorize("hasRole('BREWER')")
    @RequestMapping(path = "/brewer/{breweryId}", method = RequestMethod.PUT)
    public Brewery updateBrewery(@RequestBody Brewery brewery, @PathVariable int breweryId, Principal principal) {
        int loggedInUserId = userDao.findIdByUsername(principal.getName());
        // ↓ Conditional statement checks if brewery is owned by user ↓
        if (loggedInUserId != breweryDao.getBreweryById(breweryId).getOwner()) {
            throw new ResponseStatusException(HttpStatus.METHOD_NOT_ALLOWED, "USER ATTEMPTED TO CHANGE UNOWNED BREWERY");
        } else {
            return breweryDao.updateBrewery(breweryId, brewery);
            }
    }
}
