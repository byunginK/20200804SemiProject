package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.InfoDto;

public class InfoDao {
	private static InfoDao dao = new InfoDao();
	
	public InfoDao() {
	}
	public static InfoDao getInstance() {
		return dao;
	}
	
	//(글 목록) LIST 가져오기
	public List<InfoDto> getBbsList() {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE "
					+ " FROM FIVE_INFO "
					+ " ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<InfoDto> list = new ArrayList<InfoDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList success");

			while(rs.next()) {
				int i = 1;
				InfoDto dto = new InfoDto(rs.getInt(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++));
				list.add(dto);
			}
			System.out.println("4/6 getBbsList success");

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	
	//글 추가 하기
	public boolean writeBbs(InfoDto dto) {
		//첫글 게시 할 때 REF의 최고값이 0이므로 +1, SEQ와 값이 같아짐
		String sql = " INSERT INTO FIVE_INFO "
					+ " (SEQ, ID, TITLE, CONTENT, WDATE) "
					+ " VALUES( SEQ_FIVE_INFO.NEXTVAL, ?, ?, ?, SYSDATE) ";
		
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	
	//seq로 dto가져오기
	public InfoDto getInfo(int seq) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE "
				+ " FROM FIVE_INFO "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		InfoDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto = new InfoDto();
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setWdate(rs.getString("WDATE"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	
	//업데이트
	public boolean updateBbs(int seq, String title, String content) {

		String sql = " UPDATE FIVE_INFO SET TITLE=? , "
						+ " CONTENT=? "
						+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;	
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeBbs success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			System.out.println("2/6 writeBbs success");

			count = psmt.executeUpdate();
			System.out.println("3/6 writeBbs success");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
		
	}


	//목록 오버라이딩 select
	public List<InfoDto> getBbsList(String choice, String searchWord) {
			
			String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE "
							+ " FROM FIVE_INFO "
							+ " ORDER BY SEQ DESC ";
						
			String sqlWord = "";//아래 조건들이 다 안맞을경우 ""로 들어감
			if (choice.equals("title")) {
				sqlWord = "	WHERE TITLE LIKE '%" + searchWord.trim() + "%' ";
				//del=0은 del이 지워지지 않았을 떄
			}else if (choice.equals("writer")) {//작성자명은 포함(중복)이 아닌 동일시 
				sqlWord = " WHERE ID='" + searchWord.trim() + "'";
			}else if (choice.equals("content")) {
				sqlWord = "	WHERE CONTENT LIKE '%" + searchWord.trim() + "%' ";
			}
			sql = sql + sqlWord;
			sql += " ORDER BY WDATE DESC ";
			
			
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<InfoDto> list = new ArrayList<InfoDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 getBbsList success");

				psmt = conn.prepareStatement(sql);
				System.out.println("2/6 getBbsList success");

				rs = psmt.executeQuery();
				System.out.println("3/6 getBbsList success");

				while(rs.next()) {
					int i = 1;
					InfoDto dto = new InfoDto(rs.getInt(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++),
											rs.getString(i++));
					list.add(dto);
				}
				System.out.println("4/6 getBbsList success");

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			return list;
		}


	//검색한 글의 모든 갯수
	public int getAllBbs(String choice, String searchWord) {
		
		String sql = " SELECT COUNT(*) FROM FIVE_INFO"; 	
		
		String sqlWord = "";
		if (choice.equals("title")) {
			sqlWord = " WHERE TITLE LIKE '%" + searchWord.trim() + "%' ";
		}else if (choice.equals("writer") && !searchWord.equals("")) {
			sqlWord = " WHERE ID='" + searchWord.trim() + "'";
		}else if (choice.equals("content")) {
			sqlWord = " WHERE CONTENT LIKE '%" + searchWord.trim() + "%' ";
		}
		sql += sqlWord;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
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
	
	
	//페이징 
	public List<InfoDto> getBbsPagingList(String choice, String searchWord, int page) {
	
			/*
			 	1. row 번호
			 	2. 검색
			 	3. 정렬
			 	4. 범위설정 1~10까지
			 */
			String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE "
					+ " FROM ";
			
			sql += "(SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC ) AS RNUM, " + 
						" SEQ, ID, TITLE, CONTENT, WDATE " + 
						" FROM FIVE_INFO ";
			
			  String sqlWord = "";
			  if (choice.equals("title")) {
				  sqlWord = " WHERE TITLE LIKE '%" + searchWord.trim() + "%' ";
			  }else if(choice.equals("writer")) {
				  sqlWord = " WHERE ID='" + searchWord.trim() + "'"; 
			  }else if(choice.equals("content")) { 
				  sqlWord = " WHERE CONTENT LIKE '%" +searchWord.trim() + "%' "; 
			  } 
			  sql = sql + sqlWord; 
			
			  sql += " ORDER BY SEQ DESC ) ";
			  sql += " WHERE RNUM >=? AND RNUM <= ?";
			  
			 int start, end;
			  start = 1 + (10 * page);
			  end = 10 + (10 * page);
			
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<InfoDto> list = new ArrayList<InfoDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 getBbsList success");

				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
				System.out.println("2/6 getBbsList success");

				rs = psmt.executeQuery();
				System.out.println("3/6 getBbsList success");

				while(rs.next()) {
					int i = 1;
					InfoDto dto = new InfoDto(rs.getInt(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++));
					list.add(dto);
				}
				System.out.println("4/6 getBbsList success");

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBClose.close(psmt, conn, rs);
			}
			return list;
		}

}