package com.techelevator.dao;

import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcBreweryDao implements BreweryDao{

    private static List<Brewery> breweries = new ArrayList<>();
    private JdbcTemplate jdbcTemplate;
    private BreweryDao breweryDao;

    public JdbcBreweryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Brewery> getAllBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description\n, is_approved, owner, hours" +
                "\tFROM public.brewery WHERE is_approved = true ORDER BY brewery_name ASC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while(result.next()){
            breweries.add(mapToBrewery(result));
        }

        for(Brewery brewery : breweries){
            int breweryId = brewery.getBreweryId();
            sql = "SELECT ROUND(AVG(rating),1) as rating FROM public.beer_reviews WHERE brewery_id=?;";
            Double rating = jdbcTemplate.queryForObject(sql, Double.class, breweryId);
            if (rating == null) {
                brewery.setRating(0.0);
            } else {
                brewery.setRating(rating);
            }
            sql = "SELECT COUNT(*) FROM public.beer_reviews WHERE brewery_id = ?;";
            Integer numOfReviews = jdbcTemplate.queryForObject(sql, Integer.class, breweryId);
            if (numOfReviews == null) {
                brewery.setNumOfReviews(0);
            } else {
                brewery.setNumOfReviews(numOfReviews);
            }
        }
        return breweries;
    }

    public List<Brewery> getAllUnapprovedBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description\n, is_approved, owner, hours" +
                "\tFROM public.brewery WHERE is_approved = false ORDER BY brewery_name ASC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while(result.next()){
            breweries.add(mapToBrewery(result));
        }
        return breweries;
    }

    @Override
    public Brewery getBreweryById(int breweryId) {
        Brewery brewery = new Brewery();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description, is_approved, owner, hours " +
                "FROM public.brewery WHERE brewery_id = ?;";
        SqlRowSet result= jdbcTemplate.queryForRowSet(sql, breweryId);
        while(result.next()){
            brewery = mapToBrewery(result);
        }
        sql = "SELECT ROUND(AVG(rating),1) as rating FROM public.beer_reviews WHERE brewery_id=?;";
        Double rating = jdbcTemplate.queryForObject(sql, Double.class, breweryId);
        if (rating == null) {
            brewery.setRating(0.0);
        } else {
            brewery.setRating(rating);
        }
        sql = "SELECT COUNT(*) FROM public.beer_reviews WHERE brewery_id = ?;";
        Integer numOfReviews = jdbcTemplate.queryForObject(sql, Integer.class, breweryId);
        if (numOfReviews == null) {
            brewery.setNumOfReviews(0);
        } else {
            brewery.setNumOfReviews(numOfReviews);
        }
        return brewery;
    }

    @Override
    public Brewery addBrewery(Brewery brewery) {
        Brewery newBrewery = new Brewery();
        newBrewery.setBreweryName(brewery.getBreweryName());
        newBrewery.setPhoneNumber(brewery.getPhoneNumber());
        newBrewery.setAddress(brewery.getAddress());
        newBrewery.setHours(brewery.getHours());
        newBrewery.setImageURL(brewery.getImageURL());
        newBrewery.setDescription(brewery.getDescription());
        newBrewery.setIsApproved(false);
        newBrewery.setOwner(brewery.getOwner());
        String sql="INSERT INTO public.brewery" +
                "(brewery_name, phone_number, address, hours, image_url, description, is_approved, owner) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING brewery_id;";
        int breweryId = jdbcTemplate.queryForObject(sql, int.class, newBrewery.getBreweryName(),newBrewery.getPhoneNumber(),newBrewery.getAddress(), newBrewery.getHours(), newBrewery.getImageURL(), newBrewery.getDescription(), false, newBrewery.getOwner());
        newBrewery.setBreweryId(breweryId);
        return newBrewery;
    }

    @Override
    public Brewery updateBrewery(int breweryId, Brewery brewery) {
        String sql ="UPDATE public.brewery " +
                "SET brewery_name=?, phone_number=?, address=?, image_url=?, description=? " +
                "WHERE brewery_id =?;";
        int numOfRowsUpdated = jdbcTemplate.update(sql, brewery.getBreweryName(),brewery.getPhoneNumber(),brewery.getAddress(),brewery.getImageURL(), brewery.getDescription(), breweryId);

        return getBreweryById(breweryId);
    }

    @Override
    public Brewery updateBreweryAdmin(int breweryId, Brewery brewery) {
        String sql ="UPDATE public.brewery " +
                "SET brewery_name=?, phone_number=?, address=?, image_url=?, description=?, is_approved=?, owner=?" +
                "WHERE brewery_id =?;";
        int numOfRowsUpdated = jdbcTemplate.update(sql, brewery.getBreweryName(),brewery.getPhoneNumber(),brewery.getAddress(),brewery.getImageURL(), brewery.getDescription(), brewery.getIsApproved(), brewery.getOwner(), breweryId);

        return getBreweryById(breweryId);
    }

    @Override
    public List <Brewery> getAllBreweriesByUserId(int userId) {
        List <Brewery> brewery = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description, is_approved, owner, hours " +
                "FROM public.brewery " +
                "WHERE owner = ? ORDER BY brewery_name ASC;";
        SqlRowSet result= jdbcTemplate.queryForRowSet(sql, userId);
        while(result.next()){
           brewery.add(mapToBrewery(result));
        }
        return brewery;
    }

    @Override
    public Brewery create(Brewery brewery, int ownerId) {
        String name = brewery.getBreweryName();
        String number = brewery.getPhoneNumber();
        String address = brewery.getAddress();
        String image = brewery.getImageURL();
        String description = brewery.getDescription();
        boolean defaultIsApproved = false;
        String hours = brewery.getHours();
        String sql = "INSERT INTO public.brewery( " +
                "brewery_name, phone_number, address, image_url, description, is_approved, owner, hours) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING brewery_id;";

        int newBreweryId = jdbcTemplate.queryForObject(sql, Integer.class, name, number, address,
                    image, description, defaultIsApproved, ownerId, hours);

        return getBreweryById(newBreweryId);
    }

    @Override
    public boolean delete(int breweryId) {
        String sql = "DELETE FROM beer_reviews WHERE brewery_id = ?;";
        jdbcTemplate.update(sql, breweryId);
        sql = "DELETE FROM public.brewery WHERE brewery_id = ?;";
        int numOfRowsDeleted = jdbcTemplate.update(sql, breweryId);
        return numOfRowsDeleted == 1;
    }

    private Brewery mapToBrewery(SqlRowSet results){
        try {
            Brewery brewery = new Brewery();
            brewery.setBreweryId(results.getInt("brewery_id"));
            brewery.setAddress(results.getString("address"));
            brewery.setBreweryName(results.getString("brewery_name"));
            brewery.setImageURL(results.getString("image_url"));
            brewery.setPhoneNumber(results.getString("phone_number"));
            brewery.setDescription(results.getString("description"));
            brewery.setIsApproved(results.getBoolean("is_approved"));
            brewery.setOwner(results.getInt("owner"));
            brewery.setHours(results.getString("hours"));
            return brewery;
        }catch(Exception e){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

}
