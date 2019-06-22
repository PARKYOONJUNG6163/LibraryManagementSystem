package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import obj.Book;
import obj.BookInstance;
import obj.Env;

public class BookInfoDAO {
	String jdbcUrl;
	String dbId;
	String dbPass;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Env env = new Env();
	public BookInfoDAO() {
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

	public int registerBookInfo(String isbn, int category, String name, String author, String publisher,
			String publishedDate) {
		connectDB();
		String sql = "INSERT INTO BookInfo (isbn, categoryKey, bookName, author, publisher, publishedDate) VALUES (?, ?, ?, ?, ?, ?)";

		if (!checkIsbn(isbn)) {
			disConnectDB();
			return 1;
		}

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			pstmt.setInt(2, category);
			pstmt.setString(3, name);
			pstmt.setString(4, author);
			pstmt.setString(5, publisher);
			pstmt.setString(6, publishedDate);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			disConnectDB();
			return 0;
		}
		disConnectDB();
		return 2;
	}

	private boolean checkIsbn(String isbn) {
		String sql = "SELECT * FROM BookInfo";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (rs.getString("Isbn").equals(isbn)) { // 학점 정보가 존재하면
					return false;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}

	// 수정하려는 도서 객체 가져오기
	public Book getBook(String isbn) {
		connectDB();
		String sql = "SELECT * FROM BookInfo WHERE Isbn = ?";
		Book book = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return null;
			}

			do {
				book = createBook(rs);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return book;
	}

	// 도서관에 등록된 도서 리스트
	public List<Book> getBookList() {
		connectDB();
		String sql = "SELECT * FROM BookInfo";
		List<Book> book_list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return book_list;
			}

			do {
				Book book = createBook(rs);
				book_list.add(book);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return book_list;
	}

	// ResultSet에 대한 Book 객체를 만들어서 반환하는 함수
	private Book createBook(ResultSet rs) throws SQLException {
		Book book = new Book();

		book.setIsbn(rs.getString("isbn"));
		book.setCategoryKey(rs.getInt("categoryKey"));
		book.setBookName(rs.getString("bookName"));
		book.setAuthor(rs.getString("author"));
		book.setPublisher(rs.getString("publisher"));
		book.setPublishedDate(rs.getString("publishedDate"));
		return book;
	}

	// 도서정보 수정
	public boolean modifyBookInfo(String isbn, int category, String name, String author, String publisher,
			String publishedDate) {
		connectDB();
		String sql = "UPDATE bookInfo SET categoryKey = ?, bookName = ?, author = ?, publisher = ?, publishedDate = ? "
				+ "WHERE isbn = ?";
		boolean success = true; // 수정 성공 여부

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			pstmt.setString(2, name);
			pstmt.setString(3, author);
			pstmt.setString(4, publisher);
			pstmt.setString(5, publishedDate);
			pstmt.setString(6, isbn);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		disConnectDB();
		return success;
	}

	// 도서정보 삭제
	public boolean deleteBookInfo(String isbn) {
		connectDB();
		String sql = "DELETE FROM bookInfo WHERE isbn = ?";
		boolean success = true; // 삭제 성공 여부

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		disConnectDB();
		return success;
	}
	
	public String getBookName(int bookNo) {
		connectDB();
		String sql = "select bookName from BookInfo where isbn = (select isbn from Book where bookNo = ?)";
		String bookName = "";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(bookNo));
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				bookName=rs.getString("bookName");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		
		return bookName;
	}
	

	public String getBookCategory(int key) {
		connectDB();
		
		String sql = "select * from BookCategory where categoryKey = ?";
		String categoryName = "";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(key));
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				categoryName=rs.getString("categoryName");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		
		return categoryName;
	}
	
	public ArrayList<BookInstance> getBookInstance(String isbn){
		connectDB();
		String sql = "SELECT * FROM Book WHERE isbn = ?";
		ArrayList<BookInstance> bookinstance_list = new ArrayList<BookInstance>();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				disConnectDB();
				return bookinstance_list;
			}

			do {
				BookInstance instance = new BookInstance();
				instance.setbookNo(Integer.parseInt(rs.getString("bookNo")));
				instance.setIsbn(rs.getString("isbn"));
				instance.setIsreservation(rs.getString("isreservation"));
				bookinstance_list.add(instance);
			} while (rs.next());

		} catch (SQLException e) {
			e.printStackTrace();
		}
		disConnectDB();
		return bookinstance_list;
	}
}
