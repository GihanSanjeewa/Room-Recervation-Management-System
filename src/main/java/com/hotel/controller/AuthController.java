package com.hotel.controller;

import com.hotel.dao.UserDAO;
import com.hotel.model.User;
import com.hotel.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/login".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(req, resp);
            return;
        }
        if ("/register".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(req, resp);
            return;
        }
        if ("/logout".equals(path)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/register".equals(path)) {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String address = req.getParameter("address");

            boolean ok = userDAO.createUser(fullName, email, phone,address, PasswordUtil.sha256(password));
            if (!ok) {
                req.setAttribute("error", "Registration failed. Email may already exist.");
                req.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(req, resp);
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login?registered=1");
            return;
        }

        if ("/login".equals(path)) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            User user = userDAO.login(email, PasswordUtil.sha256(password));

            if (user == null) {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("authUser", user);

            // redirect by role
            if ("ADMIN".equals(user.getRole())) resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            else if ("STAFF".equals(user.getRole())) resp.sendRedirect(req.getContextPath() + "/staff/dashboard");
            else resp.sendRedirect(req.getContextPath() + "/home");

        }
    }
}
