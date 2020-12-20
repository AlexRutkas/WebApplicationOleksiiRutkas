package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UserAuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String user = (String)session.getAttribute("current_user");
        RequestDispatcher dispatcher;
        dispatcher = req.getRequestDispatcher("/jsp");
        if (user == null) {
            String username = req.getParameter("username");
            if (username != null) {
                session.setAttribute("current_user", username);
                dispatcher.forward(req, resp);
            }
            resp.sendRedirect("pages/login.jsp");
        } else {
            dispatcher.forward(req, resp);
        }
    }
}
