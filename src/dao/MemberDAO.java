package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import obj.Member;

public class MemberDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public MemberDAO() {
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

	// 도서관에 가입한 회원 리스트
	public List<Member> getMemberList() {
		connectDB();
		String sql = "SELECT * FROM Member";
		List<Member> member_list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return member_list;
			}

			do {
				Member member = createMember(rs);
				member_list.add(member);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return member_list;
	}
	
	// 회원정보 삭제
		public boolean deleteMember(String id) {
			connectDB();
			String sql = "DELETE FROM member WHERE id = ?";
			boolean success = true; // 삭제 성공 여부

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				success = false;
			}
			disConnectDB();
			return success;
		}
		
	// ResultSet에 대한 Member 객체를 만들어서 반환하는 함수
	private Member createMember(ResultSet rs) throws SQLException {
		Member member = new Member();
		member.setId(rs.getString("id"));
		member.setPw(rs.getString("pw"));
		member.setName(rs.getString("name"));
		member.setTel(rs.getString("tel"));
		member.setEmail(rs.getString("email"));
		member.setBirth(rs.getString("birth"));
		member.setAddress(rs.getString("address"));
		return member;
	}
}
