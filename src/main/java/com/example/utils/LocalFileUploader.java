package com.example.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class LocalFileUploader {
    private String uploadDir;

    public LocalFileUploader(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public String uploadFile(InputStream fileInputStream, String fileName) throws IOException {
        File file = new File(uploadDir, fileName);
        try (FileOutputStream outputStream = new FileOutputStream(file)) {
            int read;
            byte[] bytes = new byte[1024];
            while ((read = fileInputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }
        return file.getAbsolutePath();
    }
}

