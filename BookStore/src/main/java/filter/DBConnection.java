package filter;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mariadb://localhost:3307/BookStoreJSP";
    private static final String USER = "root";
    private static final String PASSWORD = "070412Thu!";

    public static Connection getConnection() throws Exception {
    	Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
