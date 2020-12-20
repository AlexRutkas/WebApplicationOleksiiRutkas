package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class SessionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer counter = (Integer)session.getAttribute("counter");
        counter = (counter == null) ? 1 : ++counter;
        session.setAttribute("counter", counter);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/pages/counterPage.jsp?c="+counter);
        dispatcher.forward(req, resp);
    }
}
