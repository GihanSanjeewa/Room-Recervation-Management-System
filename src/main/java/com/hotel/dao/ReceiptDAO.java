package com.hotel.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.hotel.model.Receipt;
import com.hotel.util.DBConnection;

public class ReceiptDAO {

    public Receipt getReceiptByPaymentId(int paymentId) {
        String sql =
            "SELECT " +
            "p.id AS payment_id, " +
            "CONCAT('RCPT-', LPAD(p.id, 6, '0')) AS receipt_no, " +
            "u.full_name, " +
            "u.email, " +
            "r.reservation_code, " +
            "rm.room_number, " +
            "rm.type AS room_type, " +
            "r.check_in_date, " +
            "r.check_out_date, " +
            "p.method AS payment_method, " +
            "p.amount AS amount_paid, " +
            "p.status AS payment_status, " +
            "p.created_at AS paid_at " +
            "FROM payments p " +
            "JOIN reservations r ON r.id = p.reservation_id " +
            "JOIN users u ON u.id = r.user_id " +
            "JOIN rooms rm ON rm.id = r.room_id " +
            "WHERE p.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Receipt receipt = new Receipt();
                    receipt.setPaymentId(rs.getInt("payment_id"));
                    receipt.setReceiptNo(rs.getString("receipt_no"));
                    receipt.setGuestName(rs.getString("full_name"));
                    receipt.setGuestEmail(rs.getString("email"));
                    receipt.setReservationCode(rs.getString("reservation_code"));
                    receipt.setRoomNumber(rs.getString("room_number"));
                    receipt.setRoomType(rs.getString("room_type"));
                    receipt.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                    receipt.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                    receipt.setPaymentMethod(rs.getString("payment_method"));
                    receipt.setAmountPaid(rs.getBigDecimal("amount_paid"));
                    receipt.setPaymentStatus(rs.getString("payment_status"));
                    receipt.setPaidAt(rs.getTimestamp("paid_at"));
                    return receipt;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}