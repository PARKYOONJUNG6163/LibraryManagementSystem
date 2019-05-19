package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import obj.Rent;

public class RentDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public RentDAO() {
	}

	private void connectDB() {
		this.jdbcUrl = "jdbc:mysql://localhost:3306/library";
		this.dbId = "root";
		this.dbPass = "weak";

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
	
	// 대여 리스트 반환
	public List<Rent> getRentList() {
		connectDB();
		String sql = "SELECT * FROM rent A LEFT OUTER JOIN book B USING(bookNo)";
		List<Rent> rent_list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return rent_list;
			}

			do {
				Rent rent = createRent(rs);
				rent_list.add(rent);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return rent_list;
	}

	// ResultSet에 대한 Member 객체를 만들어서 반환하는 함수
	private Rent createRent(ResultSet rs) throws SQLException {
		Rent rent = new Rent();
		rent.setRentNo(rs.getInt("rentNo"));
		rent.setBookNo(rs.getInt("bookNo"));
		rent.setIsbn(rs.getString("isbn"));
		rent.setIsreservation(rs.getString("isreservation"));
		rent.setId(rs.getString("id"));
		rent.setRentDate(rs.getString("rentDate"));
		rent.setReturnDate(rs.getString("returnDate"));
		rent.setExtension(rs.getString("extension"));
		return rent;
	}
	
}
