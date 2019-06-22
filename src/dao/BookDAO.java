package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import obj.Env;

public class BookDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Env env = new Env();
	public BookDAO() {
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

	public void registerBook(String isbn) {
		connectDB();
		String sql = "INSERT INTO Book (isbn, isreservation) VALUES (?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			pstmt.setString(2, "NO");
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
		}
		disConnectDB();
	}


	public int getBookNum(String isbn) {
		connectDB();
		
		String sql = "select count(*) as num from Book where isbn = ?";
		int num = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(isbn));
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		
		return num;
	}
	
	public boolean updateRev(int bookNo,String isRev,String id) {
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd");
		Date time = new Date();
		connectDB();
		String sql = "UPDATE book SET isreservation = ? "
				+ "WHERE bookNo = ?";
		String sql2 = "SELECT * FROM book WHERE bookNo = ?";
		String sql3 = "INSERT INTO reservation (id, bookNo, reservationDate) values(?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, bookNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (!rs.getString("isreservation").equals("NO")) {
					return false;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		boolean success = true;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isRev);
			pstmt.setInt(2, bookNo);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, id);
			pstmt.setInt(2, bookNo);
			pstmt.setString(3, format1.format(time));
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		disConnectDB();
		return success;
	}
	
	public boolean updateRent(int bookNo,String isRev) {
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd");
		Date time = new Date();
		connectDB();
		String sql = "UPDATE book SET isreservation = ? "
				+ "WHERE bookNo = ?";
		String sql2 = "SELECT * FROM book WHERE bookNo = ?";
		try {
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, bookNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (!rs.getString("isreservation").equals("NO")) {
					return false;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		boolean success = true;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isRev);
			pstmt.setInt(2, bookNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		disConnectDB();
		return success;
	}
	
	public boolean removeBook(String isbn,int bookNo, String id) {
		if(id == "root") {
			return false;
		}
		connectDB();
		String sql = "DELETE FROM Book WHERE isbn = ? AND bookNo = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			pstmt.setInt(2, bookNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
			return false;
		}
		disConnectDB();
		return true;
	}
}
