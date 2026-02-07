package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.dao.RoomImageDAO;
import com.hotel.model.Room;
import com.hotel.model.RoomImage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.*;
import java.util.UUID;

@WebServlet(urlPatterns = {
        "/admin/rooms", "/admin/rooms/create", "/admin/rooms/edit", "/admin/rooms/delete"
})

@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024,      // 1MB
		  maxFileSize = 1024 * 1024 * 10,       // 10MB per file
		  maxRequestSize = 1024 * 1024 * 50     // 50MB total
		)
public class AdminRoomsController extends HttpServlet {

	private static final long serialVersionUID = 1L;

    private final RoomDAO roomDAO = new RoomDAO();
    private final RoomImageDAO roomImageDAO = new RoomImageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/rooms".equals(path)) {
            req.setAttribute("rooms", roomDAO.getAllRooms());
            req.getRequestDispatcher("/WEB-INF/views/admin/rooms_manage.jsp").forward(req, resp);
            return;
        }

        if ("/admin/rooms/create".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/room_form.jsp").forward(req, resp);
            return;
        }

        if ("/admin/rooms/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Room room = roomDAO.findById(id);
            if (room != null) room.setImages(roomImageDAO.getImagesByRoomId(id));
            req.setAttribute("room", room);
            req.getRequestDispatcher("/WEB-INF/views/admin/room_form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/rooms/delete".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));

            if (roomDAO.hasReservations(id)) {
                resp.sendRedirect(req.getContextPath() + "/admin/rooms?msg=hasReservations");
                return;
            }

            roomDAO.deleteRoomHard(id);

            resp.sendRedirect(req.getContextPath() + "/admin/rooms?msg=deleted");
            return;
        }
        Room r = new Room();
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isBlank()) r.setId(Integer.parseInt(idStr));

        r.setRoomNumber(req.getParameter("roomNumber"));
        r.setType(req.getParameter("type"));
        r.setCapacity(Integer.parseInt(req.getParameter("capacity")));
        r.setPricePerNight(new BigDecimal(req.getParameter("pricePerNight")));
        r.setStatus(req.getParameter("status"));
        r.setDescription(req.getParameter("description"));

        int roomId;
        if ("/admin/rooms/create".equals(path)) {
            roomId = roomDAO.createRoomReturnId(r);
            if (roomId == 0) {
                req.setAttribute("error", "Save failed (duplicate room number or invalid data).");
                req.getRequestDispatcher("/WEB-INF/views/admin/room_form.jsp").forward(req, resp);
                return;
            }
        } else {
            boolean ok = roomDAO.updateRoom(r);
            if (!ok) {
                req.setAttribute("error", "Update failed.");
                req.setAttribute("room", r);
                req.getRequestDispatcher("/WEB-INF/views/admin/room_form.jsp").forward(req, resp);
                return;
            }
            roomId = r.getId();
        }

        // Images (simple: comma-separated URLs + one cover index)
        String imagesCsv = req.getParameter("imagesCsv"); // e.g. /assets/img/rooms/room-101-1.jpg, /assets/img/rooms/room-101-2.jpg
        String coverIndexStr = req.getParameter("coverIndex"); // 0-based index

        List<RoomImage> images = new ArrayList<>();
        Collection<Part> parts = req.getParts();

        int order = 1;
        boolean coverSet = false;

        Path uploadDir = com.hotel.util.UploadUtil.roomUploadPhysical(getServletContext(), roomId);
        Files.createDirectories(uploadDir);

        for (Part p : parts) {
            if (!"roomImages".equals(p.getName())) continue;
            if (p.getSize() == 0) continue;

            String submitted = p.getSubmittedFileName();
            String ext = "";
            int dot = submitted.lastIndexOf(".");
            if (dot >= 0) ext = submitted.substring(dot);

            String safeName = UUID.randomUUID().toString().replace("-", "") + ext;
            Path target = uploadDir.resolve(safeName);
            p.write(target.toString());

            // URL to save in DB (web path)
            String imgUrl = com.hotel.util.UploadUtil.roomUploadRelative(roomId) + "/" + safeName;

            RoomImage img = new RoomImage();
            img.setImageUrl(imgUrl);
            img.setCover(!coverSet);
            img.setSortOrder(order++);
            images.add(img);

            coverSet = true;
        }

        // 3) Save images in DB if uploaded
        if (!images.isEmpty()) {
            roomImageDAO.replaceRoomImages(roomId, images);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }
}
