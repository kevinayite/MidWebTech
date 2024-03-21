package academicUnit;

import java.io.IOException;
import java.io.PrintWriter;

import dao.AcademicUnitDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet(urlPatterns = "/Student/deleteUnit")
public class DeleteAcademic extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String unitId = request.getParameter("code"); // Assuming you're passing an ID to identify the unit to be deleted
        
        if(unitId != null ) {
        AcademicUnitDao unitDao = new AcademicUnitDao();
         unitDao.deleteAcademic(unitId);
        
         
 			
 			
 			
 			response.sendRedirect("displayAcademic.jsp");
 		}else {
 			PrintWriter out = response.getWriter();
 			out.println("Fill each fields");
 		}
    }

}
