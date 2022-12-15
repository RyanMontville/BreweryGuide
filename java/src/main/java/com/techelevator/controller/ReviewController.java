package com.techelevator.controller;

import com.techelevator.dao.ReviewDao;
import com.techelevator.model.Review;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@CrossOrigin
public class ReviewController {
    ReviewDao reviewDao;

    public ReviewController(ReviewDao reviewDao) {
        this.reviewDao = reviewDao;
    }

    @RequestMapping(path = "/reviews",method = RequestMethod.GET)
    public List<Review> getAllReviews() {
        return reviewDao.getListOfReviews();
    }

    @RequestMapping(path = "/reviews/{beerId}",method = RequestMethod.GET)
    public List<Review> getReviewsByBeerId(@PathVariable int beerId) {
        List<Review> reviews = reviewDao.getReviewsByBeerId(beerId);
        return reviews;
    }

    @RequestMapping(path = "/{breweryId}/reviews", method = RequestMethod.GET)
    public List<Review> getReviewsForBrewery(@PathVariable int breweryId){
        return reviewDao.getReviewsByBreweryId(breweryId);
    }

    @RequestMapping(path = "/user/{userId}/reviews",method = RequestMethod.GET)
    public List<Review> getUsersReviews(@PathVariable int userId){
        return reviewDao.getReviewsByUserId(userId);
    }

    @RequestMapping(path = "/review/{reviewId}",method = RequestMethod.GET)
    public Review getReviewById(@PathVariable int reviewId) {
        return reviewDao.getReviewById(reviewId);
    }

    @RequestMapping(path = "/review",method = RequestMethod.POST)
    public Review addReview(@RequestBody Review review) {
        return reviewDao.addReview(review);
    }

    @RequestMapping(path = "/reviews/{reviewId}",method = RequestMethod.DELETE)
    public void deleteReview(@PathVariable int reviewId) {
        reviewDao.deleteReview(reviewId);
    }
}
