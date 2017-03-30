<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Add</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		int depssn = 0;
		String depname = "";
		String name = request.getParameter("name");
		int ssn = Integer.parseInt(request.getParameter("ssn"));
		String userid = request.getParameter("userid");
		String pass = request.getParameter("pass");
		String phone = request.getParameter("phone");
		int mgrssn = Integer.parseInt(request.getParameter("mgrssn"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		if (!request.getParameter("depssn").equals("")) {
			depssn = Integer.parseInt(request.getParameter("depssn"));
			depname = request.getParameter("depname");
		}
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		String query = " insert into bankemployee (empssn, empname, empuserid, emppwd, empphone,empmgrssn,bno)"
				+ " values (?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement preparedStmt = con.prepareStatement(query);
		preparedStmt.setInt(1, ssn);
		preparedStmt.setString(2, name);
		preparedStmt.setString(3, userid);
		preparedStmt.setString(4, pass);
		preparedStmt.setString(5, phone);
		preparedStmt.setInt(6, mgrssn);
		preparedStmt.setInt(7, bno);
		preparedStmt.execute();
		if (depssn != 0 || !depname.equals("")) {
			String query1 = " insert into empdependents (depssn,depname,empssn) values (?, ?, ?)";
			PreparedStatement preparedStmt1 = con.prepareStatement(query1);
			preparedStmt1.setInt(1, depssn);
			preparedStmt1.setString(2, depname);
			preparedStmt1.setInt(3, ssn);
			preparedStmt1.execute();
		}
		con.close();
	%>
	The Employee has been created successfully.

	<br>
	<br>
	<a href="emp.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>