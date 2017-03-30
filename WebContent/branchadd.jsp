<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Branch Add</title>

</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Enter Branch Details</h4>

	<form action='branchaddition.jsp' method=post >
	Bno: <input type = "text" name="bno"/> <br>
		 Branch Name:   <input type="text" name="name" /><br> 
		 City: <input type="text" name="city" /><br> 
		 Assets: <input type="text" name="assets" /><br> 
		  <br>

		<input  type="submit" value="Add Branch" />
	</form>
	<br>
	<br>
	<a href="emp.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>