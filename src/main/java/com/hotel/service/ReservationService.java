package com.hotel.service;

import com.hotel.dao.ReservationDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Reservation;
import com.hotel.model.Room;
import java.sql.Connection;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;


public class ReservationService {
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    public boolean reserveAlways(int userId, int roomId, LocalDate checkIn, LocalDate checkOut, int guests) {
        Room room = roomDAO.findById(roomId);
        if (room == null) return false;

        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nights <= 0) return false;
        if (guests <= 0 || guests > room.getCapacity()) return false;

        BigDecimal total = room.getPricePerNight().multiply(new BigDecimal(nights));

        Reservation r = new Reservation();
        r.setReservationCode("RSV-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        r.setUserId(userId);
        r.setRoomId(roomId);
        r.setCheckIn(Date.valueOf(checkIn));
        r.setCheckOut(Date.valueOf(checkOut));
        r.setGuests(guests);
        r.setStatus("RESERVED");
        r.setTotalAmount(total);

        try (var con = com.hotel.util.DBConnection.getConnection()) {
            con.setAutoCommit(false);
            con.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

            boolean okAvailable = roomDAO.isRoomAvailableForUpdate(con, roomId, checkIn.toString(), checkOut.toString());
            if (!okAvailable) {
                con.rollback();
                return false;
            }

            boolean inserted = reservationDAO.createReservationTx(con, r);
            if (!inserted) {
                con.rollback();
                return false;
            }

            con.commit();
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public double calculateTotal(int nights, double pricePerNight) {
        return nights * pricePerNight;
    }

    public boolean validateDates(LocalDate checkIn, LocalDate checkOut) {
        if (checkIn == null || checkOut == null) {
            throw new IllegalArgumentException("Dates cannot be null");
        }

        if (!checkOut.isAfter(checkIn)) {
            throw new IllegalArgumentException("Check-out must be after check-in");
        }

        return true;
    }


}
