package com.hotel.util;

import com.hotel.model.Receipt;

public class ReceiptTemplateUtil {

    public static String buildReceiptHtml(Receipt receipt) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
              <meta charset="UTF-8">
              <title>Payment Receipt</title>
            </head>
            <body style="margin:0;padding:0;background:#f4f7fb;font-family:Arial,sans-serif;">
              <div style="max-width:760px;margin:30px auto;background:#ffffff;border-radius:18px;overflow:hidden;box-shadow:0 8px 30px rgba(0,0,0,0.08);">
                
                <div style="background:linear-gradient(135deg,#0d6efd,#198754);padding:30px;color:#fff;">
                  <h1 style="margin:0;font-size:28px;">Ocean View Resort</h1>
                  <p style="margin:8px 0 0 0;font-size:14px;opacity:.95;">Official Payment Receipt</p>
                </div>

                <div style="padding:30px;">
                  <div style="display:flex;justify-content:space-between;flex-wrap:wrap;gap:20px;margin-bottom:25px;">
                    <div>
                      <p style="margin:0;color:#6c757d;font-size:12px;">Receipt Number</p>
                      <h2 style="margin:6px 0 0 0;font-size:22px;color:#212529;"> + receipt.getReceiptNo() + </h2>
                    </div>
                    <div>
                      <p style="margin:0;color:#6c757d;font-size:12px;">Payment Date</p>
                      <h2 style="margin:6px 0 0 0;font-size:18px;color:#212529;"> + receipt.getPaidAt() + </h2>
                    </div>
                  </div>

                  <div style="background:#f8f9fa;border-radius:14px;padding:18px;margin-bottom:20px;">
                    <h3 style="margin:0 0 14px 0;color:#0d6efd;">Guest Details</h3>
                    <p style="margin:6px 0;"><strong>Name:</strong> + receipt.getGuestName() +</p>
                    <p style="margin:6px 0;"><strong>Email:</strong> + receipt.getGuestEmail() +</p>
                    <p style="margin:6px 0;"><strong>Reservation Code:</strong>  + receipt.getReservationCode() + </p>
                  </div>

                  <div style="background:#f8f9fa;border-radius:14px;padding:18px;margin-bottom:20px;">
                    <h3 style="margin:0 0 14px 0;color:#198754;">Room Details</h3>
                    <p style="margin:6px 0;"><strong>Room Number:</strong>  + receipt.getRoomNumber() + </p>
                    <p style="margin:6px 0;"><strong>Room Type:</strong>  + receipt.getRoomType() + </p>
                    <p style="margin:6px 0;"><strong>Check-in:</strong>  + receipt.getCheckInDate() + </p>
                    <p style="margin:6px 0;"><strong>Check-out:</strong>  + receipt.getCheckOutDate() + </p>
                  </div>

                  <table style="width:100%;border-collapse:collapse;margin-top:10px;">
                    <thead>
                      <tr style="background:#0d6efd;color:#fff;">
                        <th style="padding:14px;text-align:left;">Description</th>
                        <th style="padding:14px;text-align:left;">Method</th>
                        <th style="padding:14px;text-align:right;">Amount</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr style="border-bottom:1px solid #e9ecef;">
                        <td style="padding:14px;">Reservation Payment</td>
                        <td style="padding:14px;"> + receipt.getPaymentMethod() + </td>
                        <td style="padding:14px;text-align:right;">LKR  + receipt.getAmountPaid() + </td>
                      </tr>
                    </tbody>
                  </table>

                  <div style="margin-top:24px;padding:18px;border-radius:14px;background:#eaf7ee;">
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                      <span style="font-size:16px;color:#212529;"><strong>Status:</strong>  + receipt.getPaymentStatus() + </span>
                      <span style="font-size:24px;color:#198754;font-weight:bold;">LKR  + receipt.getAmountPaid() + </span>
                    </div>
                  </div>

                  <p style="margin-top:30px;font-size:13px;color:#6c757d;line-height:1.7;">
                    Thank you for choosing Ocean View Resort. This email confirms that your payment was received successfully.
                    Please keep this receipt for your records.
                  </p>
                </div>
              </div>
            </body>
            </html>
            """;
    }
}