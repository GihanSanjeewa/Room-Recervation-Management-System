package com.hotel.controller;

import com.hotel.dao.ReportDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/staff/reports")
public class StaffReportsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String fromStr = req.getParameter("from");
        String toStr = req.getParameter("to");

        java.time.LocalDate from;
        java.time.LocalDate to;

        if (fromStr == null || toStr == null || fromStr.isBlank() || toStr.isBlank()) {
            // Default: last 30 days
            to = java.time.LocalDate.now();
            from = to.minusDays(30);
        } else {
            from = java.time.LocalDate.parse(fromStr);
            to = java.time.LocalDate.parse(toStr);
            if (to.isBefore(from)) {
                // swap if user picks wrong
                java.time.LocalDate tmp = from;
                from = to;
                to = tmp;
            }
        }

        req.setAttribute("from", from.toString());
        req.setAttribute("to", to.toString());

        req.setAttribute("summary", reportDAO.getSummary(from, to));
        req.setAttribute("topRooms", reportDAO.getTopRooms(from, to, 5));

        req.getRequestDispatcher("/WEB-INF/views/staff/reports.jsp").forward(req, resp);
    }

}
