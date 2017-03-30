<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Transaction</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<form action="custwd.jsp" method=post>
		<input type="submit" value="Customer Withdraw" />
	</form>
	<br>
	<form action="custdep.jsp" method=post>
		<input type="submit" value="Customer Deposit" />
	</form>
	<br>
	<form action="custmoneytrans.jsp" method=post>
		<input type="submit" value="Money Transfer" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>