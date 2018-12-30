package com.wuyedemo.wuye_demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class HelloController {

    @GetMapping("/index")
    public String helloHtml(Map<String, Object> map) {
        map.put("hello", "233");
        return "/hello";
    }
}
