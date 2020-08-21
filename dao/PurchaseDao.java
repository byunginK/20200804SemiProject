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
import dto.cartDto;

public class PurchaseDao {
private static PurchaseDao dao = new PurchaseDao();
	
	private PurchaseDao() {
		DBConnection.initConnection();
	}
	
	public static PurchaseDao getInstance() {
		return dao;
	}
	
	public boolean insertbuylist(String id, int item_seq, int qty, String color, String item_size) {
		String sql = " INSERT INTO FIVE_ORDER(SEQ, ID, ITEM_SEQ, QTY, COLOR, ITEM_SIZE) "
					+" VALUES(FIVE_ORDER_SEQ.NEXTVAL, ? , ? , ?, ?, ? ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertbuylist success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, item_seq);
			psmt.setInt(3, qty);
			psmt.setString(4, color);
			psmt.setString(5, item_size);
			System.out.println("2/6 insertbuylist success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertbuylist success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public cartDto getbuylist(int iseq) {
		String sql = " SELECT c.SEQ, c.ID, c.ITEM_SEQ, c.QTY, c.COLOR, c.ITEM_SIZE, g.P_NAME , g.P_PRICE, g.FILENAME "
					+" FROM FIVE_CART c , FIVE_CATEGORY g "
					+" WHERE c.ITEM_SEQ = g.SEQ AND c.SEQ = ? "
					+" ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		cartDto dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getbuylist success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, iseq);
			System.out.println("2/6 getbuylist success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int c_seq = rs.getInt("SEQ");
				String user = rs.getString("ID");
				int item_seq = rs.getInt("ITEM_SEQ");
				int qty = rs.getInt("QTY");
				String color = rs.getString("COLOR");
				String item_size = rs.getString("ITEM_SIZE");
				String name = rs.getString("P_NAME");
				int price = rs.getInt("P_PRICE");
				String filename = rs.getString("FILENAME");
				
				dto = new cartDto(c_seq, user, item_seq, name, price, qty, filename, color, item_size);
				
				
			}
			System.out.println("3/6 getbuylist success");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public boolean sellcount(int seq) {
		String sql = " UPDATE FIVE_CATEGORY "
					+" SET P_READCOUNT = (SELECT P_READCOUNT+1 FROM FIVE_CATEGORY WHERE SEQ = ?) "
					+" WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 sellcount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 sellcount success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 sellcount success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
	public List<ProductDto> getsellcountList(int cpage) {
		String sql = " SELECT SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" FROM (SELECT ROW_NUMBER()OVER(ORDER BY P_READCOUNT DESC) AS RNUM, SEQ, P_NAME, P_INFO ,P_MATERIAL, P_MADEIN, P_PRICE, P_CATEGORY, P_READCOUNT, P_KIND, FILENAME "
				+" 		 FROM FIVE_CATEGORY ) "
				+" WHERE  RNUM >=? AND RNUM <=? ";
		
		int start = cpage;
		int end = cpage + 7;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getsellcountList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/6 getsellcountList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getsellcountList success");
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
			System.out.println("4/6 getsellcountList success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public List<MyOrderDto> getMyOrderList(String id) {
		String sql = " SELECT o.SEQ, o.ID, o.ITEM_SEQ, o.QTY, o.COLOR, o.ITEM_SIZE, g.P_NAME , g.P_PRICE, g.FILENAME "
				+" FROM FIVE_ORDER o , FIVE_CATEGORY g "
				+" WHERE o.ITEM_SEQ = g.SEQ AND o.ID = ? "
				+" ORDER BY SEQ DESC ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MyOrderDto dto = null;
		List<MyOrderDto> list = new ArrayList<MyOrderDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getmyorderlist success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 getmyorderlist success");
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				dto = new MyOrderDto(rs.getInt(i++), 
										rs.getString(i++), 
										rs.getInt(i++), 
										rs.getInt(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++),
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
}
