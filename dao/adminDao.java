package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.InfoDto;
import dto.ProductDto;
import dto.ReplyDto;
import dto.blistDto;
import dto.sug_AnswerDto;
import dto.suggestDto;

public class adminDao {
	
	private static adminDao dao = new adminDao();
	
	private adminDao() {
	}
	
	public static adminDao getInstance() {
		return dao;
	}
	
	public List<blistDto> getQnaList(){
		String sql = " SELECT SEQ, ID, TITLE, UDATE  FROM FIVE_QNA ORDER BY SEQ DESC";
		
		List<blistDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin getQnaList success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaList success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				if(title.length()>40) {
					title = title.substring(0,40);
					title += "...";
				}
				String udate = rs.getString(i++);
				
				blistDto dto = new blistDto(seq,id,title,udate);
				list.add(dto);
			}
			System.out.println("3/9 admin getQnaList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public List<blistDto> getQnaList(int pageNumber,int how){
		String sql = "  SELECT SEQ, ID, TITLE, UDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, ID, TITLE, UDATE  " + 
				" FROM FIVE_QNA  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ? " + 
				" ORDER BY SEQ DESC ";
		
		List<blistDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin getQnaList(num) success ");
			
			psmt.setInt(1, (pageNumber*how)+1);
			psmt.setInt(2, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaList(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				if(title.length()>40) {
					title = title.substring(0,40);
					title += "...";
				}
				String udate = rs.getString(i++);
				
				blistDto dto = new blistDto(seq,id,title,udate);
				list.add(dto);
			}
			System.out.println("3/9 admin getQnaList(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<ReplyDto> rep_getQnaList(int pageNumber,int howmany){
		String sql = "  SELECT SEQ, ID,CONTENTS,WDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
				"	SEQ, ID, CONTENTS, WDATE  " + 
				" FROM FIVE_REPLY  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<ReplyDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin rep_getQnaList(num) success ");
			
			psmt.setInt(1, (pageNumber*howmany)+1);
			psmt.setInt(2, (pageNumber*howmany)+howmany);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin rep_getQnaList(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String contents = rs.getString(i++);
				if(contents.length() > 10) {
					contents = contents.substring(0,11);
					contents += "...";
				}
				String wdate = rs.getString(i++);
				
				ReplyDto dto = new ReplyDto(seq,id,wdate,contents);
				list.add(dto);
			}
			System.out.println("3/9 admin rep_getQnaList(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<ProductDto> pro_getQnaList(int pageNumber){
		String sql = "  SELECT SEQ, P_NAME, P_CATEGORY, FILENAME " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, P_NAME, P_CATEGORY, FILENAME  " + 
				" FROM FIVE_CATEGORY  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<ProductDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin pro_getQnaList(num) success ");
			
			psmt.setInt(1, (pageNumber*10)+1);
			psmt.setInt(2, (pageNumber*10)+10);
			
			//System.out.println("pro = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaList(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String p_name = rs.getString(i++);
				String p_category = rs.getString(i++);
				String filename = rs.getString(i++);
				
				ProductDto dto = new ProductDto(seq,p_name,p_category,filename);
				list.add(dto);
			}
			System.out.println("3/9 admin pro_getQnaList(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<InfoDto> info_getQnaList(int pageNumber,int how){
		String sql = "  SELECT SEQ, ID, TITLE, CONTENT, WDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, ID, TITLE, CONTENT,WDATE  " + 
				" FROM FIVE_INFO  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<InfoDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin pro_getQnaList(num) success ");
			
			psmt.setInt(1, (pageNumber*how)+1);
			psmt.setInt(2, (pageNumber*how)+how);
			
			//System.out.println("pro = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaList(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>50) {
					content = content.substring(0,50);
					content +="...";
				}
				String wdate = rs.getString(i++);
				
				
				InfoDto dto = new InfoDto(seq,id,title,content,wdate);
				list.add(dto);
			}
			System.out.println("3/9 admin pro_getQnaList(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<suggestDto> sug_getQnaList(int pageNumber,int how){
		String sql = "  SELECT SEQ,ID, TITLE, CONTENT " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ,ID, TITLE, CONTENT  " + 
				" FROM FIVE_SUGGEST  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<suggestDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sug_getQnaList(num) success ");
			
			psmt.setInt(1, (pageNumber*how)+1);
			psmt.setInt(2, (pageNumber*how)+how);
			
			//System.out.println("pro = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sug_getQnaList(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>40) {
					content = content.substring(0,40);
					content +="...";
				}
				
				suggestDto dto = new suggestDto(seq,id,title,content);
				list.add(dto);
			}
			System.out.println("3/9 admin sug_getQnaList(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<sug_AnswerDto> sugrep_getQnaList(int pageNumber,int how){
		String sql = "  SELECT SEQ,writer_ID, CONTENT " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ,writer_ID, CONTENT  " + 
				" FROM FIVE_SUGGEST_COMMENT  " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<sug_AnswerDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sug_AnswerDto(num) success ");
			
			psmt.setInt(1, (pageNumber*how)+1);
			psmt.setInt(2, (pageNumber*how)+how);
			
			//System.out.println("pro = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sug_AnswerDto(num) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>10) {
					content = content.substring(0,10);
					content +="...";
				}
				
				sug_AnswerDto dto = new sug_AnswerDto(seq,id,content);
				list.add(dto);
			}
			System.out.println("3/9 admin sug_AnswerDto(num) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<blistDto> getQnaList(String need, String fneed,int pageNumber, int how){
		String sql = "  SELECT SEQ, ID, TITLE, UDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
				"	SEQ, ID, TITLE, UDATE  " + 
				" FROM FIVE_QNA  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<blistDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*how)+1);
			psmt.setInt(3, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				if(title.length() > 10) {
					title = title.substring(0,11);
					title += "...";
				}
				String udate = rs.getString(i++);
				
				blistDto dto = new blistDto(seq,id,title,udate);
				list.add(dto);
			}
			System.out.println("3/9 admin getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<ReplyDto> rep_getQnaList(String need, String fneed,int pageNumber,int how){
		String sql = "  SELECT SEQ, ID, CONTENTS, WDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
				"	SEQ, ID, CONTENTS, WDATE  " + 
				" FROM FIVE_REPLY  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ? " + 
				" ORDER BY SEQ DESC ";
		
		List<ReplyDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin rep_getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*how)+1);
			psmt.setInt(3, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin rep_getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String contents = rs.getString(i++);
				if(contents.length() > 10) {
					contents = contents.substring(0,11);
					contents += "...";
				}
				String wdate = rs.getString(i++);
				
				ReplyDto dto = new ReplyDto(seq,id,wdate,contents);
				list.add(dto);
				System.out.println("dao = "+ contents);
			}
			System.out.println("3/9 admin rep_getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<ProductDto> pro_getQnaList(String need, String fneed,int pageNumber){
		String sql = "  SELECT SEQ, P_NAME, P_CATEGORY, FILENAME " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, P_NAME, P_CATEGORY, FILENAME  " + 
				" FROM FIVE_CATEGORY  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<ProductDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin pro_getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*10)+1);
			psmt.setInt(3, (pageNumber*10)+10);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String p_name = rs.getString(i++);
				String p_category = rs.getString(i++);
				String filename = rs.getString(i++);
				
				ProductDto dto = new ProductDto(seq,p_name,p_category,filename);
				list.add(dto);
			}
			System.out.println("3/9 admin pro_getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<InfoDto> info_getQnaList(String need, String fneed,int pageNumber,int how){
		String sql = "  SELECT SEQ, ID, TITLE, CONTENT,WDATE " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, ID, TITLE, CONTENT,WDATE  " + 
				" FROM FIVE_INFO  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<InfoDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin info_getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*how)+1);
			psmt.setInt(3, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin info_getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>50) {
					content = content.substring(0,50);
					content +="...";
				}
				String wdate = rs.getString(i++);
				
				InfoDto dto = new InfoDto(seq,id,title,content,wdate);
				list.add(dto);
			}
			System.out.println("3/9 admin info_getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<suggestDto> sug_getQnaList(String need, String fneed,int pageNumber,int how){
		String sql = "  SELECT SEQ, ID, TITLE,CONTENT " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, ID, TITLE,CONTENT  " + 
				" FROM FIVE_SUGGEST  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<suggestDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sug_getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*how)+1);
			psmt.setInt(3, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sug_getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>40) {
					content = content.substring(0,40);
					content +="...";
				}
				
				suggestDto dto = new suggestDto(seq,id,title,content);
				list.add(dto);
			}
			System.out.println("3/9 admin sug_getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public List<sug_AnswerDto> sugrep_getQnaList(String need, String fneed,int pageNumber,int how){
		String sql = "  SELECT SEQ, WRITER_ID, CONTENT " + 
				" FROM " + 
				" ( SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, " + 
				"	SEQ, WRITER_ID,CONTENT  " + 
				" FROM FIVE_SUGGEST_COMMENT  "
				+ " WHERE "+need +" LIKE ? " + 
				" ORDER BY SEQ DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ?" + 
				" ORDER BY SEQ DESC";
		
		List<sug_AnswerDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sugrep_getQnaList(all) success ");
			
			psmt.setString(1, "%"+fneed+"%");
			psmt.setInt(2, (pageNumber*how)+1);
			psmt.setInt(3, (pageNumber*how)+how);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sugrep_getQnaList(all) success ");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String id = rs.getString(i++);
				String content = rs.getString(i++);
				if(content.length()>10) {
					content = content.substring(0,10);
					content +="...";
				}
				
				sug_AnswerDto dto = new sug_AnswerDto(seq,id,content);
				list.add(dto);
			}
			System.out.println("3/9 admin sugrep_getQnaList(all) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	public int getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_QNA ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int rep_getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_REPLY ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin rep_getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin rep_getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin rep_getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int pro_getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_CATEGORY ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin pro_getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin pro_getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int info_getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_INFO ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin pro_getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin pro_getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int sug_getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_SUGGEST ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sug_getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sug_getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin sug_getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int sugrep_getQnaLen(){
		String sql = " SELECT COUNT(*) FROM FIVE_SUGGEST_COMMENT ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sugrep_getQnaLen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sugrep_getQnaLen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin sugrep_getQnaLen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_QNA ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int rep_getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_REPLY ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int pro_getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_CATEGORY ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin pro_getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin pro_getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int info_getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_INFO ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin info_getQnaLen(2) success ");
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin info_getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin info_getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int sug_getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_SUGGEST ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sug_getQnaLen(2) success ");
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sug_getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin sug_getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int sugrep_getQnaLen(String need, String fneed){
		String sql = " SELECT COUNT(*) FROM FIVE_SUGGEST_COMMENT ";
		
		//System.out.println("need = "+need);
		if(!need.equals("") && need != null) {
			sql += " WHERE "+need+" LIKE ? ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 admin sugrep_getQnaLen(2) success ");
			
			if(!need.equals("") && need != null) {
				psmt.setString(1, "%"+fneed+"%");
			}
			//System.out.println("sql = "+sql);
			rs = psmt.executeQuery();
			System.out.println("2/9 admin sugrep_getQnaLen(2) success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 admin sugrep_getQnaLen(2) success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public boolean delchkList(List<String> list) {
		String sql1 = " DELETE FROM FIVE_REPLY WHERE QNA_SEQ = ? ";
		String sql = " DELETE FROM FIVE_QNA WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		int[] count1 = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql1);
			System.out.println("1/9 delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 delchkList success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 delchkList success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql);
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("4/9 delchkList success ");
			
			count1 = psmt.executeBatch();
			System.out.println("5/9 delchkList success ");
			//conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 || count1[i] != -2) isS = false;
		}
		System.out.println("6/9 delchkList success ");
		
		return isS;
	}
	public boolean rep_delchkList(List<String> list) {
		String sql = " DELETE FROM FIVE_REPLY WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 rep_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 rep_delchkList success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 rep_delchkList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 ) isS = false;
		}
		System.out.println("4/9 rep_delchkList success ");
		
		return isS;
	}
	public boolean pro_delchkList(List<String> list) {
		String sql3 = " DELETE FROM FIVE_ORDER WHERE ITEM_SEQ = ? ";
		String sql2 = " DELETE FROM FIVE_REPLY WHERE CATEGORY_SEQ = ? ";
		String sql1 = " DELETE FROM FIVE_CART WHERE ITEM_SEQ = ? ";
		String sql = " DELETE FROM FIVE_CATEGORY WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		int[] count1 = new int[list.size()];
		int[] count2 = new int[list.size()];
		int[] count3 = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql3);
			System.out.println("1/9 pro_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 pro_delchkList success ");
			
			count3 = psmt.executeBatch();
			System.out.println("3/9 pro_delchkList success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql2);
			System.out.println("4/9 pro_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			count2 = psmt.executeBatch();
			System.out.println("5/9 pro_delchkList success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql1);
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			
			count = psmt.executeBatch();
			System.out.println("6/9 pro_delchkList success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql);
			System.out.println("7/9 pro_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("8/9 pro_delchkList success ");
			
			count1= psmt.executeBatch();
			System.out.println("9/9 pro_delchkList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 || count1[i] != -2 || count2[i] != -2 || count3[i] != -2) isS = false;
		}
		System.out.println("9/9 pro_delchkList success ");
		
		return isS;
	}
	public boolean info_delchkList(List<String> list) {
		String sql = " DELETE FROM FIVE_INFO WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 info_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 info_delchkList success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 info_delchkList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 ) isS = false;
		}
		System.out.println("4/9 pro_delchkList success ");
		
		return isS;
	}
	public boolean sug_delchkList(List<String> list) {
		String sql1= " DELETE FROM FIVE_SUGGEST_COMMENT WHERE SUGGEST_NO = ? ";
		String sql2 = " DELETE FROM FIVE_SUGGEST WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		int[] count1= new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql1);
			System.out.println("1/9 sug_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				//int ref = sug_findRef(n);
				//System.out.println("n ="+n+", ref="+ref);
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 sug_delchkList success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 sug_delchkList success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql2);
			System.out.println("4/9 sug_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			count1 = psmt.executeBatch();
			System.out.println("5/9 sug_delchkList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 || count1[i] != -2) isS = false;
		}
		System.out.println("6/9 sug_delchkList success ");
		
		return isS;
	}
	
	public int sug_findRef(int seq) {
		String sql= " SELECT REF FROM FIVE_SUGGEST WHERE SEQ = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int ref = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 sug_findRef success ");
			
			psmt.setInt(1, seq);
			System.out.println("1/9 sug_findRef success ");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) ref = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return ref;
	}
	
	public boolean sugrep_delchkList(List<String> list) {
		String sql = " DELETE FROM FIVE_SUGGEST_COMMENT WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int[] count = new int[list.size()];
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 sugrep_delchkList success ");
			
			for(int i=0; i<list.size(); i++) {
				int n = Integer.parseInt(list.get(i));
				psmt.setInt(1,n);
				psmt.addBatch();
			}
			System.out.println("2/9 sugrep_delchkList success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 sugrep_delchkList success ");
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			DBClose.close(psmt, conn,null);
		}
		
		boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 ) isS = false;
		}
		System.out.println("4/9 sugrep_delchkList success ");
		
		return isS;
	}
	public ProductDto getProduct(int seq) {
		String sql = " SELECT * "
					+" FROM FIVE_CATEGORY "
					+" WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ProductDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getProduct success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getProduct success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getProduct success");
			
			if(rs.next()) {
				int i = 1;
				dto = new ProductDto(rs.getInt(i++),
									 rs.getString(i++),
									 rs.getString(i++),
									 rs.getString(i++),
									 rs.getString(i++),
									 rs.getInt(i++),
									 rs.getString(i++),
									 rs.getInt(i++),
									 rs.getInt(i++),
									 rs.getString(i));
			}
			System.out.println("4/6 getProduct success");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
}
