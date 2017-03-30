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
		int acct = Integer.parseInt(request.getParameter("wd_acct"));
		double amt = Double.parseDouble(request.getParameter("amt"));
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select balance from account where acctnum = " + acct);
		Double aamt =0.0;
		while (rs.next()) {
			aamt = rs.getDouble("balance");
			if (rs.getInt("balance") > amt) {
				
				Double tamt = rs.getInt("balance") - amt;
				
				String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
				PreparedStatement ps1 = con.prepareStatement(query1);
				ps1.setInt(1, acct);
				ps1.setString(2, "WD");
				ps1.setDouble(3, amt);
				ps1.setDouble(4, tamt);
				ps1.execute();

				String query = " update account set balance = ? where acctnum = " + acct;
				PreparedStatement ps = con.prepareStatement(query);

				ps.setDouble(1, tamt);
				ps.execute();
	%>
	Please collect the cash!
	<%
		} else {
			String query2 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values (?,?,?,?) ";
			PreparedStatement ps1 = con.prepareStatement(query2);
			ps1.setInt(1, acct);
			ps1.setString(2, "SC");
			ps1.setDouble(3, 5.0);
			ps1.setDouble(4, (aamt-5.0));
			ps1.execute();

			String query3 = " update account set balance = ? where acctnum = " + acct;
			PreparedStatement ps = con.prepareStatement(query3);

			ps.setDouble(1, (aamt-5.0));
			ps.execute();
			
	%>
	Sorry Insufficient Balance!
	<%
		}
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