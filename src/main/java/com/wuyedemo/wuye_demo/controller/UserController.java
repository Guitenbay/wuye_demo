package com.wuyedemo.wuye_demo.controller;

import com.wuyedemo.wuye_demo.dao.UserMapper;
import com.wuyedemo.wuye_demo.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({"/user"})
public class UserController {

    @Autowired
    UserMapper userMapper;

    @RequestMapping(value="/info")
    @ResponseBody
    public String getUserInfoByName(String name){
        User user = userMapper.findUserByName(name).get(0);
        return user.getName() + "----" + user.getAge();
    }

}
