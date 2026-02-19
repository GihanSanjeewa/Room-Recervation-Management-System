package com.hotel.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.hotel.dao.RoomDAO;
@WebServlet("/home")
public class HomeController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private final RoomDAO roomDAO = new RoomDAO();
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	 // ✅ later you can filter “featured” by cover image or status etc.
        req.setAttribute("featuredRooms", roomDAO.getAllRooms()); // for now
        req.setAttribute("heroTitle", "Experience timeless comfort by the ocean");
        req.setAttribute("heroSubtitle", "Discover elegant rooms, premium service, and instant reservations.");

//        // gallery images can come from DB later (room_images table)
//        req.setAttribute("gallery", new String[]{
//                "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=1200",
//                "https://images.unsplash.com/photo-1501117716987-c8e1ecb21000?w=1200",
//                "https://images.unsplash.com/photo-1551887373-6db15d7618f0?w=1200"
//        });
        
        String ctx = req.getContextPath();

        req.setAttribute("gallery", new String[]{
            ctx + "/assets/img/gallery/g1.jpg",
            ctx + "/assets/img/gallery/g2.jpg",
            ctx + "/assets/img/gallery/g3.jpg"
        });

        req.getRequestDispatcher("/WEB-INF/views/public/home.jsp").forward(req, resp);
    }
}
