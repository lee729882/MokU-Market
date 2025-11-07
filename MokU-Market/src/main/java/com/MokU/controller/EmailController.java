package com.MokU.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.MokU.service.EmailService;

@Controller
@RequestMapping("/email")
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/send")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email, HttpSession session) {
        try {
            String code = emailService.sendAuthCode(email);
            session.setAttribute("authEmail", email);
            session.setAttribute("authCode", code);
            return "success";
        } catch (Exception e) {
            return "fail";
        }
    }

    @PostMapping("/verify")
    @ResponseBody
    public String verifyCode(@RequestParam("code") String code, HttpSession session) {
        String savedCode = (String) session.getAttribute("authCode");
        if (savedCode != null && savedCode.equals(code)) {
            session.setAttribute("emailVerified", true);
            return "verified";
        }
        return "invalid";
    }
}
