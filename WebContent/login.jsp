<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		String userid = request.getParameter("id");
		session.setAttribute("userid", userid);
		String pwd = request.getParameter("pass");
		if (userid.equals("admin") || pwd.equals("admin")) {
			out.println("Welcome Admin");
	%><br><br>
	<a href="emp.html">Continue</a>
	<br>
	<a class=top href="index.html">Logout</a>
	<%
		}
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from bankemployee where EmpUserId='" + userid + "'");
		if (rs.next()) {
			if (rs.getString("EmpPwd").equals(pwd)) {
				out.println("Welcome " + rs.getString("EmpName"));
	%>
	<br>
	<br>
	<a href="employee.html">Continue</a>
	<br>
	<a class=top href="index.html">Logout</a>
	<%
		} else {
				out.println("Invalid Username or Password");
	%><br>
	<br>
	<a href="index.html">Try Again</a>
	<%
		}
		} else {
			if (!userid.equals("admin")) {
				out.println("Invalid Username or Password");
	%><br>
	<br>
	<a href="index.html">Try Again</a>
	<%
		}
		}
	%>

</body>
</html>