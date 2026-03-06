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
import com.hotel.dao.ReceiptDAO;
import com.hotel.model.Receipt;
import com.hotel.util.EmailUtil;
@WebServlet(urlPatterns = {"/payment", "/payment/success", "/payment/cancel"})
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private PaymentDAO paymentDAO = new PaymentDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();
    private ReceiptDAO receiptDAO = new ReceiptDAO();
    
    public PaymentController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/payment".equals(path)) {
            String reservationIdStr = req.getParameter("reservationId");

            if (reservationIdStr == null || reservationIdStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/my-reservations");
                return;
            }

            int reservationId = Integer.parseInt(reservationIdStr);
            User user = (User) req.getSession().getAttribute("authUser");
            Reservation reservation = reservationDAO.findById(reservationId);

            if (user == null || reservation == null || reservation.getUserId() != user.getId()) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            req.setAttribute("reservation", reservation);
            req.getRequestDispatcher("/WEB-INF/views/user/payment_start.jsp").forward(req, resp);
            return;
        }

        if ("/payment/success".equals(path)) {
		    String paymentIdStr = req.getParameter("paymentId");
		
		    if (paymentIdStr == null || paymentIdStr.trim().isEmpty()) {
		        resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=invalid");
		        return;
		    }
		
		    int paymentId = Integer.parseInt(paymentIdStr);
		    int reservationId = paymentDAO.getReservationIdByPaymentId(paymentId);
		    User user = (User) req.getSession().getAttribute("authUser");
		
		    if (user == null || reservationId == 0) {
		        resp.sendError(HttpServletResponse.SC_FORBIDDEN);
		        return;
		    }
		
		    Payment payment = paymentDAO.findById(paymentId);
		    Reservation reservation = reservationDAO.findById(reservationId);
		
		    if (payment == null || reservation == null || reservation.getUserId() != user.getId()) {
		        resp.sendError(HttpServletResponse.SC_FORBIDDEN);
		        return;
		    }
		
		    boolean alreadyPaid = "PAID".equalsIgnoreCase(payment.getStatus());
		
		    if (!alreadyPaid) {
		        paymentDAO.updateStatus(paymentId, "PAID", "REF-" + paymentId);
		
		        if ("ADVANCE".equalsIgnoreCase(payment.getMethod())) {
		            reservationDAO.updatePaymentStatus(reservationId, user.getId(), "ADVANCE_PAID");
		        } else {
		            reservationDAO.updatePaymentStatus(reservationId, user.getId(), "PAID");
		        }
		
		        try {
		            Receipt receipt = receiptDAO.getReceiptByPaymentId(paymentId);
		            if (receipt != null) {
		            	EmailUtil.sendReceiptEmail(receipt);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		            // Do not break payment success flow if email sending fails
		        }
		    }
		
		    resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=success");
		    return;
		}

        if ("/payment/cancel".equals(path)) {
            String paymentIdStr = req.getParameter("paymentId");

            if (paymentIdStr == null || paymentIdStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=invalid");
                return;
            }

            int paymentId = Integer.parseInt(paymentIdStr);
            int reservationId = paymentDAO.getReservationIdByPaymentId(paymentId);
            User user = (User) req.getSession().getAttribute("authUser");
            Reservation reservation = reservationDAO.findById(reservationId);

            if (user == null || reservation == null || reservation.getUserId() != user.getId()) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            paymentDAO.updateStatus(paymentId, "CANCELLED", null);
            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=cancel");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int reservationId = Integer.parseInt(req.getParameter("reservationId"));

        User user = (User) req.getSession().getAttribute("authUser");
        Reservation reservation = reservationDAO.findById(reservationId);

        if (reservation == null || user == null || reservation.getUserId() != user.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Payment latest = paymentDAO.findLatestByReservation(reservationId);
        if (latest != null && "PAID".equals(latest.getStatus())) {
            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=alreadyPaid");
            return;
        }

        if (!"RESERVED".equals(reservation.getStatus())) {
            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=invalid");
            return;
        }

        String paymentMethod = req.getParameter("paymentMethod");
        BigDecimal amountToPay;

        if ("ADVANCE".equals(paymentMethod)) {
            String advanceAmountStr = req.getParameter("advanceAmount");

            if (advanceAmountStr == null || advanceAmountStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/payment?reservationId=" + reservationId + "&error=advanceRequired");
                return;
            }

            try {
                amountToPay = new BigDecimal(advanceAmountStr);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/payment?reservationId=" + reservationId + "&error=invalidAdvance");
                return;
            }

            if (amountToPay.compareTo(BigDecimal.ZERO) <= 0 ||
                amountToPay.compareTo(reservation.getTotalAmount()) >= 0) {
                resp.sendRedirect(req.getContextPath() + "/payment?reservationId=" + reservationId + "&error=invalidAdvance");
                return;
            }
        } else {
            paymentMethod = "CARD";
            amountToPay = reservation.getTotalAmount();
        }

        int paymentId = paymentDAO.createPayment(
                reservationId,
                amountToPay,
                paymentMethod,
                "PENDING",
                "TEMP_REF"
        );

        if (paymentId == 0) {
            resp.sendRedirect(req.getContextPath() + "/my-reservations?pay=failed");
            return;
        }

        req.setAttribute("reservation", reservation);
        req.setAttribute("paymentId", paymentId);
        req.setAttribute("paymentMethod", paymentMethod);
        req.setAttribute("amountToPay", amountToPay);

        req.getRequestDispatcher("/WEB-INF/views/user/payment_confirm.jsp").forward(req, resp);
    }
}