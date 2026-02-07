package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Reservation {
    private int id;
    private String reservationCode;
    private int userId;
    private int roomId;
    private Date checkIn;
    private Date checkOut;
    private int guests;
    private String status;
    private BigDecimal totalAmount;

    // extra fields for view joins
    private String roomNumber;
    private String roomType;

    public int getId() { return id; }
    public String getReservationCode() { return reservationCode; }
    public int getUserId() { return userId; }
    public int getRoomId() { return roomId; }
    public Date getCheckIn() { return checkIn; }
    public Date getCheckOut() { return checkOut; }
    public int getGuests() { return guests; }
    public String getStatus() { return status; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public String getRoomNumber() { return roomNumber; }
    public String getRoomType() { return roomType; }

    public void setId(int id) { this.id = id; }
    public void setReservationCode(String reservationCode) { this.reservationCode = reservationCode; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }
    public void setGuests(int guests) { this.guests = guests; }
    public void setStatus(String status) { this.status = status; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public void setRoomType(String roomType) { this.roomType = roomType; }
}
