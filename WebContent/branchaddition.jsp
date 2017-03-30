<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Branch Add</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		int bno = Integer.parseInt(request.getParameter("bno"));
		String name = request.getParameter("name");
		String city = request.getParameter("city");
		Double assets = Double.parseDouble(request.getParameter("assets"));

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		String query = " insert into branch (bno, bname, bcity, bassets)"
				+ " values (?, ?, ?, ?)";

		PreparedStatement preparedStmt = con.prepareStatement(query);
		preparedStmt.setInt(1, bno);
		preparedStmt.setString(2, name);
		preparedStmt.setString(3, city);
		preparedStmt.setDouble(4, assets);
		preparedStmt.execute();
		
		con.close();
	%>
	The Branch has been created successfully.

	<br>
	<br>
	<a href="emp.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>