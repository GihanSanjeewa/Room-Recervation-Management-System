package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {
	 	private int id;
	    private int reservationId;
	    private BigDecimal amount;
	    private int method;
	    private String status;
	    private String reference;
	    private java.sql.Timestamp createdAt;
	    private java.sql.Timestamp paidAt;
	    
	    
	    public int getId() { return id; }
	    public int getReservationId() { return reservationId; }
	    public BigDecimal getAmount() { return amount; }
	    public int getMethod() { return method; }
	    public String getStatus() { return status; }
	    public String getReference() { return reference; }
	    public Timestamp getCreatedAt() { return createdAt; }
	    public Timestamp getPaidAt() { return paidAt; }


	    public void setId(int id) { this.id = id; }
	    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
	    public void setAmount(BigDecimal amount) { this.amount = amount; }
	    public void setMethod(int method) { this.method = method; }
	    public void setStatus(String status) { this.status = status; }
	    public void setReference(String reference) { this.reference = reference; }
	    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
	    public void setPaidAt(Timestamp paidAt) { this.paidAt = paidAt; }
}
