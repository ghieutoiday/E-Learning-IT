package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.AtomicReference;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    private static DBContext instance;
    protected Connection connection;
    private final AtomicReference<Connection> internalConnection = new AtomicReference<>();
    private final AtomicLong lastUsed = new AtomicLong(System.currentTimeMillis());
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private static final long IDLE_TIMEOUT_MS = 30000; // 30 giây

    public DBContext() {
        try {
            Connection conn = createConnection();
            internalConnection.set(conn);
            connection = conn;
        } catch (SQLException e) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to initialize connection", e);
        }
    }

    public static synchronized DBContext getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBContext();
            if (instance.connection == null) {
                throw new SQLException("Failed to initialize DBContext");
            }
            instance.startIdleCheck();
        }
        return instance;
    }

    private Connection createConnection() throws SQLException {
        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://DESKTOP-QCADS1N:1433;databaseName=CourseManagementDB;sendStringParametersAsUnicode=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public synchronized Connection getConnection() throws SQLException {
        lastUsed.set(System.currentTimeMillis());
        Connection conn = internalConnection.get();
        if (conn == null || conn.isClosed()) {
            conn = createConnection();
            internalConnection.set(conn);
            connection = conn;
        }
        return conn;
    }

    public void closeConnection() {
        Connection conn = internalConnection.get();
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
                internalConnection.set(null);
                connection = null;
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }

    private void startIdleCheck() {
        scheduler.scheduleAtFixedRate(() -> {
            try {
                synchronized (this) {
                    Connection conn = internalConnection.get();
                    if (conn != null && !conn.isClosed() &&
                        System.currentTimeMillis() - lastUsed.get() > IDLE_TIMEOUT_MS) {
                        try {
                            conn.close();
                            internalConnection.set(null);
                            connection = null;
                        } catch (SQLException e) {
                            System.err.println("Error closing idle connection: " + e.getMessage());
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("Error in idle check: " + e.getMessage());
            }
        }, IDLE_TIMEOUT_MS, IDLE_TIMEOUT_MS, TimeUnit.MILLISECONDS);
    }

    public void shutdown() {
        scheduler.shutdown();
        closeConnection();
    }
}