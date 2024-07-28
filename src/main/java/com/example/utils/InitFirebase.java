package com.example.utils;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import java.io.FileInputStream;
import java.io.IOException;

public class InitFirebase {
    public static void initialize() throws IOException {
        FileInputStream serviceAccount = new FileInputStream("C:\\Users\\hp\\Desktop\\EXHANGE2\\src\\main\\java\\com\\example\\utils\\exchange-a72f2-firebase-adminsdk-jk9ui-fe01038449.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setStorageBucket("exchange-a72f2.appspot.com")
                .build();

        FirebaseApp.initializeApp(options);
    }
    public static Storage getStorage() {
        return StorageOptions.getDefaultInstance().getService();
    }
}