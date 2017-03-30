<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Loan Account</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		int acct = Integer.parseInt(request.getParameter("acct"));
		Double amt = Double.parseDouble(request.getParameter("amt"));
		int tenure = Integer.parseInt(request.getParameter("tenure"));
		Double interest = 0.0;

		if (tenure == 18 || tenure == 12) {
			interest = 0.38;
		} else {
			interest = 0.4;
		}
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select balance from account where acctnum = " + acct);
		Double balance = 0.0;

		while (rs.next()) {
			balance = rs.getDouble(1);
		}
		Double dueamt = (amt / tenure) * interest;

		Double newbal = balance + amt;

		String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
		PreparedStatement ps1 = con.prepareStatement(query1);
		ps1.setInt(1, acct);
		ps1.setString(2, "LD");
		ps1.setDouble(3, amt);
		ps1.setDouble(4, newbal);
		ps1.execute();

		String query3 = " update account set balance = ? where acctnum = ?";
		PreparedStatement preparedStmt3 = con.prepareStatement(query3);
		preparedStmt3.setDouble(1, newbal);
		preparedStmt3.setInt(2, acct);
		preparedStmt3.execute();

		String query2 = " insert into loan (acctnum,loanamt,dueamt,loaninterest,loantenure,loanstatus,pending)"
				+ " values (?, ?,?, ?,?,?,?)";
		PreparedStatement preparedStmt2 = con.prepareStatement(query2);
		preparedStmt2.setDouble(1, acct);
		preparedStmt2.setDouble(2, amt);
		preparedStmt2.setDouble(3, dueamt);
		preparedStmt2.setDouble(4, interest);
		preparedStmt2.setInt(5, tenure);
		preparedStmt2.setString(6, "Opened");
		preparedStmt2.setInt(7, tenure);
		preparedStmt2.execute();

		String simpleProc = "{ call simpleproc2(?) }";
		CallableStatement cs = con.prepareCall(simpleProc);
		cs.registerOutParameter(1, java.sql.Types.INTEGER);
		cs.execute();
		int param1 = cs.getInt(1);
		System.out.println("param1=" + param1);
		con.close();
	%>
	The loan account has been created successfully.
	<br>Loan Acc# :
	<%=param1%>
	<br>


	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>