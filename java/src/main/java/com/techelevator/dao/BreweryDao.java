package com.techelevator.dao;


import com.techelevator.model.Brewery;

import java.util.List;

public interface BreweryDao {

    List<Brewery> getAllBreweries();

    Brewery getBreweryById(int breweryId);

    Brewery addBrewery(Brewery brewery);

    Brewery updateBrewery(int breweryId, Brewery brewery);

    List<Brewery> getAllBreweriesByUserId(int userId);

    Brewery create(Brewery brewery, int ownerId);

    Brewery updateBreweryAdmin(int breweryId, Brewery brewery);

    boolean delete(int breweryId);
}
