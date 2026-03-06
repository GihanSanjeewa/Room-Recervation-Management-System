package com.hotel.controller;

import com.hotel.service.AIService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/help")
public class HelpController extends HttpServlet {

    private AIService aiService;

    @Override
    public void init() throws ServletException {
        aiService = new AIService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String question = request.getParameter("question");

        if (question == null || question.trim().isEmpty()) {
            response.getWriter().write("Please enter a valid question.");
            return;
        }

        try {
            String answer = aiService.getHelpResponse(question.trim());
            response.getWriter().write(answer);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Sorry, I could not process your request right now.");
        }
    }
}