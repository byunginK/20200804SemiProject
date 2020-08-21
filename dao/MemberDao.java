package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	public static MemberDao getInstance() {
		return dao;
	}
	
	
	public boolean CheckId(String id) {	
	
		String sql = " SELECT COUNT(*) FROM FIVE_MEMBER "	
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean findid = false;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 CheckId success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 CheckId success");
			
			psmt.setString(1, id.trim());
			
			rs = psmt.executeQuery();
			System.out.println("3/6 CheckId success");
			
			if(rs.next()) {	
				if(rs.getInt("COUNT(*)") != 0){
					
					findid = false;
				//	System.out.println(rs.getInt("COUNT(*)"));
				}
				else if(rs.getInt("COUNT(*)") == 0) {
					
					findid = true;
				}
				
			}			
			System.out.println(findid);
		} catch (Exception e) {			
			e.printStackTrace();
			System.out.println("getId fail");
		} finally {
			DBClose.close(psmt, conn, rs);			
		}
		
		return findid;
	}
	
	public boolean addMember(MemberDto dto) {
	
		String sql = " INSERT INTO FIVE_MEMBER "
				+ "	(ID, PASSWORD, NAME, PHONENUMBER, EMAIL, AUTH) "
				+ " VALUES(?, ?, ?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addMember success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 addMember success");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setInt(4, dto.getPhone());
			psmt.setString(5, dto.getEmail());
			
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addMember success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("addMember fail");
		} finally {
			DBClose.close(psmt, conn, null);	
			System.out.println("4/6 addMember success");
		}
		
		return count>0?true:false;
	}
public MemberDto login(String id, String pwd) {
		
		String sql = " SELECT ID, PASSWORD, NAME, PHONENUMBER, EMAIL, AUTH "
				+ " FROM FIVE_MEMBER "
				+ " WHERE ID=? AND PASSWORD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;		
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/6 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 login success");
			
			if(rs.next()) {
				String user_id = rs.getString(1);
				String user_pwd = rs.getString(2);
				String name = rs.getString(3);
				int phone = rs.getInt(4);
				String email = rs.getString(5);
				int auth = rs.getInt(6);
				
				dto = new MemberDto(user_id, user_pwd, name, phone, email, auth);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
				
	}
public boolean update_Member( MemberDto dto ){
	
	String sql = " UPDATE FIVE_MEMBER "
			    + " SET PASSWORD=?, NAME=?, EMAIL=?, PHONENUMBER=? "
			    + " WHERE ID=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	int count = 0;
	
	try {
		conn= DBConnection.getConnection();
		System.out.println("1/6 update_Member success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, dto.getPwd());
		psmt.setString(2, dto.getName());
		psmt.setString(3, dto.getEmail());
		psmt.setInt(4, dto.getPhone());
		psmt.setString(5, dto.getId());
		System.out.println("2/6 update_Member success");
		
		count = psmt.executeUpdate();
		System.out.println("3/6 update_Member success");
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, null);
		System.out.println("4/6 update_Member success");
	}
	return count>0?true:false;
}


public void DeleteMem(String id) {
	String sql = " DELETE FIVE_MEMBER "
			    + " WHERE ID=? ";
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 DeleteMem success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		System.out.println("2/6 DeleteMem success");
		
		psmt.executeUpdate();
		System.out.println("3/6 DeleteMem success");
		
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, null);
		System.out.println("4/6 DeleteMem success");
	}
	
}

public String find_Id( String email ) {
	String sql = " SELECT ID "
			+ " FROM FIVE_MEMBER "
			+ " WHERE EMAIL=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	String find = "";
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 find_Id success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, email);
		System.out.println("2/6 find_Id success");
		
		rs = psmt.executeQuery();
		System.out.println("3/6 find_Id success");
		if(rs.next()) {
			find = rs.getString(1);
		}
		System.out.println(find);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, rs);
		System.out.println("4/6 find_Id success");
		
	}
	return find;
}

public String find_Pwd( String id, String email ) {
	String sql = " SELECT PASSWORD "
			+ " FROM FIVE_MEMBER "
			+ " WHERE ID=? "
			+ " AND EMAIL=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	String find = "";
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 find_Pwd success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		psmt.setString(2, email);
		System.out.println("2/6 find_Pwd success");
		
		rs = psmt.executeQuery();
		System.out.println("3/6 find_Pwd success");
		if(rs.next()) {
			find = rs.getString(1);
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, rs);
		System.out.println("4/6 find_Pwd success");
	}
	return find;
}

public int order_Count( String id ) {
	String sql = " SELECT COUNT(*) "
			+ " FROM FIVE_ORDER "
			+ " WHERE ID=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int find = 0;
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 order_Count success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		System.out.println("2/6 order_Count success");
		
		rs = psmt.executeQuery();
		System.out.println("3/6 order_Count success");
		if(rs.next()) {
			find = rs.getInt(1);
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, rs);
		System.out.println("4/6 order_Count success");
	}
	return find;
}

public int Mem_Grade( String id ) {
	String sql = " SELECT COUNT(*) "
			+ " FROM FIVE_ORDER "
			+ " WHERE ID=? ";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int find = 0;
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("1/6 order_Count success");
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		System.out.println("2/6 order_Count success");
		
		rs = psmt.executeQuery();
		System.out.println("3/6 order_Count success");
		if(rs.next()) {
			find = rs.getInt(1);
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		DBClose.close(psmt, conn, rs);
		System.out.println("4/6 order_Count success");
	}
	return find;
			
	
}

}








