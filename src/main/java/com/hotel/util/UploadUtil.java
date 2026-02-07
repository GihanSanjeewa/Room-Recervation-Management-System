package com.hotel.util;

import jakarta.servlet.ServletContext;
import java.nio.file.Path;
import java.nio.file.Paths;

public class UploadUtil {

    // Web-accessible relative folder
    public static String roomUploadRelative(int roomId) {
        return "/uploads/rooms/" + roomId;
    }

    // Physical folder on disk (inside webapp)
    public static Path roomUploadPhysical(ServletContext ctx, int roomId) {
        String rel = roomUploadRelative(roomId); // /uploads/rooms/1
        String realPath = ctx.getRealPath(rel);
        // realPath can be null in some deployments, fallback to user.home
        if (realPath == null) {
            realPath = System.getProperty("user.home") + "/HotelReservationUploads" + rel;
        }
        return Paths.get(realPath);
    }
}
