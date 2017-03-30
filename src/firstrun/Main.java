package firstrun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ParameterMetaData;

public class Main {
  public static void main(String[] args) throws Exception {
    Connection conn = getMySqlConnection();

    String simpleProc = "{ call simpleproc(?) }";
    CallableStatement cs = conn.prepareCall(simpleProc);
    cs.registerOutParameter(1, java.sql.Types.INTEGER);
    cs.execute();
    int param1 = cs.getInt(1);
    System.out.println("param1=" + param1);

   
    conn.close();
  }



  public static Connection getMySqlConnection() throws Exception {
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/sys";
    String username = "root";
    String password = "oracle";

    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    return conn;
  }


}
