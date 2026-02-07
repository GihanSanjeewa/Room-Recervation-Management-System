package com.hotel.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Room {
    private int id;
    private String roomNumber;
    private String type;
    private int capacity;
    private BigDecimal pricePerNight;
    private String status;
    private String description;
    private List<RoomImage> images = new ArrayList<>();

    public List<RoomImage> getImages() {
        return images;
    }

    public void setImages(List<RoomImage> images) {
        this.images = images;
    }

    public int getId() { return id; }
    public String getRoomNumber() { return roomNumber; }
    public String getType() { return type; }
    public int getCapacity() { return capacity; }
    public BigDecimal getPricePerNight() { return pricePerNight; }
    public String getStatus() { return status; }
    public String getDescription() { return description; }


    public void setId(int id) { this.id = id; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public void setType(String type) { this.type = type; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public void setPricePerNight(BigDecimal pricePerNight) { this.pricePerNight = pricePerNight; }
    public void setStatus(String status) { this.status = status; }
    public void setDescription(String description) { this.description = description; }
}
