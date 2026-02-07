package com.hotel.controller;

import com.hotel.dao.ReservationDAO;
import com.hotel.dao.RoomDAO;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = {
        "/staff/reservations",
        "/staff/reservation/update",
        "/staff/reservation/cancel"
})
public class StaffReservationController extends HttpServlet {

	private static final long serialVersionUID = 1L;
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // RoleFilter already protects /staff/*
        req.setAttribute("allReservations", reservationDAO.getAllReservations());
        req.setAttribute("rooms", roomDAO.getAllRooms());
        req.getRequestDispatcher("/WEB-INF/views/staff/reservations_manage.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/staff/reservation/cancel".equals(path)) {
            int reservationId = Integer.parseInt(req.getParameter("reservationId"));
            reservationDAO.cancelByStaffAdmin(reservationId);
            resp.sendRedirect(req.getContextPath() + "/staff/reservations?done=1");
            return;
        }

        if ("/staff/reservation/update".equals(path)) {
            int reservationId = Integer.parseInt(req.getParameter("reservationId"));
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            String checkIn = req.getParameter("checkIn");
            String checkOut = req.getParameter("checkOut");
            int guests = Integer.parseInt(req.getParameter("guests"));

            boolean ok = reservationDAO.updateReservationWithLock(reservationId, roomId, checkIn, checkOut, guests);
            resp.sendRedirect(req.getContextPath() + "/staff/reservations?updated=" + (ok ? "1" : "0"));
        }
    }
}
