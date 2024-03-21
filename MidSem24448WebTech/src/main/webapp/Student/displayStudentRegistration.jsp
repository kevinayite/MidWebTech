<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="dao.StudentRegistrationDao"%>
<%@page import="model.StudentRegistration"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Academic Units</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            margin-top: 50px;
        }
        .table {
            background-color: #ffffff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
    <%
    StudentRegistrationDao dao = new StudentRegistrationDao();
    List<StudentRegistration> unit = dao.getAllStudentRegistration();
    %>

    <div class="container">
        <h1 class="text-center mb-4">Academic Units</h1>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                    <th>Unit Code</th>
                        <th>Student Registration ID</th>
                        <th> Registration Date</th>
                        <th>Program</th>
                        <th>Faculty</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (StudentRegistration studReg : studRegs) { %>
                    <tr>
                   		 <td><%= studReg.getRegId() %></td>
                        <td><%= studReg.getRegDate() %></td>
                        <td><%= studReg.getSemester().getSemName() %></td>
                        <td><%= studReg.getStudent().getName() %></td>
                        
                        
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="form-group text-center">
                <button type="submit" class="btn btn-primary px-5" > <a href="RegisterAcademicUnit.jsp" style="text-decoration: none; color: inherit;">Previous Page</a></button>
                </div>
    </div>
</body>
</html>