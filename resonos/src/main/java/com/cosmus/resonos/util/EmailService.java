package com.cosmus.resonos.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendMail(String to, String content, String value) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("tjsans9069@gmail.com");
        message.setTo(to);
        message.setSubject("안녕하세요 Resonos 입니다.");
        message.setText(content + " " + value);
        mailSender.send(message);
    }
}
