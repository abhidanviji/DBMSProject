<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
	function validate() {
		var b = document.getElementById("b");
		var valid = true;
		if (b.value < 500) {
			alert("Account should be opened with a minimum balance of 500$");
			valid = false;
		}
		return valid;
	};
</script>
</head>
<body>
	<h1>BEST BANK</h1>
	<h4>Select Customer SSN for whom new account should be opened</h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select ssn from customer");
	%>
	<form action='customeracct.jsp' method=post
		onsubmit="return validate();">

		SSN: <select name="ssn">

			<%
				while (rs.next()) {
			%>
			<option><%=rs.getInt("ssn")%></option>
			<%
				}
			%>
		</select><br> Type Of Acct: <select name="type">
			<option value="Savings">Savings</option>
			<option value="Checking">Checking</option>
			<option value="Loan">Loan</option>

		</select><br> Amount: <input type="text" name="bal" id="b" /><br> <br>

		<input type="submit" value="Add" />
	</form>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>