package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dto.MemberDto;
import dto.loginDto;
import dto.suggestDto;
import net.sf.json.JSONObject;

@WebServlet("/login")
public class loginController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8"); req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession(); PrintWriter out = resp.getWriter();
		String work = req.getParameter("work"); MemberDao dao = MemberDao.getInstance();
		String id = req.getParameter("id");  String pwd = req.getParameter("pwd");
		
if(work.equals("logout")) {
	//로그아웃 
        session.removeAttribute("login_Id");
        session.removeAttribute("login_Dto");
        forward("FirstOpen.jsp", req, resp);
        
} else if(work.equals("updatePage")) {
	    //회원 정보 수정     	 
	MemberDto dto = (MemberDto)dao.login(id, pwd);
	    	  if(dto != null) {
	    		  req.setAttribute("dto", dto);
			      forward("main/MemUpdate.jsp", req, resp);
	    	  }else {
	    			out.print("<script>alert('비밀번호가 일치하지 않습니다.'); location.href ='main/myPageCheck.jsp?detailwork=update'</script>");
	    			out.flush();
	    	  }
     // System.out.println("아이디"+dto.getId());
}else if(work.equals("deleteMember")) {
	MemberDto dto = (MemberDto)dao.login(id, pwd);
	if(dto != null) {
		  req.setAttribute("dto", dto);
	      forward("main/MemDelete.jsp", req, resp);
	  }else {
			out.print("<script>alert('비밀번호가 일치하지 않습니다.'); location.href ='main/myPageCheck.jsp?detailwork=delete'</script>");
			out.flush();
	  }
}
else if(work.equals("MyPage")) {
	
	        int m_grade = dao.Mem_Grade(id);
	        req.setAttribute("m_grade", m_grade);
	        forward("main/MyPage.jsp", req, resp);
}else {
	
}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8"); req.setCharacterEncoding("utf-8");
		String id = req.getParameter("id"); String pwd = req.getParameter("pwd");
		HttpSession session = req.getSession();
		
		String a = "";

		MemberDao dao = MemberDao.getInstance();
		
		MemberDto dto = dao.login(id, pwd);
		
		MemberDto log = null;
		String lo_name = null;
		
		if(dto != null && !dto.getId().equals("")) {
	         	
			a = "YES";
		
			 log = new MemberDto(dto.getId(), dto.getAuth(), dto.getName(), dto.getEmail(), dto.getPhone());
			 lo_name = dto.getName();
			 
	    	session.setAttribute("login_Dto", log);
	    	session.setMaxInactiveInterval(30*60*60);
	            
	    //	System.out.println(lo_dto.getAuth());
		}else {	
				a = "NO";		
			}
		
		Map<Object, Object> map =  new HashMap<Object, Object>();

		map.put("isS", a);  map.put("name", lo_name);
		JSONObject jobj = new JSONObject();
		jobj.put("map", map);			
		
		resp.setContentType("application/x-json; charset=UTF-8");
		resp.getWriter().print(jobj);
	}
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);		
	}
	
}
