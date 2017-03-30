<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Add</title>

</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Enter Employee Details</h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select bno from branch");
		
		
		%>
	<form action='empaddition.jsp' method=post >
	Bno: <select name="bno">

			<%
				while (rs.next()) {
			%>
			<option><%=rs.getInt("bno")%></option>
			<%
				}
			%>
		</select> <br>
		 Name:   <input type="text" name="name" /><br> 
		 SSN: <input type="text" name="ssn" /><br> 
		 UserID: <input type="text" name="userid" /><br> 
		 Password: <input type="password" name="pass" /><br>
		Phone: <input type="text" name="phone" /><br> 
		ManagerSSN: <input type="text" name="mgrssn" /><br> 
		DependentSSN: <input type="text" name="depssn" /><br>
		Dependent Name: <input type="text" name="depname" /><br> <br>

		<input  type="submit" value="Add Employee" />
	</form>
	<br>
	<br>
	<a href="emp.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>