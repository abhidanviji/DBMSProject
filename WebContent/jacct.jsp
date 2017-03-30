<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Joint Account</title>
</head>
<body>
<h1>BEST BANK</h1>
	<h4>Enter Customer Details</h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select acctnum from account");
	%>
	<form action='jacctadd.jsp' method=post>
		Name: <input type="text" name="name" /><br> SSN: <input
			type="text" name="ssn" id="a" /><br> Apt#: <input type="text"
			name="apt" /><br> Street: <input type="text" name="street" /><br>
		State: <input type="text" name="state" /><br> City: <input
			type="text" name="city" /><br> Zip: <input type="text"
			name="zip" /><br> 
			Acct: <select name="j_acct">

			<%
				while (rs.next()) {
			%>
			<option><%=rs.getInt("acctnum")%></option>
			<%
				}
			%>
			</select> <br>

		<input type="submit" value="Join Customer" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>