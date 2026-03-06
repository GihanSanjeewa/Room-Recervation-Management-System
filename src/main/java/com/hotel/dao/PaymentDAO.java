package com.hotel.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.hotel.model.Payment;
import com.hotel.util.DBConnection;

public class PaymentDAO {

    public int createPayment(int reservationId, BigDecimal amount, String method, String status, String reference) {
        String sql = "INSERT INTO payments(reservation_id, amount, method, status, reference) VALUES(?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, reservationId);
            ps.setBigDecimal(2, amount);
            ps.setString(3, method);
            ps.setString(4, status);
            ps.setString(5, reference);

            int rows = ps.executeUpdate();
            if (rows != 1) {
                return 0;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

            return 0;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Payment findLatestByReservation(int reservationId) {
        String sql = "SELECT * FROM payments WHERE reservation_id=? ORDER BY id DESC LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Payment p = new Payment();
                p.setId(rs.getInt("id"));
                p.setReservationId(rs.getInt("reservation_id"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setMethod(rs.getString("method"));
                p.setStatus(rs.getString("status"));
                p.setReference(rs.getString("reference"));

                return p;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Payment findById(int paymentId) {
        String sql = "SELECT * FROM payments WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Payment p = new Payment();
                p.setId(rs.getInt("id"));
                p.setReservationId(rs.getInt("reservation_id"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setMethod(rs.getString("method"));
                p.setStatus(rs.getString("status"));
                p.setReference(rs.getString("reference"));

                return p;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateStatus(int paymentId, String status, String reference) {
        String sql = "UPDATE payments " +
                     "SET status=?, reference=?, " +
                     "paid_at = CASE WHEN ?='PAID' THEN NOW() ELSE paid_at END " +
                     "WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, reference);
            ps.setString(3, status);
            ps.setInt(4, paymentId);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public int getReservationIdByPaymentId(int paymentId) {
        String sql = "SELECT reservation_id FROM payments WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("reservation_id") : 0;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public BigDecimal getTotalPaidAmountByReservation(int reservationId) {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total_paid " +
                     "FROM payments " +
                     "WHERE reservation_id = ? AND status = 'PAID'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("total_paid");
                }
                return BigDecimal.ZERO;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public int createPaidCashPayment(int reservationId, BigDecimal amount, String reference) {
        String sql = "INSERT INTO payments(reservation_id, amount, method, status, reference, paid_at) " +
                     "VALUES(?, ?, 'CASH', 'PAID', ?, NOW())";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, reservationId);
            ps.setBigDecimal(2, amount);
            ps.setString(3, reference);

            int rows = ps.executeUpdate();
            if (rows != 1) {
                return 0;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

            return 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public boolean markPaymentAsPaid(int paymentId) {
        String sql = "UPDATE payments SET status='PAID', paid_at=NOW() WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}