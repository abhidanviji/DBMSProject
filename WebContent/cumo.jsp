<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Detail Modification</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		String name = request.getParameter("name1");
		String ssn = request.getParameter("ssn");
		String apt = request.getParameter("apt1");
		String street = request.getParameter("street1");
		String state = request.getParameter("state1");
		String city = request.getParameter("city1");
		String zip = request.getParameter("zip1");

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		String query = " update customer set name = ?,apt = ?, street = ?, state = ?,city =?, zip = ? where ssn = "
				+ ssn;
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, name);
		ps.setString(2, apt);
		ps.setString(3, street);
		ps.setString(4, state);
		ps.setString(5, city);
		ps.setString(6, zip);
		ps.execute();

		con.close();
	%>
	Modified Successfully!
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>