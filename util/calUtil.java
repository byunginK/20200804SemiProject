package util;

import java.util.List;

import dao.calendarDao;
import dto.calendarDto;

public class calUtil {
	
    public static String getcalList(int year,int month,int startday, int lastday){
        String ym = year+getTwo(month);
        String str ="";

        str += "<table id='caltb'> " +
                "    <col width='150'><col width='150'><col width='150'><col width='150'><col width='150'>" +
                "    <col width='150'><col width='150'><col width='150'>" +
                "    <tr> " +
                "        <td><a href='cal_main.jsp?year="+(year-1)+"&month="+month+"'> ◀◀ </a></td>" +
                "        <td><a href='cal_main.jsp?year="+year+"&month="+(month-1)+"'> ◀ </a></td>" +
                "        <th colspan='3' style='text-align:center;'>"+year+"년 "+getTwo(month+1)+"월</th>" +
                "        <td><a href='cal_main.jsp?year="+year+"&month="+(month+1)+"'> ▶ </a></td>" +
                "        <td><a href='cal_main.jsp?year="+(year+1)+"&month="+month+"'> ▶▶ </a></td>" +
                "    </tr>" +
                "    <tr>" +
                "        <th class='table-header'>일</th><th class='table-header'>월</th><th class='table-header'>화</th><th class='table-header'>수</th>" +
                "        <th class='table-header'>목</th><th class='table-header'>금</th><th class='table-header'>토</th>" +
                "    </tr>";

        str +="<tr>";
        for(int i=1; i<startday; i++){
            str +="<td> </td>";
        }
        int date = 1;
        for(int i=0; i<lastday; i++){
            str+=getList(ym,date);
            if( ((date+startday-1)%7) == 0 ){
                str+="</tr><tr>";
            }
            date++;
        }

        for(int i=0; i<(7-(startday+lastday-1)%7); i++){
            str+="<td> </td>";
        }
        str+="</tr>";
        str+="</table>";
        return str;
    }

    public static String getList(String ym, int date) {
        calendarDao dao = calendarDao.getInstance();
        List<calendarDto> list = dao.getdeList(ym);
        String str ="";
        int count = 0;
        String totd = ym+getTwo(date);
        str+="<td onclick='popfunc("+ym+getTwo(date)+")'><table id='intb'><col width='140'><tr style='height:20px'><th>"+getTwo(date) + "</th></tr>";
        str+="<tr><td style='height:80px'><ul style='list-style-type:none;'>";
        for(int i=0; i<list.size(); i++){
            if(list.get(i).getCdate().equals(totd) ){
                count++;
                str+="<li>"+getShort(list.get(i).getContents())+"</li>";
            }
            if(count>2){
                break;
            }
        }
        str +="</ul></td></tr></table></td>";

        return str;
    }
    public static String getTwo(int n){
    	String num = n+"";
        return (num.length()<2)?"0"+num:num+"";
    }

    public static String getShort(String str){
        if(str.length()>5){
            str = str.substring(0,5);
            str +="...";
        }
        return str;
    }
	
}









