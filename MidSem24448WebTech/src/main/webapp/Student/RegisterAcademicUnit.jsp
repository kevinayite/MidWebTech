<%@page import="dao.AcademicUnitDao"%>
<%@page import="model.AcademicUnit"%>
<%@page import="java.util.*"%>
<%@page import="model.EAcademicUnit"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    // Assuming EAcademicUnit is an enum
    EAcademicUnit[] academicUnits = EAcademicUnit.values();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Academic Unit Registration</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        max-width: 800px;
        margin-top: 50px;
    }
    .form-group label {
        font-weight: 500;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="card shadow-sm">
            <div class="card-body">
                <h1 class="text-center mb-4">Academic Unit Registration</h1>
                <form action="saveAcademicUnit.jsp" id="academicUnitForm" method="POST">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="name">Unit Name</label>
                            <input type="text" class="form-control" name="name" id="name" >
                        </div>
                        <div class="form-group col-md-6">
                            <label for="code">Unit Code</label>
                            <input type="text" class="form-control" id="code" name="code" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>Academic Unit Type</label>
                            <select name="unitType" class="form-control" id="unitType" >
                                <option value="none">-- Select Unit Type --</option>
                                <%-- <c:forEach items="${EAcademicUnit.values()}" var="unitType">
                                    <option value="${unitType}">${unitType.getLabel()}</option>
                                </c:forEach> --%>
                                <% for (EAcademicUnit unitType : academicUnits) { %>
                <option value="<%= unitType.name() %>"><%= unitType.getLabel() %></option>
            <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6 divHide" id="FACULTY" style="display: none;">
                            <label for="prog">Program Name</label>
                            <select name="prog" id="prog" class="form-control">
                                <option value="none">-- Select Program --</option>
                                <%
                                AcademicUnitDao dao = new AcademicUnitDao();
                                List<AcademicUnit> programs = dao.findByUnitType("PROGRAM");
                                for(AcademicUnit program : programs){
                                %>
                                <option value="<%= program.getCode() %>"><%= program.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group col-md-6 divHide" id="DEPARTMENT" style="display: none;">
                            <label for="dept">Faculty Name</label>
                            <select name="dept" id="dept" class="form-control">
                                <option value="none">-- Select Faculty --</option>
                                <%
                                List<AcademicUnit> faculties = dao.findByUnitType("FACULTY");
                                for(AcademicUnit faculty : faculties){
                                %>
                                <option value="<%= faculty.getCode() %>"><%= faculty.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6 divHide" id="DEFAULT" style="display: none;"></div>
                    </div>
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary px-5">Save Unit</button>
                        <button type="submit" class="btn btn-primary px-5">Update Unit</button>
                        <button type="submit" class="btn btn-primary px-5" formaction="deleteUnit">Delete Unit</button>
                        
                        <!-- <button type="button" onclick="window.location.href='displayAcademic.jsp';" class="btn btn-primary px-5">Display Unit</button> -->
                        
                    </div>
                </form>
                <div class="form-group text-center">
                <button type="submit" class="btn btn-primary px-5" > <a href="displayAcademic.jsp" style="text-decoration: none; color: inherit;">Display Unit</a></button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const unitTypeSelect = document.getElementById("unitType");
        unitTypeSelect.addEventListener("change", function () {
            const divs = document.querySelectorAll("div[class$='divHide']");
            divs.forEach(function (div) {
                div.style.display = "none";
            });

            const selectedUnitType = unitTypeSelect.value;
            let selectedDiv;

            if(String(selectedUnitType) === "PROGRAM"){
                selectedDiv = document.getElementById("DEFAULT");
                selectedDiv.style.display = "inline";
            } else {
                selectedDiv = document.getElementById(String(selectedUnitType));
            }

            selectedDiv.style.display = "block";
        });
    </script>
</body>
</html>