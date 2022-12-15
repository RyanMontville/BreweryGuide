package com.techelevator.model;

public class Review {

    private int reviewId;
    private int beerId;
    private String username;
    private int userId;
    private int breweryId;
    private int rating;
    private String review;

    public Review(){}

    public Review(int reviewId, int beerId, String username, int userId, int breweryId, int rating, String review) {
        this.reviewId = reviewId;
        this.beerId = beerId;
        this.username = username;
        this.userId = userId;
        this.breweryId = breweryId;
        this.rating = rating;
        this.review = review;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getBeerId() {
        return beerId;
    }

    public void setBeerId(int beerId) {
        this.beerId = beerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }
}
