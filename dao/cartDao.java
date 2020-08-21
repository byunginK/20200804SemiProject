package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.cartDto;

public class cartDao {
	
	private static cartDao dao = new cartDao();
	
	private cartDao() {
	}
	
	public static cartDao getInstance() {
		return dao;
	}
	
	public List<cartDto> getList(String id){
		String sql = " SELECT A.SEQ, A.ID, B.SEQ, B.P_NAME, B.P_PRICE, A.QTY, B.FILENAME, A.COLOR, A.ITEM_SIZE " + 
				" FROM FIVE_CART A " + 
				" JOIN FIVE_CATEGORY B ON A.ITEM_SEQ = B.SEQ " + 
				" WHERE A.ID= ? ";
		
		List<cartDto> list = new ArrayList<>();
		Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
		
        try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 getList success");
			
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			System.out.println("2/9 getList success");
			
			while(rs.next()) {
				int i=1;
				int seq = rs.getInt(i++);
				String sid = rs.getString(i++);
				int item_seq = rs.getInt(i++);
				String item_name = rs.getString(i++);
				int item_price =rs.getInt(i++);
				int qty = rs.getInt(i++);
				String filename = rs.getString(i++);
				String color = rs.getString(i++);
				String size = rs.getString(i++);
				
				cartDto dto = new cartDto(seq,sid,item_seq,item_name,item_price,qty,filename,color,size);
				list.add(dto);
			}
			System.out.println("3/9 getList success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	public boolean updateQty(int seq, int qty) {
		String sql = " UPDATE FIVE_CART SET QTY = ? WHERE SEQ = ? ";
		Connection conn = null;
        PreparedStatement psmt = null;
        
        int count = 0;
        
        try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 updateQty success ");
			
			psmt.setInt(1, qty);
			psmt.setInt(2, seq);

			count = psmt.executeUpdate();
			System.out.println("2/9 updateQty success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
        
        return count>0?true:false;
	}
	
	public boolean deleteItem(List<String> list) {
		String sql = " DELETE FROM FIVE_CART WHERE SEQ = ?";
		
		Connection conn = null;
        PreparedStatement psmt = null;
        int[] count = new int[list.size()];
        
        try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 deleteItem success");
			
			for(int i=0; i<list.size(); i++) {
				int seq = Integer.parseInt(list.get(i));
				psmt.setInt(1,seq);
				psmt.addBatch();
			}
			System.out.println("2/9 deleteItem success");
			
			count = psmt.executeBatch();
			System.out.println("3/9 deleteItem success");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
        boolean b = true;
        
        for(int i=0; i<count.length; i++) {
			if(count[i] != -2 ) b = false;
		}
        return b;
	}
}
