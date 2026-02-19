package com.hotel.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

import com.hotel.dao.PaymentDAO;
import com.hotel.dao.ReservationDAO;
import com.hotel.model.Payment;
import com.hotel.model.Reservation;
import com.hotel.model.User;

/**
 * Servlet implementation class PaymentController
 */
@WebServlet(urlPatterns = {"/payment", "/payment/success", "/payment/cancel"})
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PaymentDAO paymentDAO = new PaymentDAO();
	private ReservationDAO reservationDAO = new ReservationDAO();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/payment/success".equals(path)) {

            int paymentId = Integer.parseInt(req.getParameter("paymentId"));
            int reservationId = paymentDAO.getReservationIdByPaymentId(paymentId);
            User user = (User) req.getSession().getAttribute("authUser");

            paymentDAO.updateStatus(paymentId, "PAID", "REF-" + paymentId);
            reservationDAO.updatePaymentStatus(reservationId, user.getId(), "PAID");

            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=success");

        } else if ("/payment/cancel".equals(path)) {

            int paymentId = Integer.parseInt(req.getParameter("paymentId"));
            paymentDAO.updateStatus(paymentId, "CANCELLED", null);

            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=cancel");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  // 1) get reservationId
	      int reservationId = Integer.parseInt(req.getParameter("reservationId"));

	      // 2) validate logged user owns this reservation
	      User user = (User) req.getSession().getAttribute("authUser");
	      Reservation r = reservationDAO.findById(reservationId);

	      if (r == null || user == null || r.getUserId() != user.getId()) {
	          resp.sendError(403);
	          return;
	      }

	      // 3) if already paid -> show message
	      Payment latest = paymentDAO.findLatestByReservation(reservationId);
	      if (latest != null && "PAID".equals(latest.getStatus())) {
	          resp.sendRedirect(req.getContextPath()+"/my-reservations?pay=alreadyPaid");
	          return;
	      }
	      
	      if (!"RESERVED".equals(r.getStatus())) {
	    	    resp.sendRedirect(req.getContextPath()+"/my-reservations?pay=invalid");
	    	    return;
	    }

	      // 4) create payment record (PENDING)
	      BigDecimal amount = r.getTotalAmount(); // use reservation total
	      int paymentId = paymentDAO.createPayment(reservationId, amount, "CARD", "PENDING", "TEMP_REF");

	      // 5) go to payment page (JSP)
	      req.setAttribute("reservation", r);
	      req.setAttribute("paymentId", paymentId);
	      req.getRequestDispatcher("/WEB-INF/views/user/payment_start.jsp").forward(req, resp);
	}

}
