package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DepartDao;
import dao.DepartDaoImpl;
import model.Department;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class GenerateJsonFileServlet extends HttpServlet {

    private final int ARBITARY_SIZE = 1048;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DepartDao departDao = new DepartDaoImpl();
        List<Department> subjectList = departDao.listDepartment();
        ObjectMapper objectMapper = new ObjectMapper();
        String json = "";
        try {
            json = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(subjectList);
            System.out.println(json);
        } catch(Exception e) {
            e.printStackTrace();
        }

        resp.setContentType("text/plain");
        resp.setHeader("Content-disposition", "attachment; filename=report.json");

        try(InputStream targetStream = new ByteArrayInputStream(json.getBytes(StandardCharsets.UTF_8));
            OutputStream out = resp.getOutputStream()) {

            byte[] buffer = new byte[ARBITARY_SIZE];

            int numBytesRead;
            while ((numBytesRead = targetStream.read(buffer)) > 0) {
                out.write(buffer, 0, numBytesRead);
            }
        }

        resp.sendRedirect("/departs");
    }
}
