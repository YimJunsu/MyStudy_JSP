package dao;

import dto.Member;
import java.sql.*;

public class MemberRepository {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/BookStoreJSP", "team1", "1234"
        );
    }

    public void save(Member member) throws Exception {
        String sql = "INSERT INTO member (id, password, name, email, zipcode, address1, address2, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, member.getId());
            ps.setString(2, member.getPassword());
            ps.setString(3, member.getName());
            ps.setString(4, member.getEmail());
            ps.setString(5, member.getZipcode());
            ps.setString(6, member.getAddress1());
            ps.setString(7, member.getAddress2());
            ps.setString(8, member.getRole());  // role을 저장
            ps.executeUpdate();
        }
    }

    public Member findByIdAndPassword(String id, String password) throws Exception {
        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member m = new Member();
                m.setId(rs.getString("id"));
                m.setName(rs.getString("name"));
                m.setRole(rs.getString("role"));  // 역할도 가져오기
                return m;
            }
            return null;
        }
    }
}
