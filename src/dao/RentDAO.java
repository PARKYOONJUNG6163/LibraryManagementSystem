package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import obj.Env;
import obj.Rent;

public class RentDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Env env = new Env();
	public RentDAO() {
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
		rent.setId(rs.getString("id"));
		rent.setRentDate(rs.getString("rentDate"));
		rent.setReturnDate(rs.getString("returnDate"));
		rent.setExtension(rs.getString("extension"));
		return rent;
	}
	
	// 특정 사용자의 대여 리스트 반환
	public List<Rent> getRentListUser() { //getRentListUser(String id)
		connectDB();
		String sql = "SELECT * FROM rent A LEFT OUTER JOIN book B USING(bookNo)";
		//String sql = "SELECT * FROM rent A LEFT OUTER JOIN book B USING(bookNo) where id = " + id;
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
	
	public void updateRentDate(Rent rent) throws SQLException {
		connectDB();
		
		String sql = "update rent set rentDate = ? where rentNo = ?";
		String sql2 = "update rent set extension = ? where rentNo = ?";
		
		System.out.println(rent.getRentDate());
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rent.getRentDate());
			pstmt.setString(2, String.valueOf(rent.getRentNo()));
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, rent.getExtension());
			pstmt.setString(2, String.valueOf(rent.getRentNo()));
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
	}
	
	
	//전날 대여가 가장 많은 순으로 반환
	public List<Integer> getRank(String yesterday) {
		connectDB();
		String sql = "select isbn, count(isbn) as rank from (SELECT * FROM rent A LEFT OUTER JOIN book B USING(bookNo) where rentDate LIKE ?) sub group by isbn order by rank desc";
		List<Integer> rentRankList = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, yesterday+"~%");
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return rentRankList;
			}

			do {
				int isbn = rs.getInt("isbn");
				rentRankList.add(isbn);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return rentRankList;
	}
	
	public boolean rentBookInstance(String bookNo,String id) throws ParseException {
		connectDB();
		BookDAO bookinstancedao = new BookDAO();
		String sql = "INSERT INTO rent (bookNo, id, rentDate, returnDate,extension) values(?,?,?,?,?)";
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date time = new Date();
		String current_time = format1.format(time);
		System.out.println(current_time);
		cal.setTime(format1.parse(current_time));
		cal.add(Calendar.DATE, 7);
		if (!checkRent(bookNo)) {
			disConnectDB();
			return false;
		}
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookNo);
			pstmt.setString(2, id);
			pstmt.setString(3, current_time);
			pstmt.setString(4, format1.format(cal.getTime()));
			pstmt.setString(5, "NO");
			pstmt.executeUpdate();
			bookinstancedao.updateRent(Integer.parseInt(bookNo),"YES");
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
			return false;
		}
		disConnectDB();	
		return true;
	}
	
	private boolean checkRent(String bookNo) {
		String sql = "SELECT * FROM rent";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (rs.getString("bookNo").equals(bookNo)) { // �븰�젏 �젙蹂닿� 議댁옱�븯硫�
					return false;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public List<Rent> getRentListID(String id){
		connectDB();
		String sql = "SELECT * FROM rent WHERE id = ?";
		// A LEFT OUTER JOIN member B ON A.id = B.id and B.id = ?
		List<Rent> rent_list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	public boolean updateExt(int rentNo) throws ParseException {
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		connectDB();
		String sql = "UPDATE rent SET Extension = ?, returnDate = ? "
				+ "WHERE rentNo = ?";
		String sql1 = "SELECT returnDate FROM rent where rentNo = ?";
		boolean success = true;
		ResultSet rs = null;
		String returndate = null;
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, rentNo);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				returndate = rs.getString("returnDate");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		
		try {
			cal.setTime(format1.parse(returndate));
			cal.add(Calendar.DATE, 3);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "YES");
			pstmt.setString(2, format1.format(cal.getTime()));
			pstmt.setInt(3, rentNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		disConnectDB();
		return success;
	}
	
	public boolean deleteRent(int rentNo, String id) {
		connectDB();
		String sql = "DELETE FROM rent WHERE rentNo = ? AND id = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rentNo);
			pstmt.setString(2, id);
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
