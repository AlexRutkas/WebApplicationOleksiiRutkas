package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LanguageSelector extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cookieLocale = req.getParameter("cookieLocale");
        if (cookieLocale != null) {
            Cookie cookie = new Cookie("lang", cookieLocale);
            cookie.setMaxAge(24 * 60 * 60);
            resp.addCookie(cookie);
        }
        resp.sendRedirect("/departs");
    }
}
