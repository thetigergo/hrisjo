package gov.hrisjo;


import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;

public class PgDBcon {
    private final static HikariDataSource dataSource;
    
    private static final String SERVER = System.getProperty("SERVER");

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://" + SERVER + ":54321/joborders");
        config.setUsername(Gate.PGSQL.salt());
        config.setPassword(Gate.PGPWD.salt());
        config.setMaximumPoolSize(1); // adjust as needed
//        config.addDataSourceProperty("ssl", "true"); // optional SSL

        dataSource = new HikariDataSource(config);
    }

    public static Connection dbLink() throws Exception {
        return dataSource.getConnection();
    }

    public static void shutdown() {
        if (dataSource != null) {
            if (!dataSource.isClosed()) dataSource.close(); // equivalent to pool.end()
        }
    }
}
