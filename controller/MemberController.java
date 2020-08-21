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
import net.sf.json.JSONObject;

@WebServlet("/member")
public class MemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8"); req.setCharacterEncoding("utf-8");
	    String work = req.getParameter("work");  String email = req.getParameter("email");
		String id = req.getParameter("id");  String pwd = req.getParameter("pwd");
		Map<Object, Object> map =  new HashMap<Object, Object>(); JSONObject jobj = new JSONObject();
		  //관리자 1, 일반 3
		
	//	System.out.println("아뒤: "+id); System.out.println("비번: "+pwd); System.out.println("이름: "+name); System.out.println("전번: "+phone); System.out.println("이메: "+email);
		MemberDao dao = MemberDao.getInstance();
		String a = ""; boolean isS = true;

		if(work.equals("id_Check")){
			//  회원 가입시 아이디 중복확인 ajax
				 isS =dao.CheckId(id);
				
					if(isS == true){	// id가 없음
				     
						a = "YES";
				
					}else if((isS == false)){			// id가 있음
					
						a = "NO";
						}
						
				map.put("isS", a);
				jobj.put("map", map);			
				resp.setContentType("application/x-json; charset=UTF-8");
				resp.getWriter().print(jobj);
		}
		
		else if(work.equals("id_Find")) {
			String f_email = dao.find_Id(email);
			if(f_email =="") {
				f_email = "no";
			}
			map.put("f_email", f_email);
			jobj.put("map", map);			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
			
		}else if(work.equals("pwd_Find")) {
			String f_pwd = dao.find_Pwd(id,email);
			if(f_pwd =="") {
				f_pwd = "no";
			}
			map.put("f_pwd", f_pwd);
			jobj.put("map", map);			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
		}else {
			
		}
}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8");req.setCharacterEncoding("utf-8");  PrintWriter out = resp.getWriter();
		String work = req.getParameter("work"); String id = req.getParameter("id"); int auth = 3;
		String name = req.getParameter("name"); String sphone = req.getParameter("phone");
		String email = req.getParameter("email"); String pwd = req.getParameter("pwd");
		MemberDao dao = MemberDao.getInstance(); HttpSession session = req.getSession(); boolean isS = true; 
	//	System.out.println(id);	
		
		if(work.equals("addMem")) {
			int phone = Integer.parseInt(sphone); 
			 isS = dao.addMember(new MemberDto(id, pwd, name, phone, email, auth));
			if(isS) {	
				//회원가입 성공
				out.print("<script> alert('회원이 돼주셔서 감사합니다'); location.href = 'main/login.jsp';</script>");
				out.flush(); 
			}else {
				//회원가입 실패
				out.print("<script> alert('회원가입에 실패했습니다. 해당 현상이 지속되면 문의해주세요(문의전화 02-233-5555)'); location.href = 'addPro?work=main';</script>");
				out.flush();
			}	
		}
		else if(work.equals("MemberUpdate")) {
	
			 int phone = Integer.parseInt(req.getParameter("phone"));
			 String new_pwd ="";
			// System.out.println(new_pwd); System.out.println(pwd);	 
	  if(req.getParameter("new_pwd") != null && !req.getParameter("new_pwd").equals("")){
				new_pwd = req.getParameter("new_pwd");
				 isS = dao.update_Member(new MemberDto( id, new_pwd, name, phone, email));	
	 }else {
				isS = dao.update_Member(new MemberDto( id, pwd, name, phone, email));	
			} 
	      if(isS) {
			       out.print("<script> alert('정보수정에 성공했습니다.'); location.href = 'addPro?work=main';</script>");
			       out.flush();
	      }else {
		          out.print("<script> alert('정보수정에 실패했습니다. 해당 현상이 지속되면 문의해주세요(문의전화 02-233-5555)'); location.href = 'addPro?work=main';</script>"); out.flush(); 
		     }		
		 }

else if(work.equals("deleteMem")) {
	 // 구매내역
	int order_c = dao.order_Count(id);
    if(order_c > 0) {
	    out.print("<script> alert('구매 중인 제품이 있습니다. 확인 부탁드립니다.'); location.href ='addPro?work=main';</script>");    
	    out.flush();
    }else {
	     dao.DeleteMem(id);
	    session.removeAttribute("login_Dto"); 
	    out.print("<script> alert('성공적으로 탈퇴 처리되었습니다.'); location.href ='main/MemDeleteAf.jsp';</script>");    
		out.flush();
   }
  
	
   }	
		
	}
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);		
	}
	
}
