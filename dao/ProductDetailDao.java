package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MyOrderDto;
import dto.ProductDto;
import dto.ReplyDto;
import dto.cartDto;

public class ProductDetailDao {

	private static ProductDetailDao dao = new ProductDetailDao();
	
	private ProductDetailDao() {
		DBConnection.initConnection();
	}
	
	public static ProductDetailDao getInstance() {
		return dao;
	}
	//상품 정보를 끌어오는 함수
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
	
	//리뷰 데이터들 가지고 오는 함수
	public List<ReplyDto> getReplyList(int category_seq, int page) {
		String sql = " SELECT SEQ, QNA_SEQ, ID, WDATE, SECRET, UDATE, CATEGORY_SEQ, CONTENTS "
					+" FROM (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, QNA_SEQ, ID, WDATE, SECRET, UDATE, CATEGORY_SEQ, CONTENTS "
					+"  		FROM FIVE_REPLY "	
					+" WHERE CATEGORY_SEQ = ? "
					+" ORDER BY SEQ DESC) "
					+" WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start,end;
		start = 1+5*(page-1);
		end = 5+5*(page-1);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<ReplyDto> list = new ArrayList<ReplyDto>();
					
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, category_seq);
			psmt.setInt(2, start);
			psmt.setInt(3, end);
			System.out.println("2/6 getReplyList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getReplyList success");
			while(rs.next()) {
				int i = 1;
				ReplyDto dto = new ReplyDto(rs.getInt(i++), 
									rs.getInt(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getInt(i++), 
									rs.getString(i++), 
									rs.getInt(i++), 
									rs.getString(i++));
				list.add(dto);
			}
			System.out.println("4/6 getReplyList success");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	//리뷰를 작성하면 추가하는 함수
	public boolean writeReview(String id, int category_seq, String contents) {
		String sql = " INSERT INTO FIVE_REPLY(SEQ, QNA_SEQ, ID, WDATE, SECRET, UDATE, CATEGORY_SEQ, CONTENTS) "
					+" VALUES(FIVE_REPLY_SEQ.NEXTVAL, null, ?, SYSDATE, 0, SYSDATE, ?, ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeReview success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, category_seq);
			psmt.setString(3, contents);
			System.out.println("2/6 writeReview success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 writeReview success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	//전체 리뷰개수를 구하는 함수
	public int getAllReview(int seq) {
		String sql = " SELECT COUNT(*) "
					+" FROM FIVE_REPLY "
					+" WHERE CATEGORY_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getAllReview success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getAllReview success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getAllReview success");
			
			if(rs.next()) {
				len = rs.getInt(1);
				
			}
			System.out.println("4/6 getAllReview success");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return len;
	}
	
	//제품 추가 함수
	public boolean insertProduct(ProductDto dto) {
		String sql = " INSERT INTO FIVE_CATEGORY(SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME) "
					+" VALUES(SEQ_PRODUCT.NEXTVAL, ?, ?, ?, ?, ?, ?, 0, ?, ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertProduct success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getP_name());
			psmt.setString(2, dto.getP_info());
			psmt.setString(3, dto.getP_material());
			psmt.setString(4, dto.getP_madeIn());
			psmt.setInt(5, dto.getP_price());
			psmt.setString(6, dto.getP_category());
			psmt.setInt(7, dto.getP_kind());
			psmt.setString(8, dto.getFilename());
			System.out.println("2/6 insertProduct success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertProduct success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	//다수 상품들 정보를 가져오는 함수 (카테고리 페이지에서 쓰임)
	public List<ProductDto> getProductList(int listNum, String category) {
		String sql = " SELECT SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" FROM (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" 		 FROM FIVE_CATEGORY  ";
		if(!category.equals("all")) {
			sql += " WHERE P_CATEGORY = '"+ category.trim()+"') ";
		}else {
			sql +=" ) ";
		}
				
		sql	+=" WHERE  RNUM >= ? AND RNUM <= ? ";
					
		
		int start = listNum;
		int end = listNum +7;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getProductList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 getProductList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getProductList success");
			
			while(rs.next()) {
				int i = 1;
				ProductDto dto = new ProductDto(rs.getInt(i++), 
						rs.getString(i++), 
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++), 
						rs.getInt(i++), 
						rs.getString(i++), 
						rs.getInt(i++), 
						rs.getInt(i++), 
						rs.getString(i));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	//같은 카테고리의 선택된 상품을 제외한 상품 데이터들을 가져오는 함수 (제품 상세페이지에서 제품들 리스트에 쓰임)
	public List<ProductDto> getplist(int seq, int listNum, String p_category) {
		String sql = " SELECT SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" FROM (SELECT ROW_NUMBER()OVER(ORDER BY SEQ DESC) AS RNUM, SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" 		 FROM FIVE_CATEGORY WHERE P_CATEGORY = ? AND SEQ != ? ) "
				+" WHERE  RNUM >=? AND RNUM <=? ";
				
	
		int start = listNum;
		int end = listNum +2;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getplist success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, p_category);
			psmt.setInt(2, seq);
			psmt.setInt(3, start);
			psmt.setInt(4, end);
			
			System.out.println("2/6 getplist success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getplist success");
			
			while(rs.next()) {
				int i = 1;
				ProductDto dto = new ProductDto(rs.getInt(i++),
						 			rs.getString(i++),
						 			rs.getString(i++),
						 			rs.getString(i++),
						 			rs.getString(i++),
						 			rs.getInt(i++),
						 			rs.getString(i++),
						 			rs.getInt(i++),
						 			rs.getInt(i++),
						 			rs.getString(i));
				list.add(dto);
			}
			System.out.println("4/6 getplist success");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	//제품 수정을 위해 쓰임
	public boolean updateProduct(ProductDto dto) {
		String sql = " UPDATE FIVE_CATEGORY "
					+" SET P_NAME = ? , P_INFO = ? ,P_MATERIAL = ?, P_MADEIN = ? , P_PRICE = ?, P_CATEGORY = ?, P_KIND = ?, FILENAME = ? "
					+" WHERE SEQ = ? ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateProduct success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getP_name());
			psmt.setString(2, dto.getP_info());
			psmt.setString(3, dto.getP_material());
			psmt.setString(4, dto.getP_madeIn());
			psmt.setInt(5, dto.getP_price());
			psmt.setString(6, dto.getP_category());
			psmt.setInt(7, dto.getP_kind());
			psmt.setString(8, dto.getFilename());
			psmt.setInt(9, dto.getSeq());
			System.out.println("2/6 updateProduct success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateProduct success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	public boolean insertcart(String id, int item_seq, int qty, String color, String item_size) {
		String sql = " INSERT INTO FIVE_CART(SEQ, ID, ITEM_SEQ, QTY, COLOR, ITEM_SIZE) "
					+" VALUES(FIVE_CART_SEQ.NEXTVAL, ? , ? , ?, ?, ? ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertCart success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, item_seq);
			psmt.setInt(3, qty);
			psmt.setString(4, color);
			psmt.setString(5, item_size);
			System.out.println("2/6 insertCart success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertCart success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
}
