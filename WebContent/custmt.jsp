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
	int flag = 1;
		int facct = Integer.parseInt(request.getParameter("wd_acct"));
	int tacct = Integer.parseInt(request.getParameter("cd_acct"));
		double amt = Double.parseDouble(request.getParameter("amt"));
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select balance from account where acctnum = " + facct);
		while (rs.next()) {
			if (rs.getInt("balance") > amt) {
				Double tamt = rs.getInt("balance") - amt;
				
				String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
				PreparedStatement ps1 = con.prepareStatement(query1);
				ps1.setInt(1, facct);
				ps1.setString(2, "WD");
				ps1.setDouble(3, amt);
				ps1.setDouble(4, tamt);
				ps1.execute();

				String query = " update account set balance = ? where acctnum = " + facct;
				PreparedStatement ps = con.prepareStatement(query);

				ps.setDouble(1, tamt);
				ps.execute();
	
		} else {
			flag=0;
	%>
	Sorry Insufficient Balance!
	<%
		}
		}
		if(flag == 1){
		
		ResultSet rs1 = statement.executeQuery("select balance from account where acctnum = " + tacct);
		while (rs1.next()) {

			Double tamt = rs1.getInt("balance") + amt;

			String query1 = " insert into transactioninstance(Accnum,TransCode,TransactionAmt,CurBal) values(?,?,?,?) ";
			PreparedStatement ps1 = con.prepareStatement(query1);
			ps1.setInt(1, tacct);
			ps1.setString(2, "CD");
			ps1.setDouble(3, amt);
			ps1.setDouble(4, tamt);
			ps1.execute();

			String query = " update account set balance = ? where acctnum = " + tacct;
			PreparedStatement ps = con.prepareStatement(query);

			ps.setDouble(1, tamt);
			ps.execute();
	%>
	Withdrawal and Cash Deposit Successfull!
	<%
		}

		con.close();
		}
	%>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>