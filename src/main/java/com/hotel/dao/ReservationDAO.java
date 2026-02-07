package com.hotel.dao;

import com.hotel.model.Reservation;
import com.hotel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ReservationDAO {

    public boolean createReservation(Reservation r) {
        String sql = "INSERT INTO reservations(reservation_code,user_id,room_id,check_in,check_out,guests,status,total_amount) " +
                     "VALUES(?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getReservationCode());
            ps.setInt(2, r.getUserId());
            ps.setInt(3, r.getRoomId());
            ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut());
            ps.setInt(6, r.getGuests());
            ps.setString(7, r.getStatus());
            ps.setBigDecimal(8, r.getTotalAmount());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Reservation> getReservationsByUser(int userId) {
        String sql =
            "SELECT res.*, r.room_number, r.type AS room_type " +
            "FROM reservations res " +
            "JOIN rooms r ON r.id=res.room_id " +
            "WHERE res.user_id=? ORDER BY res.id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Reservation> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean cancelReservation(int reservationId, int userId) {
        String sql = "UPDATE reservations SET status='CANCELLED' WHERE id=? AND user_id=? AND status='RESERVED'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Reservation> getAllReservations() {
        String sql =
            "SELECT res.*, r.room_number, r.type AS room_type " +
            "FROM reservations res " +
            "JOIN rooms r ON r.id=res.room_id " +
            "ORDER BY res.id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Reservation> list = new ArrayList<>();
            while (rs.next()) list.add(map(rs));
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private Reservation map(ResultSet rs) throws Exception {
        Reservation r = new Reservation();
        r.setId(rs.getInt("id"));
        r.setReservationCode(rs.getString("reservation_code"));
        r.setUserId(rs.getInt("user_id"));
        r.setRoomId(rs.getInt("room_id"));
        r.setCheckIn(rs.getDate("check_in"));
        r.setCheckOut(rs.getDate("check_out"));
        r.setGuests(rs.getInt("guests"));
        r.setStatus(rs.getString("status"));
        r.setTotalAmount(rs.getBigDecimal("total_amount"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setRoomType(rs.getString("room_type"));
        return r;
    }
    
    public boolean createReservationTx(Connection con, Reservation r) throws Exception {
        String sql = "INSERT INTO reservations(reservation_code,user_id,room_id,check_in,check_out,guests,status,total_amount) " +
                     "VALUES(?,?,?,?,?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getReservationCode());
            ps.setInt(2, r.getUserId());
            ps.setInt(3, r.getRoomId());
            ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut());
            ps.setInt(6, r.getGuests());
            ps.setString(7, r.getStatus());
            ps.setBigDecimal(8, r.getTotalAmount());
            return ps.executeUpdate() == 1;
        }
    }
    
    public Reservation findById(int id) {
        String sql =
            "SELECT res.*, r.room_number, r.type AS room_type " +
            "FROM reservations res JOIN rooms r ON r.id=res.room_id " +
            "WHERE res.id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    /** Staff/Admin cancel any RESERVED reservation */
    public boolean cancelByStaffAdmin(int reservationId) {
        String sql = "UPDATE reservations SET status='CANCELLED' WHERE id=? AND status='RESERVED'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    /**
     * Transaction-safe update:
     * - can change dates, guests, and room
     * - prevents double booking by locking room rows
     */
    public boolean updateReservationWithLock(
            int reservationId,
            int newRoomId,
            String newCheckIn,
            String newCheckOut,
            int newGuests
    ) {
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            con.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

            // Lock target room row (prevents concurrent updates)
            try (PreparedStatement lock = con.prepareStatement(
                    "SELECT id, capacity, status FROM rooms WHERE id=? FOR UPDATE")) {
                lock.setInt(1, newRoomId);
                try (ResultSet rs = lock.executeQuery()) {
                    if (!rs.next()) { con.rollback(); return false; }
                    if (!"AVAILABLE".equals(rs.getString("status"))) { con.rollback(); return false; }
                    int cap = rs.getInt("capacity");
                    if (newGuests <= 0 || newGuests > cap) { con.rollback(); return false; }
                }
            }

            // Get current reservation (lock it too)
            int currentRoomId;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT room_id, status FROM reservations WHERE id=? FOR UPDATE")) {
                ps.setInt(1, reservationId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) { con.rollback(); return false; }
                    if (!"RESERVED".equals(rs.getString("status"))) { con.rollback(); return false; }
                    currentRoomId = rs.getInt("room_id");
                }
            }

            // If changing room, also lock old room to avoid race in edge cases
            if (currentRoomId != newRoomId) {
                try (PreparedStatement lockOld = con.prepareStatement(
                        "SELECT id FROM rooms WHERE id=? FOR UPDATE")) {
                    lockOld.setInt(1, currentRoomId);
                    lockOld.executeQuery();
                }
            }

            // Conflict check on new room (excluding this reservation)
            String conflict =
                    "SELECT 1 FROM reservations " +
                    "WHERE room_id=? AND status='RESERVED' AND id<>? " +
                    "AND (check_in < ? AND check_out > ?) LIMIT 1";

            try (PreparedStatement ps = con.prepareStatement(conflict)) {
                ps.setInt(1, newRoomId);
                ps.setInt(2, reservationId);
                ps.setString(3, newCheckOut);
                ps.setString(4, newCheckIn);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) { con.rollback(); return false; }
                }
            }

            // Update reservation
            String upd =
                    "UPDATE reservations SET room_id=?, check_in=?, check_out=?, guests=? " +
                    "WHERE id=? AND status='RESERVED'";

            try (PreparedStatement ps = con.prepareStatement(upd)) {
                ps.setInt(1, newRoomId);
                ps.setString(2, newCheckIn);
                ps.setString(3, newCheckOut);
                ps.setInt(4, newGuests);
                ps.setInt(5, reservationId);
                int updated = ps.executeUpdate();
                if (updated != 1) { con.rollback(); return false; }
            }

            con.commit();
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    


}
