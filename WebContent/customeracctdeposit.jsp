<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Account Deposit</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		int acct = Integer.parseInt(request.getParameter("acct"));
		String type = request.getParameter("type");
		Double amt = Double.parseDouble(request.getParameter("amt"));
		int tenure = Integer.parseInt(request.getParameter("tenure"));
		Double interest = 0.0;

		if (tenure == 9 || tenure == 12) {
			interest = 0.4;
		} else {
			interest = 0.38;
		}
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select balance from account where acctnum = " + acct);
		Double balance = 0.0;

		while (rs.next()) {
			balance = rs.getDouble(1);
		}
		if (balance > amt) {
			Double newbal = balance - amt;
			
			if(type.equals("Fixed")){
				String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
				PreparedStatement ps1 = con.prepareStatement(query1);
				ps1.setInt(1, acct);
				ps1.setString(2, "FW");
				ps1.setDouble(3, amt);
				ps1.setDouble(4, newbal);
				ps1.execute();
			}else if(type.equals("Reccuring")){
				String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
				PreparedStatement ps1 = con.prepareStatement(query1);
				ps1.setInt(1, acct);
				ps1.setString(2, "RW");
				ps1.setDouble(3, amt);
				ps1.setDouble(4, newbal);
				ps1.execute();
			}

			String query3 = " update account set balance = ? where acctnum = ?";
			PreparedStatement preparedStmt3 = con.prepareStatement(query3);
			preparedStmt3.setDouble(1, newbal);
			preparedStmt3.setInt(2, acct);
			preparedStmt3.execute();

			String query2 = " insert into deposit (acctnum,deptype,tenure,interest,amt,status)" + " values (?, ?, ?,?,?,?)";
			PreparedStatement preparedStmt2 = con.prepareStatement(query2);
			preparedStmt2.setDouble(1, acct);
			preparedStmt2.setString(2, type);
			preparedStmt2.setInt(3, tenure);
			preparedStmt2.setDouble(4, interest);
			preparedStmt2.setDouble(5, amt);
			preparedStmt2.setString(6, "Opened");
			preparedStmt2.execute();
			
			
			String simpleProc = "{ call simpleproc1(?) }";
			CallableStatement cs = con.prepareCall(simpleProc);
			cs.registerOutParameter(1, java.sql.Types.INTEGER);
			cs.execute();
			int param1 = cs.getInt(1);
			System.out.println("param1=" + param1);
			con.close();
	%>
	The deposit account has been created successfully.
	<br>Deposit Acc# :
	<%=param1%>
	<br>
	<%
		} else {
	%>
	Insufficient Balance. Can't open Deposit.
	<%
		}
	%>

	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>