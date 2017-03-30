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
		int mod_ssn = Integer.parseInt(request.getParameter("mod_ssn"));

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select Name,Apt,Street,State,City,Zip from customer where ssn=" + mod_ssn);

		String name = null, apt = null, street = null, state = null, city = null, zip = null;
		if (rs.next()) {
			name = rs.getString("Name");
			apt = rs.getString("Apt");
			street = rs.getString("Street");
			state = rs.getString("State");
			city = rs.getString("City");
			zip = rs.getString("Zip");
		}
				
	%>
	<form action='cumo.jsp' method=post onsubmit="return myFunction()">
		<input type = "hidden" name ="ssn" value =<%=mod_ssn%> >
		Name: <input type="text" name="name1" value ="<%=name%>" id="name"><br>
		Apt#: <input type="text" name="apt1" value ="<%=apt%>" id="apt"><br>
		Street: <input type="text" name="street1" value ="<%=street%>" id="street"><br>
		State: <input type="text" name="state1" value ="<%=state%>" id="state"><br>
		City: <input type="text" name="city1" value ="<%=city%>" id="city"><br>
		Zip: <input type="text" name="zip1" value ="<%=zip%>" id="zip"><br>

		<input type="submit" value="Save" />
	</form>
	<script>
function myFunction() {
    var name = document.getElementById("name").value;
    var apt = document.getElementById("apt").value;
    var street = document.getElementById("street").value;
    var state = document.getElementById("state").value;
    var city = document.getElementById("city").value;
    var zip = document.getElementById("zip").value;
 
}
</script>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>