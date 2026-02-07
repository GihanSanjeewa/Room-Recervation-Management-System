package com.hotel.controller;

import com.hotel.dao.ReservationDAO;
import com.hotel.model.User;
import com.hotel.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(urlPatterns = {"/reserve", "/my-reservations", "/cancel"})
public class ReservationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final ReservationService reservationService = new ReservationService();
    private final ReservationDAO reservationDAO = new ReservationDAO();

    private User requireLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }
        return (User) session.getAttribute("authUser");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User user = requireLogin(req, resp);
        if (user == null) return;

        if ("/my-reservations".equals(path)) {
            req.setAttribute("reservations", reservationDAO.getReservationsByUser(user.getId()));
            req.getRequestDispatcher("/WEB-INF/views/user/my_reservations.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User user = requireLogin(req, resp);
        if (user == null) return;

        if ("/reserve".equals(path)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int guests = Integer.parseInt(req.getParameter("guests"));
            LocalDate checkIn = LocalDate.parse(req.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(req.getParameter("checkOut"));

            boolean ok = reservationService.reserveAlways(user.getId(), roomId, checkIn, checkOut, guests);
            if (!ok) {
                resp.sendRedirect(req.getContextPath() + "/availability?error=1");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/my-reservations?success=1");
            return;
        }

        if ("/cancel".equals(path)) {
            int reservationId = Integer.parseInt(req.getParameter("reservationId"));
            reservationDAO.cancelReservation(reservationId, user.getId());
            resp.sendRedirect(req.getContextPath() + "/my-reservations");
        }
    }
}
