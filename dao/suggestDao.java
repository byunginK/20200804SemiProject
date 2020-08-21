package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import db.DBClose;
import db.DBConnection;
import dto.sug_AnswerDto;
import dto.suggestDto;


public class suggestDao {

	
	
	private static suggestDao dao = new suggestDao();

	private suggestDao() {
		DBConnection.initConnection();
	}

	public static suggestDao getInstance() {
		return dao;
	}

	public boolean writeBbs(suggestDto dto) {
		String sql = " INSERT INTO FIVE_SUGGEST " + " (SEQ, ID, REF, STEP, DEPTH, " + " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT) " + " VALUES( SEQ_FIVE_SUGGEST.NEXTVAL, ?, "
				+ " (SELECT NVL(MAX(REF), 0)+1 FROM FIVE_SUGGEST), 0, 0, " + " ?, ?, SYSDATE, " + " 0, 0)";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeBbs success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/6 writeBbs success");

			count = psmt.executeUpdate();
			System.out.println("3/6 writeBbs success");

		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {

			DBClose.close(psmt, conn, null);

		}
		return count > 0 ? true : false;
	}

	
	  public suggestDto getSuggest(int seq) { 
	 
         String sql =" SELECT SEQ, ID, REF, STEP, DEPTH, " 
                      + " TITLE, CONTENT, WDATE, " 
        		      + " DEL, READCOUNT " 
	  				   + " FROM FIVE_SUGGEST " 
	                   +" WHERE SEQ =? ";
	  
	  Connection conn = null; 
	  PreparedStatement psmt = null; 
	  
	  ResultSet rs = null;
	  
	  suggestDto dto = null;
	  
	  
	  try { 
      
	  conn = DBConnection.getConnection();
	  System.out.println("1/6 getDetailWrite success");
	  
	  psmt = conn.prepareStatement(sql);
	  System.out.println("2/6 getDetailWrite success");
	  
	  psmt.setInt(1, seq);
	  
	  rs = psmt.executeQuery();
	  
	  System.out.println("3/6 getDetailWrite success");
	  
	  if(rs.next()) {
			int i = 1;
			dto = new suggestDto(rs.getInt(i++), 
							rs.getString(i++), 
							rs.getInt(i++), 
							rs.getInt(i++), 
							rs.getInt(i++), 
							rs.getString(i++), 
							rs.getString(i++), 
							rs.getString(i++), 
							rs.getInt(i++), 
							rs.getInt(i++));
		}
	  } 
	  catch (Exception e) {
	   e.printStackTrace(); 
	  }finally { 
		   DBClose.close(psmt,conn, rs);
		   } 
	        return dto;
	        }
	 

	public void readcount(int seq) {
		
		String sql = "  UPDATE FIVE_SUGGEST "
				+ "	SET READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 readcount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);			
			System.out.println("2/6 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 readcount success");
			
		} catch (Exception e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);			
		}

		
	}
	
	public boolean answer(int seq, sug_AnswerDto bbs) {
	
				// insert
				String sql = " INSERT INTO FIVE_SUGGEST_COMMENT "
							+ " (SEQ, WRITER_ID, SUGGEST_NO, "
							+ "  CONTENT, WDATE, DEL ) "
							+ " VALUES(SEQ_FIVE_SUGGEST_COMMENT.NEXTVAL, ?, "
							+ "	 ?, ?, SYSDATE, 0 ) " ;
				
				Connection conn = null;
				PreparedStatement psmt = null;
				
				int count = 0;
				
				try {
					conn = DBConnection.getConnection();
					System.out.println("1/6 answer success");

					psmt = conn.prepareStatement(sql);
					System.out.println("2/6 answer success");
			
					// insert	
					psmt.setString(1, bbs.getAnswer_Id());
					psmt.setInt(2, seq);
					psmt.setString(3, bbs.getContent());
					System.out.println("3/6 answer success");
		
					count = psmt.executeUpdate();
					System.out.println("4/6 answer success");
					
				} catch (Exception e) {			
					e.printStackTrace();			
				} finally {			
					DBClose.close(psmt, conn, null);
					System.out.println("5/6 answer success");
				}
				return count>0?true:false;
			}
	
	public boolean deletesuggest(int seq) {
		
		String sql = " UPDATE FIVE_SUGGEST "
				     + " SET DEL=DEL+1 "
				     + " WHERE REF=? ";		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
	
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deletebbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
		
			System.out.println("2/6 deletebbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 deletebbs success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/6 deletebbs success");
		}
		
		
		return count>0?true:false;
	}
	
	
      public void suggestUpdate(String title, String content, int seq) {
		
		String sql = " UPDATE FIVE_SUGGEST "
				+ "	SET TITLE=? , CONTENT=?, WDATE=SYSDATE"
				+ " WHERE SEQ=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 readcount success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			System.out.println("2/6 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/6 readcount success");
			
		} catch (Exception e) {
			System.out.println("readcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);			
		}
	}
      
      //글의 갯수
      public int getALllBbs(String option, String select) {
		
    	  int co = 0;
    	  
  		  String sql = " SELECT COUNT(*) "
				        + " FROM FIVE_SUGGEST ";
  		  
    		String sqlword= "";
      		if(option.equals("all")) {
      			
      		 sqlword =  " WHERE DEL = 0 "
      		 		   + "  AND STEP= 0 "
      		 		    + " AND ID LIKE ? "
      					+ " OR TITLE LIKE ? "
      					+ " OR CONTENT LIKE ? " ;
      			
      			co = 1;
      		}
      		 if(option.equals("id")) {
      			
      			 sqlword = " WHERE ID LIKE ? AND DEL=0 AND STEP=0 ";
      		}
      		else if(option.equals("title")) {
      			
      			sqlword = " WHERE TITLE LIKE ? AND DEL=0 AND STEP=0 ";		
      		}else if(option.equals("content")) {
      			
      			sqlword =  " WHERE CONTENT LIKE ? AND DEL=0 AND STEP=0 ";
      		}
      		 
      		sql = sql + sqlword;
      		
      		
    		Connection conn = null;
    		PreparedStatement psmt = null;
    		ResultSet rs = null;
    		
    	int len = 0;
    	
    	
    	try {
    		conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			if(co==1) {
  				psmt.setString(1, "%"+select.trim()+"%");
  				psmt.setString(2, "%"+select.trim()+"%");
  				psmt.setString(3, "%"+select.trim()+"%");

  			
  			}else {
  			
  				psmt.setString(1, "%"+select.trim()+"%");
  				
  			}
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				len = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
    	return len;
	}
      
       
      public List<suggestDto> getSuggestList(String option, String select, int page) {
		
    	  int co = 0;
    	  
    		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, " 
		               + " TITLE, CONTENT, WDATE, " 
				       + " DEL, READCOUNT "
				       + " FROM ";
    		
    		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
    				"	SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT " + 
    				" FROM FIVE_SUGGEST";
    	
  		String sqlword= "";
  		if(option.equals("all")) {
  			
  		 sqlword =  " WHERE DEL = 0 "
  		 		    + " AND ID LIKE ? "
  					+ " OR TITLE LIKE ? "
  					+ " OR CONTENT LIKE ? " ;
  			
  			co = 1;
  		}
  		 if(option.equals("id")) {
  			
  			 sqlword = " WHERE ID LIKE ? AND DEL=0 ";
  		}
  		else if(option.equals("title")) {
  			
  			sqlword = " WHERE TITLE LIKE ? AND DEL=0";		
  		}else if(option.equals("content")) {
  			
  			sqlword =  " WHERE CONTENT LIKE ? AND DEL=0";
  		}
  		 
  		sql = sql + sqlword;
  		sql += " ORDER BY REF DESC, STEP ASC) ";
  		sql += " WHERE STEP =0 AND RNUM >= ? AND RNUM <= ? ";
  		
  		int start, end;
  		start = 1 + 10 * page;  // 시작 글의 번호
  		end = 10 + 10 * page;   // 끝 글의 번호
    	  
    	  
  		Connection conn = null;
  		PreparedStatement psmt = null;
  		ResultSet rs = null;

  		List<suggestDto> list = new ArrayList<suggestDto>();
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/6 getBbsList success");

  			
  			psmt = conn.prepareStatement(sql);
  			
  			if(co==1) {
  				psmt.setString(1, "%"+select.trim()+"%");
  				psmt.setString(2, "%"+select.trim()+"%");
  				psmt.setString(3, "%"+select.trim()+"%");
  				psmt.setInt(4, start);
  				psmt.setInt(5, end);
  			
  			}else {
  			
  				psmt.setString(1, "%"+select.trim()+"%");
  				psmt.setInt(2, start);
  				psmt.setInt(3, end);
  				
  			}
  			System.out.println("2/6 getBbsList success");

  			rs = psmt.executeQuery();
  			System.out.println("3/6 getBbsList success");

  			while (rs.next()) {
  				int i = 1;
  				suggestDto dto = new suggestDto(rs.getInt(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++),
  						rs.getInt(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getInt(i++),
  						rs.getInt(i++));
  				list.add(dto);
  			}
  			System.out.println("4/6 getBbsList success");
  		} catch (Exception e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			DBClose.close(psmt, conn, rs);
  		}
  		return list;
  	}
    
      // 답글 갯수
      public int getAllAnswer( int seq ) {
		
    	  String sql = " SELECT COUNT(*) "
    	  		        + " FROM FIVE_SUGGEST_COMMENT "
    	  	         	+ " WHERE SUGGEST_NO=?";
    	  Connection conn = null;
    	  PreparedStatement psmt = null;
    	  ResultSet rs = null;
    	  int count = 0;
    	  try {
    		conn= DBConnection.getConnection();
    		System.out.println("1/6 getAllAnswer success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getAllAnswer success");
			rs = psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("3/6 getAllAnswer success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("4/6 getAllAnswer success");
		}
    	return count;
	  
	}
      
      // 댓글 받아오기
      public List<sug_AnswerDto> getSu_AnswerList( int seq ) {
  		String sql = " SELECT SEQ, SUGGEST_NO, WRITER_ID, CONTENT, WDATE, DEL "
  				+ " FROM FIVE_SUGGEST_COMMENT "
  				+ " WHERE SUGGEST_NO=? "
  			    + " ORDER BY WDATE DESC ";

  		Connection conn = null;
  		PreparedStatement psmt = null;
  		ResultSet rs = null;

  		List<sug_AnswerDto> list = new ArrayList<sug_AnswerDto>();
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/6 getSu_AnswerList success");

  			psmt = conn.prepareStatement(sql);
  			psmt.setInt(1, seq);
  			System.out.println("2/6 getSu_AnswerList success");

  			rs = psmt.executeQuery();
  			System.out.println("3/6 getSu_AnswerList success");

  			while (rs.next()) {
  				int i = 1;
  				sug_AnswerDto dto = new sug_AnswerDto(rs.getInt(i++), rs.getInt(i++),  rs.getString(i++),
  						 rs.getString(i++), rs.getString(i++), rs.getInt(i++));
  				list.add(dto);
  			}
  			System.out.println("5/6 getSu_AnswerList success");
  		} catch (Exception e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			DBClose.close(psmt, conn, rs);
  			System.out.println("6/6 getSu_AnswerList success");
  		}
  		return list;
  	}
      
      
	  
      public boolean su_Answer_Delete( int seq ) {
		
    	  String sql = " UPDATE FIVE_SUGGEST_COMMENT "
				     + " SET DEL=DEL+1 "
				     + " WHERE SEQ=? ";		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 su_Answer_Delete success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
		
			System.out.println("2/6 su_Answer_Delete success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 su_Answer_Delete success");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/6 su_Answer_Delete success");
		}
		
		
		return count>0?true:false;
      }
      public List<sug_AnswerDto> getMyAnswerList( String id ){ 
    	  
    	  String sql = " SELECT SEQ, SUGGEST_NO, WRITER_ID, CONTENT, "
    	  		       + " WDATE, DEL "
    	  		       + " FROM FIVE_SUGGEST_COMMENT "
    	  		       + " WHERE WRITER_ID=? ";
    	  
    	  Connection conn = null;
    	  PreparedStatement psmt =null;
    	  ResultSet rs = null;
    	  List<sug_AnswerDto> list = new ArrayList<sug_AnswerDto>();
    	  try {
    		conn = DBConnection.getConnection();  
			System.out.println("1/6 getMyAnswerList success");

    		psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getMyAnswerList success");
				
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getMyAnswerList success");
			while (rs.next()) {
  				int i = 1;
  		sug_AnswerDto dto = new sug_AnswerDto(rs.getInt(i++), rs.getInt(i++),  rs.getString(i++),
  						                  rs.getString(i++), rs.getString(i++), rs.getInt(i++));
  				list.add(dto);
  			}
  			System.out.println("4/6 getMyAnswerList success");
  		} catch (Exception e) {
  			e.printStackTrace();
  		} finally {
  			DBClose.close(psmt, conn, rs);
  			System.out.println("5/6 getMyAnswerList success");
  		}
  		return list;  			  
      } 
      
      public boolean Su_Answer_Update( String content, int seq ) {
    	  String sql = " UPDATE FIVE_SUGGEST_COMMENT "
    	  		+ " SET CONTENT=?, WDATE= SYSDATE "
    	         + " WHERE SEQ=?";
    	  
    	  Connection conn =null;
    	  PreparedStatement psmt = null;
    	  int count = 0;
    	  try {
    		conn = DBConnection.getConnection();
    		System.out.println("1/6 Su_Answer_Update success");
    	    psmt = conn.prepareStatement(sql);
    	    psmt.setString(1, content);
    	    psmt.setInt(2, seq);
    	    System.out.println("2/6 Su_Answer_Update success");
    	    
    	    count = psmt.executeUpdate();
    	    System.out.println("3/6 Su_Answer_Update success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
			  System.out.println("4/6 Su_Answer_Update success");
		}
    	  return count>0?true:false;
      }
      
      
      
      public sug_AnswerDto Su_Answer_UpdateAf( int seq ) {
    	  String sql = " SELECT SEQ, SUGGEST_NO, WRITER_ID, CONTENT, WDATE, DEL "
    	  		+ " FROM FIVE_SUGGEST_COMMENT "
    	  		+ " WHERE SEQ=?";
    	  
    	  Connection conn = null;
    	  PreparedStatement psmt = null;
    	  ResultSet rs = null;
    	  
    	  sug_AnswerDto dto = null;
    	  
    	  try {
    		conn = DBConnection.getConnection();
			
    		psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			 rs = psmt.executeQuery();
			
			if(rs.next()) {
				 dto = new sug_AnswerDto(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
			}
    	  
    	  } catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
    	  return dto;
      }
}

















