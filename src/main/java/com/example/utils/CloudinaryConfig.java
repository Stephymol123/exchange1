package com.example.utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import io.github.cdimascio.dotenv.Dotenv;

import java.util.Map;

public class CloudinaryConfig {

    private static final Cloudinary cloudinary;

    static {
        // Load environment variables from .env file
        Dotenv dotenv = Dotenv.load();

        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", dotenv.get("CLOUDINARY_CLOUD_NAME"),
                "api_key", dotenv.get("CLOUDINARY_API_KEY"),
                "api_secret", dotenv.get("CLOUDINARY_API_SECRET")
        ));
    }

    public static Cloudinary getCloudinary() {
        return cloudinary;
    }
    public static String uploadImage(byte[] imageBytes, String fileName) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(imageBytes, ObjectUtils.asMap(
                "public_id", fileName,
                "folder", "uploads/"
        ));
        return uploadResult.get("secure_url").toString();
    }
}