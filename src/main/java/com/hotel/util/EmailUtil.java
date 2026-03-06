package com.hotel.util;

import com.hotel.model.Receipt;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "gihansanjeewa.m@gmail.com";
    private static final String APP_PASSWORD = "idlg gcsu edvn wcoa";

    public static void sendReceiptEmail(Receipt receipt) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Ocean View Resort"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(receipt.getGuestEmail()));
            message.setSubject("Your Payment Receipt - " + receipt.getReceiptNo());

            String html = ReceiptTemplateUtil.buildReceiptHtml(receipt);
            message.setContent(html, "text/html; charset=UTF-8");

            Transport.send(message);
        } catch (Exception e) {
            throw new RuntimeException("Failed to send receipt email", e);
        }
    }
}