package com.techelevator.dao;


import com.techelevator.model.Beer;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcBeerDao implements BeerDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcBeerDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public List<Beer> getListOfBeers() {
        List<Beer> beers = new ArrayList<>();
        String sql = "SELECT beer_id, brewery_id, name, style, price, abv, image, description " +
                "FROM public.beer ORDER BY name ASC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while (result.next()){
            beers.add(mapRowToBeer(result));
        }
        return beers;
    }

    @Override
    public List<Beer> getAllBeersByBreweryId(int breweryId) {
        List<Beer> beers = new ArrayList<>();
        String sql = "SELECT beer_id, brewery_id, name, style, price, abv, image, description\n" +
                "\tFROM public.beer WHERE brewery_id = ? ORDER BY name ASC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (result.next()){
            beers.add(mapRowToBeer(result));
        }
        return beers;
    }

    @Override
    public Beer getBeerById(int beerId) {
        Beer beer = new Beer();
        String sql = "SELECT beer_id, brewery_id, name, style, price, abv, image, description FROM public.beer WHERE beer_id=?;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql, beerId);
        if (result.next()){
            beer = mapRowToBeer(result);
        }
        return beer;
    }


    @Override
    public Beer addBeer(Beer beer) {
        Beer newBeer = new Beer();
        newBeer.setBeerId(beer.getBeerId());
        newBeer.setBreweryId(beer.getBreweryId());
        newBeer.setStyle(beer.getStyle());
        newBeer.setName(beer.getName());
        newBeer.setPrice(beer.getPrice());
        newBeer.setImage(beer.getImage());
        newBeer.setDescription(beer.getDescription());
        newBeer.setAbv(beer.getAbv());
        String sql="INSERT INTO public.beer" +
                "(brewery_id, name, style, price, abv, image, description) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING beer_id;";
        int beer_id = jdbcTemplate.queryForObject(sql,int.class,newBeer.getBreweryId(),newBeer.getName(),newBeer.getStyle(),newBeer.getPrice(),newBeer.getAbv(),newBeer.getImage(),newBeer.getDescription());
        newBeer.setBeerId(beer_id);
        return newBeer;
    }

    @Override
    public boolean updateBeer(int beerId, Beer beer) {
            Beer newBeer = new Beer();
            newBeer.setBeerId(beer.getBeerId());
            newBeer.setBreweryId(beer.getBreweryId());
            newBeer.setStyle(beer.getStyle());
            newBeer.setName(beer.getName());
            newBeer.setPrice(beer.getPrice());
            newBeer.setImage(beer.getImage());
            newBeer.setDescription(beer.getDescription());
            newBeer.setAbv(beer.getAbv());
            String sql="UPDATE public.beer " +
                    "SET brewery_id=?, name=?, style=?, price=?, abv=?, image=?, description=? " +
                    "WHERE beer_id=?;";
            int rowsUpdated = jdbcTemplate.update(sql,newBeer.getBreweryId(),newBeer.getName(),newBeer.getStyle(),newBeer.getPrice(),newBeer.getAbv(),newBeer.getImage(),newBeer.getDescription(),newBeer.getBeerId());
            return rowsUpdated==1;

    }

    @Override
    public boolean delete(int beerId) {
            String sql = "DELETE FROM public.beer_reviews WHERE beer_id = ?;";
            jdbcTemplate.update(sql, beerId);
            sql = "DELETE FROM public.beer WHERE beer_id = ?;";
            int numOfRowsDeleted = jdbcTemplate.update(sql, beerId);
            return numOfRowsDeleted == 1;
        }

    public Beer mapRowToBeer(SqlRowSet rowSet){
        try {
            Beer beer = new Beer();
            beer.setBeerId(rowSet.getInt("beer_id"));
            beer.setBreweryId(rowSet.getInt("brewery_id"));
            beer.setName(rowSet.getString("name"));
            beer.setStyle(rowSet.getString("style"));
            if (rowSet.getBigDecimal("price") != null) {
                beer.setPrice(rowSet.getBigDecimal("price"));
            }
            beer.setAbv(rowSet.getDouble("abv"));
            beer.setImage(rowSet.getString("image"));
            beer.setDescription(rowSet.getString("description"));
            return beer;
        }catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

}
