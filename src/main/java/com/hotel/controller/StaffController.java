package com.hotel.controller;

import com.hotel.dao.ReservationDAO;
import com.hotel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/staff/dashboard")
public class StaffController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = (User) session.getAttribute("authUser");
        if (!"STAFF".equals(u.getRole()) && !"ADMIN".equals(u.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.setAttribute("allReservations", reservationDAO.getAllReservations());
        req.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp").forward(req, resp);
    }
}
