<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Delete</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Select Customer SSN you want to delete</h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select ssn from customer");
	%>

	<form action='custdel.jsp' method=post>
		SSN: <select name="del_ssn">

			<%
				while (rs.next()) {
			%>
			<option><%=rs.getInt("ssn")%></option>
			<%
				}
			%>
		</select> <br> <br> <input type="submit" value="Delete" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>

</body>
</html>