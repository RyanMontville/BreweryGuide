package com.techelevator.dao;

import com.techelevator.model.Review;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcReviewDao implements ReviewDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcReviewDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Review> getListOfReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT review_id, beer_id, username, users.user_id, brewery_id, rating, review " +
                "FROM public.beer_reviews JOIN users ON users.user_id = beer_reviews.user_id " +
                "ORDER BY review_id DESC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while (result.next()){
            reviews.add(mapRowToReview(result));
        }
        return reviews;
    }

    @Override
    public List<Review> getReviewsByBeerId(int beerId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT review_id, beer_id, username, users.user_id, brewery_id, rating, review " +
                "FROM public.beer_reviews JOIN users ON users.user_id = beer_reviews.user_id " +
                "WHERE beer_id=? ORDER BY review_id DESC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql,beerId);
        while (result.next()){
            reviews.add(mapRowToReview(result));
        }
        return reviews;
    }

    @Override
    public List<Review> getReviewsByBreweryId(int breweryId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT review_id, beer_id, username, users.user_id, brewery_id, rating, review " +
                "FROM public.beer_reviews JOIN users ON users.user_id = beer_reviews.user_id " +
                "WHERE brewery_id=? ORDER BY review_id DESC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql,breweryId);
        while (result.next()){
            reviews.add(mapRowToReview(result));
        }
        return reviews;
    }

    @Override
    public List<Review> getReviewsByUserId(int userId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT review_id, beer_id, username, users.user_id, brewery_id, rating, review FROM public.beer_reviews " +
                "JOIN users ON users.user_id = beer_reviews.user_id " +
                "WHERE users.user_id=? ORDER BY review_id DESC;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql,userId);
        while (result.next()){
            reviews.add(mapRowToReview(result));
        }
        return reviews;
    }

    @Override
    public Review getReviewById(int reviewId) {
        Review review = new Review();
        String sql = "SELECT review_id, beer_id, username, users.user_id, brewery_id, rating, review " +
                "FROM public.beer_reviews JOIN users ON users.user_id = beer_reviews.user_id " +
                "WHERE review_id=?;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql,reviewId);
        if (result.next()){
            review = mapRowToReview(result);
        }
        return review;
    }

    @Override
    public Review addReview(Review review) {
        Review newReview = new Review();
        newReview.setBeerId(review.getBeerId());
        newReview.setUserId(review.getUserId());
        newReview.setBreweryId(review.getBreweryId());
        newReview.setRating(review.getRating());
        newReview.setReview(review.getReview());
        String sql = "INSERT INTO public.beer_reviews(beer_id, user_id, brewery_id, rating, review) " +
                "VALUES (?, ?, ?, ?, ?) RETURNING review_id;";
        int reviewId = jdbcTemplate.queryForObject(sql,int.class,newReview.getBeerId(),newReview.getUserId(),
                newReview.getBreweryId(),newReview.getRating(),newReview.getReview());
        newReview.setReviewId(reviewId);
        return newReview;
    }

    @Override
    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM public.beer_reviews WHERE review_id=?;";
        int numOfRowsDeleted = jdbcTemplate.update(sql,reviewId);
        return numOfRowsDeleted == 1;
    }

    public Review mapRowToReview(SqlRowSet rowSet){
        try {
            Review review = new Review();
            review.setReviewId(rowSet.getInt("review_id"));
            review.setBeerId(rowSet.getInt("beer_id"));
            review.setUsername(rowSet.getString("username"));
            review.setUserId(rowSet.getInt("user_id"));
            review.setBreweryId(rowSet.getInt("brewery_id"));
            review.setRating(rowSet.getInt("rating"));
            review.setReview(rowSet.getString("review"));
            return review;
        }catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }
}
