package com.hotel.model;

public class RoomImage {
    private int id;
    private int roomId;
    private String imageUrl;
    private boolean cover;
    private int sortOrder;

    public int getId() { return id; }
    public int getRoomId() { return roomId; }
    public String getImageUrl() { return imageUrl; }
    public boolean isCover() { return cover; }
    public int getSortOrder() { return sortOrder; }

    public void setId(int id) { this.id = id; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setCover(boolean cover) { this.cover = cover; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
}
