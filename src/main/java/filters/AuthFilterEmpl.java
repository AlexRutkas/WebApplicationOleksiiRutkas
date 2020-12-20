package filters;
import dao.UserDao;
import dao.UserDaoImpl;
import model.Role;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilterEmpl implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        final HttpServletRequest req = (HttpServletRequest) servletRequest;
        final HttpServletResponse res = (HttpServletResponse) servletResponse;

        final String login = req.getParameter("login");
        final String password = req.getParameter("pwd");

        final HttpSession session = req.getSession();
        Role role;
        UserDao userDao = new UserDaoImpl();

        if (session != null &&
                session.getAttribute("login") != null &&
                session.getAttribute("password") != null) {

            role = (Role) session.getAttribute("role");

        } else if (userDao.isExist(login, password)) {

            role = userDao.getRoleByLoginPassword(login, password);

            req.getSession().setAttribute("password", password);
            req.getSession().setAttribute("login", login);
            req.getSession().setAttribute("role", role);
        } else {
            role = Role.DEFAULT;
        }
        moveToPage(req, res, role);

    }

    private void moveToPage(final HttpServletRequest req,
                            final HttpServletResponse res,
                            final Role role)
            throws ServletException, IOException {

        switch (role) {
            case ADMIN:
                 req.getRequestDispatcher("/emplos").forward(req, res);
                 break;
            case USER:
                req.getRequestDispatcher("/pages/departs_user.jsp").forward(req, res);
                break;
            default:
                req.getRequestDispatcher("/departs").forward(req, res);
        }
    }

    @Override
    public void destroy() {

    }
}
