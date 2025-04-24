package dao;

import dto.Member;
import filter.DBConnection;
import java.sql.*;

public class MemberRepository {

    // 싱글톤 인스턴스
    private static MemberRepository instance = new MemberRepository();

    // 외부에서 인스턴스 가져오기
    public static MemberRepository getInstance() {
        return instance;
    }

    // 생성자
    private MemberRepository() {}

    public void save(Member member) throws Exception {
        String sql = "INSERT INTO member (id, password, name, email, zipcode, address1, address2, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, member.getId());
            ps.setString(2, member.getPassword());
            ps.setString(3, member.getName());
            ps.setString(4, member.getEmail());
            ps.setString(5, member.getZipcode());
            ps.setString(6, member.getAddress1());
            ps.setString(7, member.getAddress2());
            ps.setString(8, member.getRole());
            ps.executeUpdate();
        }
    }

    public Member findByIdAndPassword(String id, String password) throws Exception {
        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member m = new Member();
                m.setId(rs.getString("id"));
                m.setName(rs.getString("name"));
                m.setRole(rs.getString("role"));
                return m;
            }
            return null;
        }
    }

    // 🔽 새로 추가할 메서드
    public Member findById(String id) throws Exception {
        String sql = "SELECT * FROM member WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member m = new Member();
                m.setId(rs.getString("id"));
                m.setPassword(rs.getString("password"));
                m.setName(rs.getString("name"));
                m.setEmail(rs.getString("email"));
                m.setZipcode(rs.getString("zipcode"));
                m.setAddress1(rs.getString("address1"));
                m.setAddress2(rs.getString("address2"));
                m.setRole(rs.getString("role"));
                return m;
            }
            return null;
        }
    }
}
