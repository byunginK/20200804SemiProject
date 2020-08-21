package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.calendarDto;

public class calendarDao {

    private static calendarDao dao = new calendarDao();

    private calendarDao(){
    	DBConnection.initConnection();
    }

    public static calendarDao getInstance(){
        return dao;
    }

    public List<calendarDto> getdeList(String ym){
        String sql = " SELECT SEQ, CONTENTS,CALDATE FROM FIVE_CALENDAR WHERE SUBSTR(CALDATE,1,6) = ? ORDER BY SEQ DESC ";

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        List<calendarDto> list = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            System.out.println("1/9 getdeList success ");

            psmt.setString(1,ym);
            rs = psmt.executeQuery();
            System.out.println("2/9 getdeList success ");

            while(rs.next()){
                int i=1;
                int seq = rs.getInt(i++);
                String contents = rs.getString(i++);
                String cdate = rs.getString(i++);

                calendarDto dto = new calendarDto(seq,contents,cdate);
                list.add(dto);
            }
            System.out.println("3/9 getdeList success ");
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBClose.close(psmt, conn, rs);
        }
        return list;
    }
    public List<calendarDto> getdeAllList(String ymd){
        String sql = " SELECT SEQ, CONTENTS,CALDATE FROM FIVE_CALENDAR WHERE CALDATE = ? ORDER BY SEQ DESC ";

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        List<calendarDto> list = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            System.out.println("1/9 getdeAllList success ");

            psmt.setString(1,ymd);
            rs = psmt.executeQuery();
            System.out.println("2/9 getdeAllList success ");

            while(rs.next()){
                int i=1;
                int seq = rs.getInt(i++);
                String contents = rs.getString(i++);
                String cdate = rs.getString(i++);

                calendarDto dto = new calendarDto(seq,contents,cdate);
                list.add(dto);
            }
            System.out.println("3/9 getdeAllList success ");
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBClose.close(psmt, conn, rs);
        }
        return list;
    }
    public boolean addcalOne(calendarDto dto){
        String sql = " INSERT INTO FIVE_CALENDAR(SEQ, CONTENTS, CALDATE) " +
                "  VALUES(FIVE_CAL_SEQ.NEXTVAL ,?,?) ";

        Connection conn = null;
        PreparedStatement psmt = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            System.out.println("1/9 addcalOne success ");

            psmt.setString(1,dto.getContents());
            psmt.setString(2,dto.getCdate());
            System.out.println("2/9 addcalOne success ");

            count = psmt.executeUpdate();
            System.out.println("3/9 addcalOne success ");
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBClose.close(psmt, conn, null);
        }
        return count>0?true:false;
    }

    public boolean delcalOne(int seq) {
    	String sql = " DELETE FROM FIVE_CALENDAR WHERE SEQ = ? ";
    	
    	 Connection conn = null;
         PreparedStatement psmt = null;
         int count = 0;
         
         try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 delcalOne success ");
			
			psmt.setInt(1, seq);
			System.out.println("2/9 delcalOne success ");
			
			count = psmt.executeUpdate();
			System.out.println("3/9 delcalOne success ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
         return count>0?true:false;
    }
    
    public boolean updateCal(List<Integer> seqlist, List<String> contlist) {
    	String sql = " UPDATE FIVE_CALENDAR SET CONTENTS = ? WHERE SEQ = ? ";
    	
    	Connection conn = null;
        PreparedStatement psmt = null;
        int[] count = new int[seqlist.size()];
        
        try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/9 updateCal success ");
			
			for(int i=0; i<seqlist.size(); i++) {
				psmt.setString(1, contlist.get(i));
				psmt.setInt(2, seqlist.get(i));
				psmt.addBatch();
			}
			System.out.println("2/9 updateCal success ");
			
			count = psmt.executeBatch();
			System.out.println("3/9 updateCal success ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
        
        boolean isS = true;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] != -2 ) isS = false;
		}
		return isS;
    }
    
}
