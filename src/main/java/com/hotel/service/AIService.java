package com.hotel.service;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class AIService {

    // Better to move this to environment variable or config file
    private static final String API_KEY = "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";
    private static final String API_URL = "https://api.anthropic.com/v1/messages";

    public String getHelpResponse(String userQuestion) throws IOException {
        String systemPrompt =
                "You are a hotel reservation help assistant for a luxury hotel website. " +
                "Only answer questions related to room booking, reservations, payments, check-in, check-out, " +
                "cancellations, room types, and hotel stay support. " +
                "If the user asks something unrelated, politely say that you can only help with hotel reservation topics. " +
                "Keep answers clear, short, and professional.";

        JSONObject requestBody = new JSONObject();
        requestBody.put("model", "claude-sonnet-4-5");
        requestBody.put("max_tokens", 400);
        requestBody.put("system", systemPrompt);

        JSONArray messages = new JSONArray();
        JSONObject userMessage = new JSONObject();
        userMessage.put("role", "user");
        userMessage.put("content", userQuestion);
        messages.put(userMessage);

        requestBody.put("messages", messages);

        URL url = new URL(API_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("x-api-key", API_KEY);
        connection.setRequestProperty("anthropic-version", "2023-06-01");
        connection.setDoOutput(true);

        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = connection.getResponseCode();

        BufferedReader reader;
        if (responseCode >= 200 && responseCode < 300) {
            reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8)
            );
        } else {
            reader = new BufferedReader(
                    new InputStreamReader(connection.getErrorStream(), StandardCharsets.UTF_8)
            );
        }

        StringBuilder responseBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            responseBuilder.append(line);
        }

        String rawResponse = responseBuilder.toString();

        if (responseCode >= 200 && responseCode < 300) {
            return extractClaudeText(rawResponse);
        } else {
            return "Claude API error: " + rawResponse;
        }
    }

    private String extractClaudeText(String jsonResponse) {
        JSONObject jsonObject = new JSONObject(jsonResponse);
        JSONArray contentArray = jsonObject.getJSONArray("content");

        StringBuilder finalText = new StringBuilder();

        for (int i = 0; i < contentArray.length(); i++) {
            JSONObject block = contentArray.getJSONObject(i);
            if ("text".equals(block.optString("type"))) {
                finalText.append(block.optString("text")).append("\n");
            }
        }

        return finalText.toString().trim();
    }
}