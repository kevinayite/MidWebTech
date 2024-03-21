<%@page import="model.*"%>
<%@page import="java.util.List"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AUCA Students</title>
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
    StudentDao studentService = new StudentDao();
    List<Student> students = studentService.getAllStudents();
    %>

    <div class="container">
        <h1 class="text-center mb-4">AUCA Students</h1>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Student Name</th>
                        <th>Student Code</th>
                        <th>Date of Birth</th>
                        
                        <th>Faculty</th>
                        <th>Department</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Student student : students) { %>
                    <tr>
                        <td><%= student.getName() %></td>
                        <td><%= student.getRegNo() %></td>
                        <td><%= student.getDateOfBirth() %></td>
                        
                        <td><%= student.getDepartment().getFaculty().getName() %></td>
                        <td><%= student.getDepartment().getName() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="form-group text-center">
                <button type="submit" class="btn btn-primary px-5" > <a href="RegisterStudent.jsp" style="text-decoration: none; color: inherit;">Previous Page</a></button>
                </div>
    </div>
</body>
</html>