package com.hotel.controller;

import com.hotel.dao.RoomImageDAO;
import com.hotel.model.RoomImage;
import com.hotel.util.UploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@WebServlet(urlPatterns = {"/admin/rooms/image/delete", "/admin/rooms/image/set-cover"})
public class AdminRoomImageController extends HttpServlet {

	private static final long serialVersionUID = 1L;
    private final RoomImageDAO roomImageDAO = new RoomImageDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        int imageId = Integer.parseInt(req.getParameter("imageId"));

        RoomImage img = roomImageDAO.findById(imageId);
        if (img == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/rooms");
            return;
        }

        if ("/admin/rooms/image/set-cover".equals(path)) {
            roomImageDAO.setCoverImage(img.getRoomId(), imageId);
            resp.sendRedirect(req.getContextPath() + "/admin/rooms/edit?id=" + img.getRoomId());
            return;
        }

        if ("/admin/rooms/image/delete".equals(path)) {
            // Delete DB record
            boolean ok = roomImageDAO.deleteImageById(imageId);

            // Delete file if it is inside our uploads folder
            // img.getImageUrl() => /uploads/rooms/{roomId}/file.jpg
            if (ok && img.getImageUrl() != null && img.getImageUrl().startsWith("/uploads/rooms/")) {
                try {
                    String filename = img.getImageUrl().substring(img.getImageUrl().lastIndexOf("/") + 1);
                    Path dir = UploadUtil.roomUploadPhysical(getServletContext(), img.getRoomId());
                    Files.deleteIfExists(dir.resolve(filename));
                } catch (Exception ignored) {}
            }

            resp.sendRedirect(req.getContextPath() + "/admin/rooms/edit?id=" + img.getRoomId());
        }
    }
}
