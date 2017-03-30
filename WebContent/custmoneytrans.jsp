<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Deposit</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Select Customer Account# from which and Account# to which the transfer has to be made </h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select acctnum from account");
		
	%>

	<form action='custmt.jsp' method=post>
		AcctNumFrom:<br> <select name="wd_acct">

			<%
				while (rs.next()) {
			%>
			<option><%=rs.getInt("acctnum")%></option>
			<%
				}
			%>
			
		</select> 
		<br>
		AcctNumTo: <br><select name="cd_acct">

			<%
			ResultSet rs1 = statement.executeQuery("select acctnum from account");
				while (rs1.next()) {
			%>
			<option><%=rs1.getInt("acctnum")%></option>
			<%
				}
			%>
			
		</select> <br>
		Amount:<input type = "text" name = "amt" />
		<br> <br> <input type="submit" value="Deposit" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>