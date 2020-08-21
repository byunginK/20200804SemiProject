package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.ReplyDto;
import dto.blistDto;

public class blistDao {

	private static blistDao dao = new blistDao();
	
	private blistDao() {
	}
	
	public static blistDao getInstance() {
		return dao;
	}
	public int getAllList() {
		String sql = " SELECT COUNT(*) FROM FIVE_QNA ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getlen success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 getlen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 getlen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public int getAllList(String need, String fneed) {
		String sql = " SELECT COUNT(*) FROM FIVE_QNA WHERE "+need+" LIKE ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int len = 0;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getlen success ");
			
			psmt.setString(1, "%"+fneed+"%");

			rs = psmt.executeQuery();
			System.out.println("2/9 getlen success ");
			
			if(rs.next()) len = rs.getInt(1);
			System.out.println("3/9 getlen success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	public List<blistDto> getbList(){
		String sql = " SELECT SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE FROM FIVE_QNA ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<blistDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 blist success ");
			
			rs = psmt.executeQuery();
			System.out.println("2/9 blist success ");
			
			while(rs.next()) {
				int i = 1;
				blistDto dto = new blistDto(rs.getInt(i++), rs.getString(i++),rs.getString(i++),
											rs.getInt(i++), rs.getString(i++),rs.getInt(i++), rs.getString(i++));
				list.add(dto);
			}
			System.out.println("3/9 blist success ");
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
			return list;
	}
	
	public List<blistDto> getbList(int pageNumber){
		String sql = " SELECT SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE " + 
				" FROM " + 
				" ( " + 
				" SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
				"	SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE " + 
				" FROM FIVE_QNA " + 
				" ORDER BY WDATE DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<blistDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getblist page success");
			
			psmt.setInt(1, pageNumber*10+1);
			psmt.setInt(2, pageNumber*10+10);
			rs = psmt.executeQuery();
			System.out.println("2/9 getblist page success");
			
			while(rs.next()) {
				int i=1;
				blistDto dto = new blistDto(rs.getInt(i++), rs.getString(i++),rs.getString(i++),
						rs.getInt(i++), rs.getString(i++),rs.getInt(i++), rs.getString(i++));
				list.add(dto);
			}
			System.out.println("3/9 getblist page success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public List<blistDto> getbList(int pageNumber,String need, String fneed){
		String sql = " SELECT SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE " + 
				" FROM " + 
				" ( " + 
				" SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, " + 
				"	SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE " + 
				" FROM FIVE_QNA " ;
		int fn = 0;
		
		if(!(need.equals("")) && !(need.equals("PART_SEQ")) ) {
			sql += " WHERE "+need+" LIKE ? ";
		}else if(need.equals("PART_SEQ")){
			sql += " WHERE "+need+" = ? ";
			fn = Integer.parseInt(fneed);
		}
		
		sql += " ORDER BY WDATE DESC " + 
				" ) " + 
				" WHERE ? <= RNUM AND RNUM <= ? ";
		
		//System.out.println("sql = "+sql);
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<blistDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getblist page3 success");

			if(!(need.equals("")) && !(need.equals("PART_SEQ")) ) {
				psmt.setString(1, "%"+fneed+"%");
				psmt.setInt(2, pageNumber*10+1);
				psmt.setInt(3, pageNumber*10+10);
			}else if(need.equals("PART_SEQ")){
				//System.out.println("sql = "+sql);
				psmt.setInt(1, fn);
				psmt.setInt(2, pageNumber*10+1);
				psmt.setInt(3, pageNumber*10+10);
			}else {
				psmt.setInt(1, pageNumber*10+1);
				psmt.setInt(2, pageNumber*10+10);
			}
			
			rs = psmt.executeQuery();
			System.out.println("2/9 getblist page3 success");
			
			while(rs.next()) {
				int i=1;
				//SEQ, TITLE, CONTENTS, PART_SEQ, ID, SECRET, WDATE 
				int seq = rs.getInt(i++);
				String title = rs.getString(i++);
				String contents = rs.getString(i++);
				int part_seq = rs.getInt(i++);
				String id = rs.getString(i++);
				int secret = rs.getInt(i++);
				String wdate = rs.getString(i++);
				
				/*
				 * if(secret==1) { title = "※작성자와 관리자만 확인할 수 있는 글입니다"; }
				 */
				if(title.length()>60) {
					title= title.substring(0, 60)+ "...";
				}
				blistDto dto = new blistDto(seq,title,contents,part_seq,id,secret,wdate);
				
				list.add(dto);
			}
			System.out.println("3/9 getblist page3 success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public List<blistDto> addPartName(List<blistDto> dto){
		String sql = " SELECT b.name FROM FIVE_QNA a LEFT OUTER JOIN FIVE_PART b ON a.part_seq = b.seq WHERE a.seq = ? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 addpartname success ");
			
			for(int i=0; i<dto.size(); i++) {
				psmt.setInt(1, dto.get(i).getSeq());
				
				rs = psmt.executeQuery();
				if(rs.next()) {
					String name = rs.getString(1);
					dto.get(i).setPart_name(name);
				}
			}
			System.out.println("2/9 addpartname success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public boolean writeOne(blistDto dto) {
		String sql = " INSERT INTO FIVE_QNA(SEQ, TITLE, ID, PART_SEQ, CONTENTS, SECRET, WDATE, UDATE ) "
				+ " VALUES (FIVE_QNA_SEQ.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE,SYSDATE ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 writeone success ");
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getId());
			psmt.setInt(3, dto.getPart_seq());
			psmt.setString(4, dto.getContents());
			psmt.setInt(5, dto.getSecret());
			System.out.println("2/9 writeone success ");
			
			count = psmt.executeUpdate();
			System.out.println("3/9 writeone success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public blistDto getDetailSecret(int seq) {
		String sql = " SELECT ID,SECRET FROM FIVE_QNA WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		blistDto dto = null;
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 detailsecret success ");
			
			psmt.setInt(1, seq);
			System.out.println("2/9 detailsecret success ");
			
			rs = psmt.executeQuery();
			System.out.println("3/9 detailsecret success ");
			
			if(rs.next()) {
				dto = new blistDto(rs.getString(1),rs.getInt(2));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public blistDto getDetailDto(int seq) {
		String sql = " SELECT a.seq, a.title, a.contents, b.name,a.id  " + 
				" FROM FIVE_QNA a " + 
				" LEFT OUTER JOIN FIVE_PART b on a.part_seq = b.seq " + 
				" WHERE a.SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		blistDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 detaildto success ");
			
			psmt.setInt(1, seq);
			System.out.println("2/9 detaildto success ");
			
			rs = psmt.executeQuery();
			System.out.println("3/9 detaildto success ");
			
			while(rs.next()) {
				int i=1;
				dto = new blistDto(rs.getInt(i++), rs.getString(i++), rs.getString(i++),rs.getString(i++),rs.getString(i++));
				
			}
			System.out.println("4/9 detaildto success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public blistDto getDetailDtoforUpdate(int seq) {
		String sql = " SELECT seq, title, contents,part_seq,id,secret  " + 
				" FROM FIVE_QNA  " + 
				" WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
	
		blistDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 detaildto success ");
			
			psmt.setInt(1, seq);
			System.out.println("2/9 detaildto success ");
			
			rs = psmt.executeQuery();
			System.out.println("3/9 detaildto success ");
			
			while(rs.next()) {
				int i=1;
				int bseq = rs.getInt(i++);
				String title =rs.getString(i++);
				String contents = rs.getString(i++);
				int part_seq =  rs.getInt(i++);
				String id =rs.getString(i++);
				int secret =  rs.getInt(i++);
				
				dto = new blistDto(bseq,title,contents,part_seq,id,secret);
			}
			System.out.println("4/9 detaildto success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public ReplyDto addrepOne(String id, int seq, String contents) {
		String sql = " INSERT INTO FIVE_REPLY(SEQ, QNA_SEQ, CATEGORY_SEQ, ID, WDATE, UDATE, SECRET, CONTENTS) "
				+ " VALUES(FIVE_REPLY_SEQ.NEXTVAL, ?, null, ?, SYSDATE, SYSDATE, 0, ? ) ";
		
		String sql1 = " SELECT SEQ, QNA_SEQ, ID, CONTENTS, WDATE FROM FIVE_REPLY WHERE QNA_SEQ = ? "
				+ " AND SEQ = (SELECT MAX(SEQ) FROM FIVE_REPLY WHERE QNA_SEQ = ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ReplyDto dto = null;
		//System.out.println("addrepone "+id+" seq = "+ seq+", contents"+contents);
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 addrepOne success ");
			
			psmt.setInt(1, seq);
			psmt.setString(2, id);
			psmt.setString(3, contents);
			System.out.println("2/9 addrepOne success ");
			
			psmt.executeUpdate();
			System.out.println("3/9 addrepOne success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql1);
			
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("4/9 addrepOne success ");
			
			rs = psmt.executeQuery();
			System.out.println("5/9 addrepOne success ");
			
			if(rs.next()) {
				int i=1;

				int rep_seq = rs.getInt(i++);
				int qna_seq = rs.getInt(i++);
				String rep_id = rs.getString(i++);
				String rep_contents = rs.getString(i++);
				String wdate = rs.getString(i++);
				dto = new ReplyDto(rep_seq,qna_seq,rep_id,rep_contents,wdate);
			}
			System.out.println("6/9 addrepOne success ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	public List<ReplyDto> getRepList(int seq){
		String sql = " SELECT SEQ, QNA_SEQ, ID, CONTENTS, WDATE FROM FIVE_REPLY WHERE QNA_SEQ = ? ORDER BY SEQ ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<ReplyDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getRepList page success");
			
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			System.out.println("2/9 getRepList page success");
			
			while(rs.next()) {
				int i=1;
				int rep_seq = rs.getInt(i++);
				int qna_seq = rs.getInt(i++);
				String rep_id = rs.getString(i++);
				String rep_contents = rs.getString(i++);
				String wdate = rs.getString(i++);
				
				ReplyDto dto = new ReplyDto(rep_seq,qna_seq,rep_id,rep_contents,wdate);
				list.add(dto);
			}
			
			System.out.println("3/9 getRepList page success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public boolean updateReply(int seq, int qna_seq,String contents) {
		String sql = " UPDATE FIVE_REPLY SET CONTENTS = ?, UDATE = SYSDATE WHERE QNA_SEQ = ? AND SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 updateReply success ");
			
			psmt.setString(1, contents);
			psmt.setInt(2,qna_seq );
			psmt.setInt(3, seq);
			System.out.println("2/9 updateReply success ");
			
			count = psmt.executeUpdate();
			System.out.println("3/9 updateReply success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return count>0?true:false;
	}
	
	public boolean delQnaOne(int seq) {
		String sql1 = " DELETE FROM FIVE_REPLY WHERE QNA_SEQ = ? ";
		String sql = " DELETE FROM FIVE_QNA WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql1);
			System.out.println("1/9 delQnaOne success ");
			
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			System.out.println("2/9 delQnaOne success ");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/9 delQnaOne success ");
			
			psmt.setInt(1, seq);
			count = psmt.executeUpdate();
			System.out.println("4/9 delQnaOne success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public boolean delRepOne(int seq) {
		String sql = " DELETE FROM FIVE_REPLY WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 delRepOne success ");
			
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			System.out.println("2/9 delRepOne success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public boolean updateQnaOne(int seq, String title, String contents, int part_seq, int secret ) {
		String sql = " UPDATE FIVE_QNA SET TITLE = ?, CONTENTS = ?, PART_SEQ = ?, SECRET = ? WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 updateQnaOne success ");
			
			psmt.setString(1, title);
			psmt.setString(2, contents);
			psmt.setInt(3, part_seq);
			psmt.setInt(4, secret);
			psmt.setInt(5, seq);
			System.out.println("2/9 updateQnaOne success ");
			
			count = psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public int getRepCount(int seq) {
		String sql = " SELECT COUNT(*) FROM FIVE_REPLY WHERE QNA_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getRepCount success ");
			
			psmt.setInt(1, seq);
			rs= psmt.executeQuery();
			System.out.println("2/9 getRepCount success ");
			
			if(rs.next()) count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return count;
	}
}
