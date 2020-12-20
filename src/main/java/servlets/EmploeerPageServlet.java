package servlets;

import dao.EmploeerDao;
import dao.EmploeerDaoImpl;
import model.Emploeer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;

public class EmploeerPageServlet extends HttpServlet {

    private final int SPP = 3;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Emploeer> emploeerList;
        EmploeerDao EmploeerDao = new EmploeerDaoImpl();
        int recordsCount = EmploeerDao.getRecordsCount();
        int pages = recordsCount / SPP;
        if (recordsCount % SPP != 0)
            pages++;
        req.setAttribute("pages", pages);

        if (req.getParameter("page") != null) {
            int page = Integer.parseInt(req.getParameter("page"));
            if(page!=0) emploeerList = EmploeerDao.getPageEmploeers(page, SPP);
             else emploeerList = EmploeerDao.getAllEmploeers();
        }
        else    emploeerList = EmploeerDao.getAllEmploeers();


        req.setAttribute("emploeerList", emploeerList);


        RequestDispatcher dispatcher = req.getRequestDispatcher("/pages/emploeers.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Emploeer> emploeerList;
        EmploeerDao emploeerDao = new EmploeerDaoImpl();
        int recordsCount = emploeerDao.getRecordsCount();
        int pages = recordsCount / SPP;
        if (recordsCount % SPP != 0)
            pages++;
        req.setAttribute("pages", pages);

        if (req.getParameter("page") != null) {
            int page = Integer.parseInt(req.getParameter("page"));
            if(page!=0) emploeerList = emploeerDao.getPageEmploeers(page, SPP);
            else emploeerList = emploeerDao.getAllEmploeers();
        }
        else    emploeerList = emploeerDao.getAllEmploeers();

        req.setAttribute("emploeerList", emploeerList);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/pages/emploeers.jsp");
        dispatcher.forward(req, resp);
    }
}
