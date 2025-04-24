package dao;

import java.sql.*;
import java.util.ArrayList;

import dto.Book;
import filter.DBConnection;

public class BookRepository {

    // 싱글톤 인스턴스
    private static BookRepository instance = new BookRepository();

    // 외부에서 인스턴스 가져오기
    public static BookRepository getInstance() {
        return instance;
    }

    // 생성자
    private BookRepository() {}

    // DB 연결
    private Connection getConnection() throws SQLException {
        try {
            return DBConnection.getConnection();
        } catch (Exception e) {
            throw new SQLException("DB 연결 오류", e);
        }
    }

    // 도서 상세 정보 가져오기 (DB 조회)
    public Book getBookById(String bookId) {
        Book bookById = null;
        String sql = "SELECT * FROM book WHERE book_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, bookId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bookById = new Book(
                        rs.getString("book_id"),
                        rs.getString("name"),
                        rs.getInt("unit_price")
                    );
                    bookById.setAuthor(rs.getString("author"));
                    bookById.setDescription(rs.getString("description"));
                    bookById.setPublisher(rs.getString("publisher"));
                    bookById.setCategory(rs.getString("category"));
                    bookById.setUnitsInStock(rs.getLong("units_in_stock"));
                    bookById.setReleaseDate(rs.getString("release_date"));
                    bookById.setCondition(rs.getString("condition"));
                    bookById.setFilename(rs.getString("filename"));
                    bookById.setQuantity(rs.getInt("quantity"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // 디버깅 용도
        }

        return bookById;
    }

    // 도서 전체 목록 가져오기
    public ArrayList<Book> getAllBooks() {
        ArrayList<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM book";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Book book = new Book(
                    rs.getString("book_id"),
                    rs.getString("name"),
                    rs.getInt("unit_price")
                );
                book.setAuthor(rs.getString("author"));
                book.setDescription(rs.getString("description"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setUnitsInStock(rs.getLong("units_in_stock"));
                book.setReleaseDate(rs.getString("release_date"));
                book.setCondition(rs.getString("condition"));
                book.setFilename(rs.getString("filename"));
                book.setQuantity(rs.getInt("quantity"));

                list.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
