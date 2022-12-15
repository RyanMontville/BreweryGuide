package com.techelevator.controller;

import com.techelevator.dao.JdbcUserDao;
import com.techelevator.model.User;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@RestController
public class UserController {

    //create userDao
    JdbcUserDao userDao;


    public UserController(JdbcUserDao userDao) {
        this.userDao = userDao;
    }

    @RequestMapping(path = "/user", method = RequestMethod.GET)
    public List<User> getAllUsers(){return userDao.findAll();
    }


}
