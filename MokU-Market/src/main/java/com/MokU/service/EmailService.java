package com.MokU.service;

public interface EmailService {
    String sendAuthCode(String email) throws Exception;
}
