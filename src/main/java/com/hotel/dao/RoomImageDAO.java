package com.hotel.dao;

import com.hotel.model.RoomImage;
import com.hotel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomImageDAO {

    public List<RoomImage> getImagesByRoomId(int roomId) {
        String sql = "SELECT * FROM room_images WHERE room_id=? ORDER BY is_cover DESC, sort_order ASC, id ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                List<RoomImage> list = new ArrayList<>();
                while (rs.next()) {
                    RoomImage img = new RoomImage();
                    img.setId(rs.getInt("id"));
                    img.setRoomId(rs.getInt("room_id"));
                    img.setImageUrl(rs.getString("image_url"));
                    img.setCover(rs.getInt("is_cover") == 1);
                    img.setSortOrder(rs.getInt("sort_order"));
                    list.add(img);
                }
                return list;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void replaceRoomImages(int roomId, List<RoomImage> images) {
        String del = "DELETE FROM room_images WHERE room_id=?";
        String ins = "INSERT INTO room_images(room_id,image_url,is_cover,sort_order) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement ps = con.prepareStatement(del)) {
                ps.setInt(1, roomId);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = con.prepareStatement(ins)) {
                for (RoomImage img : images) {
                    ps.setInt(1, roomId);
                    ps.setString(2, img.getImageUrl());
                    ps.setInt(3, img.isCover() ? 1 : 0);
                    ps.setInt(4, img.getSortOrder());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public boolean deleteByRoomId(int roomId) {
        String sql = "DELETE FROM room_images WHERE room_id=?";
        try (var con = com.hotel.util.DBConnection.getConnection();
             var ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
