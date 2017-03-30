<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Withdrawal</title>
</head>
<body>
	<h1>BEST BANK</h1>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		int acct = Integer.parseInt(request.getParameter("cd_acct"));
		double amt = Double.parseDouble(request.getParameter("amt"));
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select balance from account where acctnum = " + acct);
		while (rs.next()) {

			Double tamt = rs.getInt("balance") + amt;

			String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
			PreparedStatement ps1 = con.prepareStatement(query1);
			ps1.setInt(1, acct);
			ps1.setString(2, "CD");
			ps1.setDouble(3, amt);
			ps1.setDouble(4, tamt);
			ps1.execute();

			String query = " update account set balance = ? where acctnum = " + acct;
			PreparedStatement ps = con.prepareStatement(query);

			ps.setDouble(1, tamt);
			ps.execute();
	%>
	Cash Deposit Successfull!
	<%
		}

		con.close();
	%>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>