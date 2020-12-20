package filters;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;


public class LoggingFilter implements Filter {

    private Logger logger;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger = Logger.getLogger(LoggingFilter.class);
        InputStream fileInputStream = LoggingFilter.class.getClassLoader().getResourceAsStream("log.properties");
        PropertyConfigurator.configure(fileInputStream);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) servletRequest;

        String servletPath = req.getServletPath();
        String remoteAddr = servletRequest.getRemoteAddr();

        String message = "Servlet path: " + servletPath + "; Call from : " + remoteAddr;

        logger.log(Level.INFO, message);
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
