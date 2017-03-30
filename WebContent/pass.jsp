<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Passbook</title>
<style>
body {
	font-family: "Comic Sans MS";
	font-weight: bold;
	background-color: MediumSlateBlue;
}

tr:nth-of-type(odd) {
	background-color: greenyellow;
}

tr:nth-of-type(even) {
	background-color: white;
}

h1, h4,a {
	text-align: center;
	color:white;
}

.top {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}
</style>
</head>
<body>
	<h1>BEST BANK</h1>
	<h4>
		Passbook for Account#
		<%=request.getParameter("acct")%></h4>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		int flag = 1;
		int acct = Integer.parseInt(request.getParameter("acct"));
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "oracle");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(
				"select DATE_FORMAT(date, '%d-%b-%Y'),balance,name from customeracc c,account a,customer cust where c.acctnum = "
						+ acct + " and c.acctnum = a.acctnum and cust.ssn = c.customerssn");
		String acctdate = "";
		Double bal = 0.0;
		String name[] = new String[50];
		int count = 0;
		while (rs.next()) {
			acctdate = rs.getString(1);
			bal = rs.getDouble(2);
			name[count] = rs.getString(3);
	%>
	<h4>
		Owner :
		<%=name[count]%></h4>
	<%
		count++;

		}

		ResultSet result = statement.executeQuery(
				"select DATE_FORMAT(ti.TransactionDate, '%d-%b-%Y') Date,ti.transcode 'Transaction Code',t.transname 'Transaction Name',	IF(t.TransType = 'Debit', ti.TransactionAmt, '') Debit,IF(t.TransType = 'Credit', ti.TransactionAmt, '') Credit,ti.CurBal Balance from transactioninstance ti,transaction t	where ti.transcode = t.transcode and accnum = "
						+ acct + " order by transnum");
		out.println("<table align= CENTER BORDER=1 CELLPADDING=30 CELLSPACING=5 "
				+ "<tr bgcolor=white><th>DATE</th><th>TRANSACTION CODE</th><th>TRANSACTION NAME</th><th>DEBIT</th><th>CREDIT</th><th>BALANCE</th></tr>");

		if (!result.next()) {
			out.println("<tr><td><center>" + acctdate + "</center></td>" + "<td><center>" + " " + "</center></td>"
					+ "<td><center>" + "Balance Forward" + "</center></td>" + "<td><center>" + "" + "</center></td>"
					+ "<td><center>" + " " + "</center></td>" + "<td><center>" + bal + "</center></td></tr>");
		} else {
			do {
				Double fbal = 0.0;
				if (flag == 1) {
					if (result.getString(2).equals("CD") || result.getString(2).equals("MI")) {
						fbal = result.getDouble(6) - Double.parseDouble(result.getString(5));
					} else {
						fbal = result.getDouble(6) + Double.parseDouble(result.getString(4));
					}

					out.println("<tr><td><center>" + acctdate + "</center></td>" + "<td><center>" + " "
							+ "</center></td>" + "<td><center>" + "Balance Forward" + "</center></td>"
							+ "<td><center>" + "" + "</center></td>" + "<td><center>" + " " + "</center></td>"
							+ "<td><center>" + fbal + "</center></td></tr>");
					flag = 0;
				}
				out.println("<tr><td><center>" + result.getString(1) + "</center></td>" + "<td><center>"
						+ result.getString(2) + "</center></td>" + "<td><center>" + result.getString(3)
						+ "</center></td>" + "<td><center>" + result.getString(4) + "</center></td>"
						+ "<td><center>" + result.getString(5) + "</center></td>" + "<td><center>"
						+ result.getDouble(6) + "</center></td></tr>");
			} while (result.next());
		}
		out.println("</table>");
	%>

	<br>
	<br>
	<a href="employee.html">Main Page</a>
	<br>
	<a class=top href="index.html">Logout</a>
</body>
</html>