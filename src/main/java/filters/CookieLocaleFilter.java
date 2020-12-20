package filters;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

public class CookieLocaleFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpServletRequest request = (HttpServletRequest)servletRequest;

        String cookieLocale = request.getParameter("cookieLocale");
        if (cookieLocale != null) {
            Cookie cookie = new Cookie("lang", cookieLocale);
            cookie.setMaxAge(24 * 60 * 60);
            response.addCookie(cookie);
            response.setLocale(new Locale(cookieLocale));
        }
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
