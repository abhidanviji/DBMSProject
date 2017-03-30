<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Add Account</title>
</head>
<h1>BEST BANK</h1>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>


	<%
		String ssn = request.getParameter("ssn");
		String type = request.getParameter("type");
		String bal = request.getParameter("bal");
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");

		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(
				"select * from bankemployee where EmpUserId='" + session.getAttribute("userid") + "'");
		int empssn = 0, bno = 0;
		if (rs.next()) {
			empssn = rs.getInt("EmpSSN");
			bno = rs.getInt("bno");
		}

		String query2 = " insert into account (Balance,AcctType,BNo)" + " values (?, ?, ?)";
		PreparedStatement preparedStmt2 = con.prepareStatement(query2);
		preparedStmt2.setDouble(1, Double.parseDouble(bal));
		preparedStmt2.setString(2, type);
		preparedStmt2.setInt(3, bno);
		preparedStmt2.execute();

		String simpleProc = "{ call simpleproc(?) }";
		CallableStatement cs = con.prepareCall(simpleProc);
		cs.registerOutParameter(1, java.sql.Types.INTEGER);
		cs.execute();
		int param1 = cs.getInt(1);
		System.out.println("param1=" + param1);
		rs = st.executeQuery("select sysdate() from dual");
		Date curdate = null;
		if (rs.next()) {
			curdate = rs.getDate(1);
		}
		String query3 = " insert into CustomerAcc (AcctNum,CustomerSSN,Date)" + " values (?, ?, ?)";

		PreparedStatement preparedStmt3 = con.prepareStatement(query3);
		preparedStmt3.setInt(1, param1);
		preparedStmt3.setInt(2, Integer.parseInt(ssn));
		preparedStmt3.setDate(3, curdate);

		preparedStmt3.execute();

		con.close();
	%>
	The account has been created successfully.<br>Account number : <%=param1%>
	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>