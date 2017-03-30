<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Delete Account</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		int acct = Integer.parseInt(request.getParameter("acct"));

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		Statement st = con.createStatement();
		ResultSet rs1 = st.executeQuery("select acctnum from loan  where acctnum = "+acct);
		while (rs1.next()) {
			String query3 = " delete from loan where acctnum = ?";
			PreparedStatement preparedStmt3 = con.prepareStatement(query3);
			preparedStmt3.setInt(1, rs1.getInt("acctnum"));
			preparedStmt3.execute();
		}
		ResultSet rs2 = st.executeQuery("select acctnum from deposit  where acctnum = "+acct);
		while (rs2.next()) {
			String query3 = " delete from deposit where acctnum = ?";
			PreparedStatement preparedStmt3 = con.prepareStatement(query3);
			preparedStmt3.setInt(1, rs2.getInt("acctnum"));
			preparedStmt3.execute();
		}
		ResultSet rs3 = st.executeQuery("select accnum from TransactionInstance  where accnum = "+acct);
		while (rs3.next()) {
			String query3 = " delete from TransactionInstance where accnum = ?";
			PreparedStatement preparedStmt3 = con.prepareStatement(query3);
			preparedStmt3.setInt(1, rs3.getInt("accnum"));
			preparedStmt3.execute();
		}
		ResultSet rs = st.executeQuery("select acc.customerssn,cus.name from CustomerAcc acc,customer cus where acctnum = "+ acct + " and cus.ssn = acc.customerssn");
		int custssn = 0;
		String custname = "";
		while (rs.next()) {
			custssn = rs.getInt("customerssn");
			custname = rs.getString("name");
		}
		String query3 = " delete from CustomerAcc where acctnum = ?";

		PreparedStatement preparedStmt3 = con.prepareStatement(query3);
		preparedStmt3.setInt(1, acct);
		preparedStmt3.execute();

		String query2 = "delete from account where acctnum = ?";
		PreparedStatement preparedStmt2 = con.prepareStatement(query2);
		preparedStmt2.setInt(1, acct);
		preparedStmt2.execute();

		ResultSet rs4 = st.executeQuery("select * from Customer where ssn = " + custssn);
		int count = 0;
		while (rs4.next()) {
			count++;
		}
		if (count == 1) {
			String query = "delete from bankercustomer where customerssn = ?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			preparedStmt.setInt(1, custssn);
			preparedStmt.execute();

			String query1 = "delete from customer where ssn = ?";
			PreparedStatement preparedStmt1 = con.prepareStatement(query1);
			preparedStmt1.setInt(1, custssn);
			preparedStmt1.execute();
	%>
	The customer
	<%=custname%>
	has been deleted due to account closure.
	<br>
	<%
		}

		con.close();
	%>
	The account
	<%=acct%>
	has been deleted successfully.
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>