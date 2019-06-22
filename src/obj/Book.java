package obj;

public class Book {
	private String isbn;	
	private int categoryKey;		// 카테고리 num
	private String bookName;		// 책이름
	private String author;			// 저자
	private String publisher;			// 출판사
	private String publishedDate ;  // 출판일
	
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getCategoryKey() {
		return categoryKey;
	}
	public void setCategoryKey(int categoryKey) {
		this.categoryKey = categoryKey;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPublishedDate() {
		return publishedDate;
	}
	public void setPublishedDate(String publishedDate) {
		this.publishedDate = publishedDate;
	}
}
