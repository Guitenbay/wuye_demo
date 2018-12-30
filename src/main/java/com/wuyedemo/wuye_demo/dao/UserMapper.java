package com.wuyedemo.wuye_demo.dao;

import com.wuyedemo.wuye_demo.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import java.util.List;

@Mapper
// 该注释是解决 IDEA mapper 注入时显示 could not autowire, no beans type of 'userMapper' found
@Component(value = "userMapper")
public interface UserMapper {

    @Select("select * from user where name=#{name}")
    List<User> findUserByName(String name);

}
