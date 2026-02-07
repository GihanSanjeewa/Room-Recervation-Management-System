package com.hotel.dao;

import com.hotel.model.Room;
import com.hotel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

	private final RoomImageDAO roomImageDAO = new RoomImageDAO();
	
    public List<Room> getAllRooms() {
        String sql = "SELECT * FROM rooms ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Room> list = new ArrayList<>();
            while (rs.next()) {
                Room r = map(rs);
                r.setImages(roomImageDAO.getImagesByRoomId(r.getId()));
                list.add(r);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Room> getAvailableRooms(String checkIn, String checkOut, int guests, String type) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT r.* FROM rooms r ")
           .append("WHERE r.status='AVAILABLE' ")
           .append("AND r.capacity >= ? ")
           .append("AND r.id NOT IN ( ")
           .append("  SELECT room_id FROM reservations ")
           .append("  WHERE status='RESERVED' ")
           .append("  AND (check_in < ? AND check_out > ?) ")
           .append(") ");

        if (type != null && !type.isBlank()) sql.append("AND r.type = ? ");
        sql.append("ORDER BY r.price_per_night ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int i = 1;
            ps.setInt(i++, guests);
            ps.setString(i++, checkOut);
            ps.setString(i++, checkIn);

            if (type != null && !type.isBlank()) ps.setString(i++, type);

            try (ResultSet rs = ps.executeQuery()) {

                List<Room> list = new ArrayList<>();
                while (rs.next()) {
                    Room r = map(rs);
                    r.setImages(roomImageDAO.getImagesByRoomId(r.getId()));
                    list.add(r);
                }
                return list;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Room findById(int id) {
        String sql = "SELECT * FROM rooms WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public boolean isRoomAvailableForUpdate(Connection con, int roomId, String checkIn, String checkOut) throws Exception {
        // Lock the room row
        try (PreparedStatement lock = con.prepareStatement("SELECT id FROM rooms WHERE id=? AND status='AVAILABLE' FOR UPDATE")) {
            lock.setInt(1, roomId);
            try (ResultSet rs = lock.executeQuery()) {
                if (!rs.next()) return false;
            }
        }

        String conflict =
            "SELECT 1 FROM reservations " +
            "WHERE room_id=? AND status='RESERVED' " +
            "AND (check_in < ? AND check_out > ?) " +
            "LIMIT 1";

        try (PreparedStatement ps = con.prepareStatement(conflict)) {
            ps.setInt(1, roomId);
            ps.setString(2, checkOut);
            ps.setString(3, checkIn);
            try (ResultSet rs = ps.executeQuery()) {
                return !rs.next();
            }
        }
    }


    private Room map(ResultSet rs) throws Exception {
        Room r = new Room();
        r.setId(rs.getInt("id"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setType(rs.getString("type"));
        r.setCapacity(rs.getInt("capacity"));
        r.setPricePerNight(rs.getBigDecimal("price_per_night"));
        r.setStatus(rs.getString("status"));
        r.setDescription(rs.getString("description"));
        return r;
    }
    
    public int createRoomReturnId(Room r) {
        String sql = "INSERT INTO rooms(room_number,type,capacity,price_per_night,status,description) VALUES(?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, r.getRoomNumber());
            ps.setString(2, r.getType());
            ps.setInt(3, r.getCapacity());
            ps.setBigDecimal(4, r.getPricePerNight());
            ps.setString(5, r.getStatus());
            ps.setString(6, r.getDescription());
            int affected = ps.executeUpdate();
            if (affected != 1) return 0;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            return 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public boolean updateRoom(Room r) {
        String sql = "UPDATE rooms SET room_number=?, type=?, capacity=?, price_per_night=?, status=?, description=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getRoomNumber());
            ps.setString(2, r.getType());
            ps.setInt(3, r.getCapacity());
            ps.setBigDecimal(4, r.getPricePerNight());
            ps.setString(5, r.getStatus());
            ps.setString(6, r.getDescription());
            ps.setInt(7, r.getId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public boolean deleteRoom(int id) {
        String delImgs = "DELETE FROM room_images WHERE room_id=?";
        String delRoom = "DELETE FROM rooms WHERE id=?";

        try (var con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (var ps1 = con.prepareStatement(delImgs)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
            }

            int affected;
            try (var ps2 = con.prepareStatement(delRoom)) {
                ps2.setInt(1, id);
                affected = ps2.executeUpdate();
            }

            con.commit();
            return affected == 1;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public boolean hasReservations(int roomId) {
        String sql = "SELECT 1 FROM reservations WHERE room_id=? LIMIT 1";
        try (var con = DBConnection.getConnection();
             var ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (var rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteRoomHard(int id) {
        String delImgs = "DELETE FROM room_images WHERE room_id=?";
        String delRoom = "DELETE FROM rooms WHERE id=?";

        try (var con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (var ps1 = con.prepareStatement(delImgs)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
            }

            int affected;
            try (var ps2 = con.prepareStatement(delRoom)) {
                ps2.setInt(1, id);
                affected = ps2.executeUpdate();
            }

            con.commit();
            return affected == 1;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }



}
