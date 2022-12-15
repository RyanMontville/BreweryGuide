package com.techelevator.model;

public class Brewery {
    private int breweryId;
    private String breweryName;
    private String imageURL;
    private String phoneNumber;
    private String address;
    private String description;
    private boolean isApproved;
    private int owner;
    private String hours;
    private Double rating = 0.0;
    private Integer numOfReviews = 0;

    public Brewery(){

    }

    public Brewery(String breweryName, String imageURL, String phoneNumber, String address, boolean isApproved, int owner, String hours, Double rating, Integer numOfReviews) {
        this.breweryName = breweryName;
        this.imageURL = imageURL;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.isApproved = isApproved;
        this.owner = owner;
        this.hours = hours;
        this.rating = rating;
        this.numOfReviews = numOfReviews;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public String getBreweryName() {
        return breweryName;
    }

    public void setBreweryName(String breweryName) {
        this.breweryName = breweryName;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean getIsApproved() {return isApproved;}

    public void setIsApproved(boolean approved) {isApproved = approved;}

    public int getOwner() { return owner; }

    public void setOwner(int owner) { this.owner = owner; }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public int getNumOfReviews() {
        return numOfReviews;
    }

    public void setNumOfReviews(Integer numOfReviews) {
        this.numOfReviews = numOfReviews;
    }

    @Override
    public String toString() {
        return "Brewery{" +
                "breweryName='" + breweryName + '\'' +
                ", imageURL='" + imageURL + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", address='" + address + '\'' +
                '}';
    }


}
