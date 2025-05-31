package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set the context path as an attribute so we can use it in JSP
        request.setAttribute("contextPath", request.getContextPath());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/test.jsp");
        dispatcher.forward(request, response);
    }
}
