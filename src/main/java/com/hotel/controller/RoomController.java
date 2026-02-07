package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/rooms", "/availability"})
public class RoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/rooms".equals(path)) {
            List<Room> rooms = roomDAO.getAllRooms();
            req.setAttribute("rooms", rooms);
            req.getRequestDispatcher("/WEB-INF/views/public/rooms.jsp").forward(req, resp);
            return;
        }

        // availability page (GET shows form; if query params exist show results)
        String checkIn = req.getParameter("checkIn");
        String checkOut = req.getParameter("checkOut");
        String guestsStr = req.getParameter("guests");
        String type = req.getParameter("type");

        if (checkIn != null && checkOut != null && guestsStr != null) {
            int guests = Integer.parseInt(guestsStr);
            List<Room> available = roomDAO.getAvailableRooms(checkIn, checkOut, guests, type);
            req.setAttribute("availableRooms", available);
        }

        req.getRequestDispatcher("/WEB-INF/views/public/availability.jsp").forward(req, resp);
    }
}
