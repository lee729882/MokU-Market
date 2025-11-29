package com.MokU.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityPageController {

    @GetMapping("/community")
    public String community() {
        return "community";   // /WEB-INF/views/community.jsp
    }
}
