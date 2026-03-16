package com.hotel.util;

import com.hotel.model.Receipt;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

public class EmailUtil {

    // Gmail account details
    private static final String FROM_EMAIL = "gihansanjeewa.m@gmail.com";
    private static final String APP_PASSWORD = "impj ysqf mrvu ecmb";

    public static void sendReceiptEmail(Receipt receipt) {
        if (receipt == null || receipt.getGuestEmail() == null || receipt.getGuestEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Receipt or guest email is missing");
        }

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
            message.setSubject("Payment Receipt - " + receipt.getReceiptNo());

            String htmlContent = buildReceiptHtml(receipt);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println("Receipt email sent successfully to: " + receipt.getGuestEmail());

        } catch (Exception e) {
            throw new RuntimeException("Failed to send receipt email", e);
        }
    }

    private static String buildReceiptHtml(Receipt receipt) {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        String checkIn = receipt.getCheckInDate() != null
                ? receipt.getCheckInDate().format(dateFormatter)
                : "N/A";

        String checkOut = receipt.getCheckOutDate() != null
                ? receipt.getCheckOutDate().format(dateFormatter)
                : "N/A";

        String paidAt = "N/A";
        Timestamp timestamp = receipt.getPaidAt();
        if (timestamp != null) {
            paidAt = timestamp.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        }

        String amount = formatAmount(receipt.getAmountPaid());

        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "   <meta charset='UTF-8'>" +
                "   <title>Payment Receipt</title>" +
                "</head>" +
                "<body style='font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;'>" +
                "   <div style='max-width: 700px; margin: auto; background: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);'>" +
                "       <div style='background: #0d6efd; color: white; padding: 20px; text-align: center;'>" +
                "           <h2 style='margin: 0;'>Ocean View Resort</h2>" +
                "           <p style='margin: 5px 0 0;'>Payment Receipt</p>" +
                "       </div>" +
                "       <div style='padding: 25px;'>" +
                "           <p>Dear <strong>" + safe(receipt.getGuestName()) + "</strong>,</p>" +
                "           <p>Thank you for your payment. Your reservation payment has been successfully received.</p>" +

                "           <h3 style='color: #0d6efd;'>Receipt Details</h3>" +
                "           <table style='width: 100%; border-collapse: collapse;'>" +
                row("Receipt No", receipt.getReceiptNo()) +
                row("Reservation Code", receipt.getReservationCode()) +
                row("Room Number", receipt.getRoomNumber()) +
                row("Room Type", receipt.getRoomType()) +
                row("Check-in Date", checkIn) +
                row("Check-out Date", checkOut) +
                row("Payment Method", receipt.getPaymentMethod()) +
                row("Amount Paid", amount) +
                row("Payment Status", receipt.getPaymentStatus()) +
                row("Paid At", paidAt) +
                "           </table>" +

                "           <p style='margin-top: 20px;'>We look forward to welcoming you to Ocean View Resort.</p>" +
                "           <p>Best regards,<br><strong>Ocean View Resort Team</strong></p>" +
                "       </div>" +
                "       <div style='background: #f1f1f1; text-align: center; padding: 15px; font-size: 12px; color: #666;'>" +
                "           This is an automated email. Please do not reply to this message." +
                "       </div>" +
                "   </div>" +
                "</body>" +
                "</html>";
    }

    private static String row(String label, String value) {
        return "<tr>" +
                "<td style='border: 1px solid #ddd; padding: 10px; background: #f9f9f9; font-weight: bold; width: 35%;'>" + safe(label) + "</td>" +
                "<td style='border: 1px solid #ddd; padding: 10px;'>" + safe(value) + "</td>" +
                "</tr>";
    }

    private static String formatAmount(BigDecimal amount) {
        if (amount == null) {
            return "N/A";
        }
        DecimalFormat df = new DecimalFormat("#,##0.00");
        return "LKR " + df.format(amount);
    }

    private static String safe(String value) {
        return value == null ? "N/A" : value;
    }
}
