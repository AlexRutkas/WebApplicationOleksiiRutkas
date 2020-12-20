package filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;

public class CharsetFilter implements Filter {

    private String encoding;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        encoding = "UTF-8";
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        servletResponse.setContentType("text/html; charset=UTF-8");
        servletRequest.setCharacterEncoding(encoding);
        System.out.println("" + new Date() + "In charset filter " + ((HttpServletRequest)servletRequest).getParameter("depart"));
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
