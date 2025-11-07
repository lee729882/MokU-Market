package com.MokU.service;

import java.util.Properties;
import org.springframework.stereotype.Service;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


@Service
public class EmailServiceImpl implements EmailService {

    @Override
    public String sendAuthCode(String email) throws Exception {

        if (!email.endsWith("@mokpo.ac.kr")) {
            throw new IllegalArgumentException("mokpo.ac.kr 이메일만 사용 가능합니다.");
        }

        String authCode = String.valueOf((int)(Math.random() * 900000) + 100000);
        String host = "smtp.gmail.com";
        String user = "lee7298821@gmail.com";
        String password = "pkzqhqjquaukuzrn"; // ✅ 공백 없는 앱 비밀번호

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
        session.setDebug(true); // ✅ SMTP 통신 로그 활성화

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user, "목유마켓"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("목유마켓 이메일 인증코드");
        message.setText("인증코드: " + authCode);

        Transport.send(message);
        System.out.println("메일 전송 완료 ✅: " + email);

        return authCode;
    }
}
