package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InfoDao;
import dto.InfoDto;
import dto.MemberDto;
import dto.suggestDto;
import net.sf.json.JSONObject;

@WebServlet("/infomain")
public class infoController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String work = req.getParameter("work");
		 HttpSession session = req.getSession();
		 InfoDao dao = InfoDao.getInstance();
		 String id = "";
		 JSONObject obj = new JSONObject();
		
		 //메인
		if(work.equals("move")) {
			/*
			 * String id = req.getParameter("id"); System.out.println("id:" + id);
			 */
			
			//검색
			String searchWord = req.getParameter("searchWord");
			String choice = req.getParameter("choice");
			
			if(choice == null || choice.equals("")){
				choice = "sel";
			}
			//검색어를 지정하지 않고 choice가 넘어왔을 때
			if(choice.equals("sel")){
				searchWord = "";//null->""로 변경해줌(=new String())
			}
			if(searchWord == null){
				searchWord = "";
				choice = "sel";//select에서 "------선택"으로 돌아가기
			}
			
			//페이지 생성
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0;//현재페이지
			if(spageNumber != null && !spageNumber.equals("")){//하라미터가 넘어왔을때
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("pageNumber:"+pageNumber);
			
			List<InfoDto> list = dao.getBbsPagingList(choice, searchWord, pageNumber);
			
			//목록 리스트를 검색한것만 가져옴
			int len = dao.getAllBbs(choice, searchWord);
			//System.out.println("len:"+len);
			
			// 보내줄 데이터
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("choice", choice);
			req.setAttribute("searchWord", searchWord);
			req.setAttribute("pageNumber", pageNumber);
			// 이동
			forward("./info/infomain.jsp", req, resp);
		}
		
		//detail
		else if(work.equals("detail")) {
			//System.out.println("Hi");
			int seq = Integer.parseInt(req.getParameter("seq"));
			//System.out.println(seq);
			MemberDto mem = (MemberDto)session.getAttribute("loginDto");
        	//id = mem.getId();
        	id = (String) "a";
        	/*
        	if(id == null) {
				forward("login.jsp", req, resp);
			}else {*/
			 InfoDto dto = dao.getInfo(seq);
             req.setAttribute("dto", dto); 
             req.setAttribute("id", id);
             //잘가~
             forward("./info/infodetail.jsp", req, resp);
				
			//}
        	
        //수정
		}else if(work.equals("update")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			//System.out.println("update seq:"+seq);
			
			InfoDto dto = dao.getInfo(seq);
			req.setAttribute("dto", dto);
			
			forward("./info/infoupdate.jsp", req, resp);
			
		//수정완료
		}else if (work.equals("updateAf")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			//System.out.println("updateAf seq:"+seq);
			//System.out.println("title="+title);
			//System.out.println("content="+content);
			
			boolean isS = dao.updateBbs(seq, title, content);
			req.setAttribute("isS", isS);
			forward("./info/infoupdateAf.jsp", req, resp);
			
		//글쓰기	
		}else if (work.equals("write")) {
			id = req.getParameter("id");
			req.setAttribute("id", id);
			forward("./info/infowrite.jsp", req, resp);
			
		//글쓰기 완료
		}else if (work.equals("writeAf")) {
			id = (String)session.getAttribute("login_Id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			//System.out.println("writeAf id="+id);
			//System.out.println("writeAf title="+title);
			//System.out.println("writeAf content="+content);
			
			boolean isS = dao.writeBbs(new InfoDto(id, title, content));
			req.setAttribute("isS", isS);
			forward("./info/infowriteAf.jsp", req, resp);
			
			
		}else if (work.equals("search")) {
			String choice = req.getParameter("choice");
			String searchWord = req.getParameter("searchWord");
			//System.out.println("search choice="+choice);
			//System.out.println("search searchWord="+searchWord);
			
			int len = dao.getAllBbs(choice, searchWord);
			System.out.println("len:"+len);
			
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0;//현재페이지
			if(spageNumber != null && !spageNumber.equals("")){//하라미터가 넘어왔을때
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("search pageNumber:"+pageNumber);
			
			List<InfoDto> list = dao.getBbsPagingList(choice, searchWord, pageNumber);
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("choice", choice);
			req.setAttribute("searchWord", searchWord);
			req.setAttribute("pageNumber", pageNumber);
			
			forward("./info/infomain.jsp", req, resp);
			
		}else if (work.equals("pageList")) {
			String searchWord = req.getParameter("searchWord");
			String choice = req.getParameter("choice");
			
			//System.out.println("pageList choice="+choice);
			//System.out.println("pageList searchWord="+searchWord);
			
			if(choice == null || choice.equals("")){
				choice = "sel";
			}
			 
			//검색어를 지정하지 않고 choice가 넘어왔을 때
			if(choice.equals("sel")){
				searchWord = "";//null->""로 변경해줌(=new String())
			}
			if(searchWord == null){
				searchWord = "";
				choice = "sel";//select에서 "------선택"으로 돌아가기
			}
			
			int len = dao.getAllBbs(choice, searchWord);
			/*
			System.out.println("pageList2 len:"+len);
			System.out.println("pageList2 choice="+choice);
			System.out.println("pageList2 searchWord="+searchWord);
			*/
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0;//현재페이지
			if(spageNumber != null && !spageNumber.equals("")){//하라미터가 넘어왔을때
				pageNumber = Integer.parseInt(spageNumber);
			}
			//System.out.println("pageList pageNumber:"+pageNumber);
			
			List<InfoDto> list = dao.getBbsPagingList(choice, searchWord, pageNumber);
			
			obj.put("len",len);
			obj.put("list",list);
			
			resp.setContentType("application/x-json; charset=UTF-8;");
			resp.getWriter().print(obj);
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);		
	}
	
}