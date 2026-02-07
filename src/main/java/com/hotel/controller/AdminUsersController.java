package com.hotel.controller;

import com.hotel.dao.UserDAO;
import com.hotel.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = {
        "/admin/users",
        "/admin/user/update-role",
        "/admin/user/block",
        "/admin/user/unblock"
})
public class AdminUsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userDAO.getAllUsers());
        req.getRequestDispatcher("/WEB-INF/views/admin/users_manage.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        int userId = Integer.parseInt(req.getParameter("userId"));

        if ("/admin/user/update-role".equals(path)) {
            String role = req.getParameter("role"); // USER/STAFF/ADMIN
            userDAO.updateRole(userId, role);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }

        if ("/admin/user/block".equals(path)) {
            userDAO.blockUser(userId);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }

        if ("/admin/user/unblock".equals(path)) {
            userDAO.unblockUser(userId);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
}
