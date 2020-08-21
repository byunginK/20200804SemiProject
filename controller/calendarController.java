package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.calendarDao;
import dto.calendarDto;
import net.sf.json.JSONObject;

@WebServlet("/calcont")
public class calendarController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("calendarController doGet");
		
		req.setCharacterEncoding("UTF-8");
		String work = req.getParameter("work");
		JSONObject obj = new JSONObject();
		
		if(work.equals("wmove")) {
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String date = req.getParameter("date");
			
			req.setAttribute("year", year);
			req.setAttribute("month", month);
			req.setAttribute("date", date);
			forward("./calendar/cal_write.jsp",req,resp);
		}else if(work.equals("addCal")) {
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String date = req.getParameter("date");
			String contents = req.getParameter("contents");
			
			calendarDto dto = new calendarDto(contents,year+month+date);
			calendarDao dao = calendarDao.getInstance();
			boolean b = dao.addcalOne(dto);
			
			obj.put("b", b);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("delCal")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			calendarDao dao = calendarDao.getInstance();
			boolean b = dao.delcalOne(seq);
			
			obj.put("b", b);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("upCal")) {
			String upstr = req.getParameter("upstr");
			String[] flist = upstr.split("/");
			List<Integer> seqlist = new ArrayList<>();
			List<String> contlist = new ArrayList<>();
			for(int i=0; i<flist.length; i++) {
				String[] s = flist[i].split(",");
				seqlist.add(Integer.parseInt(s[0]));
				contlist.add(s[1]);
				//System.out.println(seqlist.get(i)+"&"+contlist.get(i));
			}
			calendarDao dao = calendarDao.getInstance();
			boolean b = dao.updateCal(seqlist, contlist);
			
			obj.put("b", b);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	public void forward(String link,HttpServletRequest req, HttpServletResponse resp) {
		RequestDispatcher dispatcher = req.getRequestDispatcher(link);
		try {
			dispatcher.forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
