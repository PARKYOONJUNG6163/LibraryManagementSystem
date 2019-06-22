package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import obj.Application;
import obj.Env;

public class ApplicationDAO {

	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Env env = new Env();
	public ApplicationDAO() {
	}

	private void connectDB() {
		this.jdbcUrl = "jdbc:mysql://localhost:3306/library";
		this.dbId = env.getEnvId();
		this.dbPass = env.getEnvPwd();

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void disConnectDB() {
		if (rs != null)
			try {
				rs.close();
			} catch (Exception e) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
	}
	
	public void insertApplication(Application app) {
		connectDB();
		String sql1 = "select count(*) from application";
		String sql2 = "insert into application values (?, ?, ?, ?, ?, ?, ?, ?)";
		String count="";

		try {
			pstmt = conn.prepareStatement(sql1);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count=String.valueOf(rs.getInt("count(*)")+1);
			}
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, count);
			pstmt.setString(2, app.getId());
			pstmt.setString(3, app.getBookName());
			pstmt.setString(4, app.getAuthor());
			pstmt.setString(5, app.getPublisher());
			pstmt.setString(6, app.getApplicationDate());
			pstmt.setString(7, "N");
			pstmt.setString(8, null);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
		}
		disConnectDB();
	}
	
	private Application createApplication(ResultSet rs) throws SQLException {
		Application app = new Application();
		app.setApplicationNo(Integer.parseInt(rs.getString("applicationNo")));
		app.setId(rs.getString("id"));
		app.setBookName(rs.getString("bookName"));
		app.setAuthor(rs.getString("author"));
		app.setPublisher(rs.getString("publisher"));
		app.setApplicationDate(rs.getString("applicationDate"));
		app.setAccept(rs.getString("accept"));
		app.setReason(rs.getString("reason"));
		return app;
	}
	
	public List<Application> getApplicationList(String id) {
		connectDB();
		String sql1 = "";
		List<Application> appList = new ArrayList<>();
		try {
			if(id=="root") {
				sql1 = "select * from application where id like '%'";
				pstmt = conn.prepareStatement(sql1);
			}
			else {
				sql1 = "select * from application where id = ?";
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, id);
			}
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				appList.add(createApplication(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
		}
		disConnectDB();
		
		return appList;
	}
	
	public Application getApplication(int appNo) {
		Application app = new Application();
		
		connectDB();
		String sql1 = "select * from application where applicationNo = ?";
		
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, appNo);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				app = createApplication(rs);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
		}
		disConnectDB();
		
		return app;
	}
	
	public void updateApplication(Application app) {
		
		connectDB();
		String sql1 = "update application set accept=? ,reason=? where applicationNo = ?";

		System.out.println(app.getReason());
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, app.getAccept());
			pstmt.setString(2, app.getReason());
			pstmt.setInt(3, app.getApplicationNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
		}
		disConnectDB();
		
	}
}
