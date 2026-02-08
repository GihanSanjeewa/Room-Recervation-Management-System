package com.hotel.filter;

import com.hotel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(filterName = "RoleFilter")
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        HttpSession session = req.getSession(false);
        User u = (session == null) ? null : (User) session.getAttribute("authUser");

        if (path.startsWith("/staff/")) {
            if (u == null || (!"STAFF".equals(u.getRole()) && !"ADMIN".equals(u.getRole()))) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }
        }

        if (path.startsWith("/admin/")) {
            if (u == null || !"ADMIN".equals(u.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
