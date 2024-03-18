package student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Student;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import dao.StudentDao;

/**
 * Servlet implementation class RegisterStudent
 */

@WebServlet(urlPatterns = "/Student/register")
public class RegisterStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String studId = request.getParameter("studentId");
		String nom = request.getParameter("name");
		String department = request.getParameter("department");
		String dob = request.getParameter("dob");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate dateOfBirth = LocalDate.parse(dob, formatter);
		
		
		if(studId != null && nom != null && dateOfBirth != null && department != null) {
			StudentDao studentSave = new StudentDao();
			//Student newStudent = new Student(studId, nom, dateOfBirth, department);
			Student newStudent = new Student();
			newStudent.setRegNo(studId);
			newStudent.setName(nom);
			newStudent.setDateOfBirth(dateOfBirth);
			studentSave.registerStudent(newStudent);
			
			response.sendRedirect("/User/login.html");
		}else {
			PrintWriter out = response.getWriter();
			out.println("Fill each fields");
		}
	}

}
