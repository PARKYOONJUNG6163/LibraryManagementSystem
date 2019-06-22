package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import obj.Member;
import obj.Env;

public class MemberDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Env env = new Env();
	public MemberDAO() {
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
	
	// 로그인 요청이 올바른지 확인
	public Boolean checkExistMember(String id, String pw) {
		connectDB();
		String sql = "SELECT id FROM member WHERE (id = ?) and (pw = ?)";
		boolean success = true;
	
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				return null;
			}
		} catch (SQLException e) {
			success = false;
			e.printStackTrace();
		}
		disConnectDB();	
		return success;
	}
	
	
	 // 정보 등록
    public boolean registerMemberInformation(String id,String pw, String name, String email, String tel, String birth, String address) {
       connectDB();
       String sql = "INSERT INTO member (id, pw, name, email, tel, birth, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
       
       try {
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          pstmt.setString(2, pw);
          pstmt.setString(3, name);
          pstmt.setString(4, email);
          pstmt.setString(5, tel);
          pstmt.setString(6, birth);
          pstmt.setString(7, address);
          pstmt.executeUpdate();
       } catch (SQLException e) {
          e.printStackTrace();
          return false;
       }
       disConnectDB();
       
       return true;
    }
    
    //정보 조회
	public Member getMemberInformation(String id) {
		connectDB();
		String sql = "SELECT * FROM member WHERE id = ?";
		Member member = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				return null;
			}
			
			member = createMember(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		
		return member;
	}
	
	//정보 수정
	public boolean modifyMemberInformation(String id,String name,String tel,String email,String birth,String address) {
		boolean success = true;
		connectDB();
		String sql = "UPDATE member SET name = ?, tel = ?, email = ?,birth = ?, address = ? WHERE id = ?";
		
		if(name == null || tel == null || email == null || birth == null || address == null) {
			return false;
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, tel);
			pstmt.setString(3, email);
			pstmt.setString(4, birth);
			pstmt.setString(5, address);
			pstmt.setString(6, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			success = false;
			e.printStackTrace();
		}
		disConnectDB();	
		return success;
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
