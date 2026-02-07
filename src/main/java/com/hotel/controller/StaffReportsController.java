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
        req.setAttribute("summary", reportDAO.getSummary());
        req.setAttribute("topRooms", reportDAO.getTopRooms(5));
        req.getRequestDispatcher("/WEB-INF/views/staff/reports.jsp").forward(req, resp);
    }
}
