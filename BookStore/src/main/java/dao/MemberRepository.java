package dao;

import dto.Member;
import java.sql.*;
import java.util.Optional;

public class MemberRepository {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/yourDB", "root", "password"
        );
    }

    public void save(Member member) throws Exception {
        String sql = "INSERT INTO member (id, password, name, email, zipcode, address1, address2) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, member.getId());
            ps.setString(2, member.getPassword());
            ps.setString(3, member.getName());
            ps.setString(4, member.getEmail());
            ps.setString(5, member.getZipcode());
            ps.setString(6, member.getAddress1());
            ps.setString(7, member.getAddress2());
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
                return m;
            }
            return null;
        }
    }
}
