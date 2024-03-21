<%@page import="java.util.List"%>

<%@page import="java.time.LocalDate"%>
<%@page import="model.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Registration</title>
</head>
<body>
<%
	StudentDao studentService = new StudentDao();
	List<Student> students = studentService.getAllStudents();
	
	SemesterDao semesterService = new SemesterDao();
	List<Semester> semesters = semesterService.getAllSemesters();
%>

	
	<h1 class="text-center">Create Student Registration</h1>
	<form  id="registrationForm" method="POST">
		<div class="form-row align-items-center">
			<div class="form-group col-md-4 p-3">
				<label for="id">Registration Id</label> <input type="text"
					class="form-control" name="id" id="id">
			</div>
			<div class="form-group col-md-4 p-3">
				<label for="regDate">Registration Date</label> <input type="date"
					class="form-control" id="regDate" name="regDate">
			</div>
			<div class="form-group col-md-4 p-3">
				<label for="student">Choose Student</label> 
				<select name="student" id="student" class="form-control">
					<option value="none">-- Select Student --</option>
					<%
						for(Student student : students){
					%>
					<option value= <%= student.getRegNo() %> > <%= student.getName() %> </option>
					<% } %>
				</select>
			</div>
			<div class="form-group col-md-4 p-3">
				<label for="semester">Choose Semester</label> 
				<select name="semester" id="semester" class="form-control">
					<option value="none">-- Select Semester --</option>
					<%
						for(Semester semester : semesters){
					%>
					<option value= <%= semester.getSemId() %> > <%= semester.getSemName() %> </option>
					<% } %>
				</select>
			</div>
		</div>
		<button type="submit" class="btn btn-primary ms-3">Create Registration</button>
	</form>
</body>
</html>

<%
	if("POST".equals(request.getMethod())){
		String regId = request.getParameter("id");
		
		String regDate = request.getParameter("regDate");
		LocalDate date = LocalDate.parse(regDate);
		
		String studentCode = request.getParameter("student");
		String semCode = request.getParameter("semester");
		
		Student student = studentService.findById(studentCode);
		
		Semester semester = semesterService.findById(semCode);
		
		StudentRegistration registration = new StudentRegistration();
		registration.setRegId(regId);
		registration.setRegDate(date);
		registration.setSemester(semester);
		registration.setStudent(student);
		
		StudentRegistrationDao regService = new StudentRegistrationDao();
		regService.registerStudentRegistration(registration);
		
		response.sendRedirect("displayStudents.jsp");
	}
%>
















