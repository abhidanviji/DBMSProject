package firstrun;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyCon {
	public static final String URL = "jdbc:mysql://localhost:3306/sys";
	public static final String USER = "root";
	public static final String PASSWORD = "oracle";
	public static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";
	public static Statement stmt = null;
	public static ResultSet rs = null;
	public static Connection con = null;
	public static String name[];
	public static int count = 0;
	 
	public String[] newCon(){
		try {

			Class.forName(DRIVER_CLASS);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			stmt = con.createStatement();
			/*rs = stmt.executeQuery("SELECT * FROM test");
			while (rs.next()) {
				name[count] = rs.getString(1);
				count++;
				// System.out.println(rs.getInt(1));
				System.out.println(rs.getString(1));
			}*/
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return name;
	}
}
