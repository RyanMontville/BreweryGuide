package com.techelevator.dao;

import com.techelevator.model.Beer;

import java.util.List;

public interface BeerDao {
    List<Beer> getListOfBeers();
    List<Beer> getAllBeersByBreweryId(int breweryId);
    Beer getBeerById(int beerId);
    Beer addBeer(Beer beer);
    boolean updateBeer(int beerId,Beer beer);
    boolean delete(int beerId);
}
