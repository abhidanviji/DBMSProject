<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Select Customer Acc# for whom new deposit account should be opened</h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs1 = statement.executeQuery("select acctnum from account");
	%>
	<form action='customeracctdeposit.jsp' method=post>

	Acc#: <select name="acct">

			<%
				while (rs1.next()) {
			%>
			<option><%=rs1.getInt("acctnum")%></option>
			<%
				}
			%>
		</select><br> 		
		Type Of Deposit: <select name="type">
			<option value="Fixed">Fixed</option>
			<option value="Recurring">Recurring</option>

		</select><br> Amount: <input type="text" name="amt"/><br>
		Tenure(in months): <select name="tenure">
		<option value="3">3</option>
			<option value="6">6</option>
			<option value="9">9</option>
			<option value="12">12</option>

		</select>
		<br> <br>

		<input type="submit" value="Create" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>