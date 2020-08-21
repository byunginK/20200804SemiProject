package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.CookieStore;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.suggestDao;
import dto.MemberDto;
import dto.loginDto;
import dto.sug_AnswerDto;
import dto.suggestDto;
import net.sf.json.JSONObject;

@WebServlet("/suggest")
public class suggestionController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8"); req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession(); PrintWriter out = resp.getWriter();
		String detailwork = req.getParameter("detailwork"); String work = req.getParameter("work");
		JSONObject jobj = new JSONObject();   
		  
		  String id = null; int auth = 3;
	      MemberDto login_Dto = null;
	       if(session.getAttribute("login_Dto") != null){
	    	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
	    	   id = login_Dto.getId(); auth = login_Dto.getAuth();
	       }
		
if(work.equals("suggest")) {
	
	// suggest 리스트 호출 할때 필요한 기본 데이터  준비 시작
	suggestDao dao = suggestDao.getInstance();
	     String sseq = req.getParameter("seq"); 
   		 String option = req.getParameter("option");
   		 String text = req.getParameter("text");
   		 String spageNumber = req.getParameter("pageNumber");
     		
          	if(option == null||option.equals("")){
				option = "all";
		    }	
		     if(text == null||text.equals("")){
		    	text = "";   option = "all";
		    }
		     int len = dao.getALllBbs(option, text);
			int pageNumber = 0; // 현재 페이지
	        if(spageNumber != null && !spageNumber.equals("")){
				 pageNumber = Integer.parseInt(spageNumber);
				}
	        
			// System.out.println(pageNumber);
			List<suggestDto> list = dao.getSuggestList(option, text, pageNumber);
			 for(int i =0; i < list.size();i++) {
				 suggestDto sdto = list.get(i);
				    int sq = sdto.getSeq();
		        	          
			 }
			 int allPage = len / 10 ;    
	        if(len% 10> 0){  allPage = allPage +1;  }
			     int endPage = pageNumber+5;
		int pagingBlock = allPage/5;
		int stpn = 0;
		if(pagingBlock > 1) {
			stpn = pagingBlock*5;
		}
   if(detailwork.equals("suggest_main")) {
	   //suggest 메인 화면 
	   req.setAttribute("pagingBlock", pagingBlock); req.setAttribute("stpn", stpn);		 
	   req.setAttribute("allPage", allPage);   req.setAttribute("endPage", endPage); req.setAttribute("pageNumbers", pageNumber); req.setAttribute("suggestList", list);
	   forward("./board/suggest_main.jsp", req, resp);} 
   
   else if(detailwork.equals("paging")){
	   // suggest 페이징 ajax
	   // suggest 클릭시 글 상세화면
		  
				//로그인 여부 확인 
	         
		HashMap<String, Object> map = new HashMap<String, Object>();
				  
	    map.put("suggestList", list); map.put("endPage", endPage); map.put("startPage",pageNumber);map.put("stpn", stpn);
	    map.put("pagingBlock", pagingBlock); map.put("endPage", endPage); map.put("allPage", allPage);   
		jobj.put("map", map);		
		resp.setContentType("application/x-json; charset=UTF-8");
	    resp.getWriter().print(jobj); 
	 
   }
 else if(detailwork.equals("suggest_detail")) {   
		  // suggest 클릭시 글 상세화면
	  
				//로그인 여부 확인 
	          if(id == null) {
	        	  
	            out.print("<script> let result = confirm('로그인이 필요한 페이지입니다.  로그인페이지로 이동하시겠습니까?'); if(result){location.href = 'main/login.jsp';} else{alert('로그인후 이용해주세요'); location.href = 'suggest?work=suggest&detailwork=suggest_main';}</script>");
				out.flush(); 
				}
			  else {
				   
                int seq = Integer.parseInt(sseq);
             // 저장된 쿠키 불러오기
            	Cookie[] cookieFromRequest = req.getCookies();
            	String cookieValue = null;
            	for(int i = 0 ; i<cookieFromRequest.length; i++) {
            		// 요청정보로부터 쿠키를 가져온다.
            		cookieValue = cookieFromRequest[0].getValue();
            	}
             	// 쿠키 세션 입력
            	if (session.getAttribute(sseq+":cookie") == null) {
            	 	session.setAttribute(sseq+":cookie", sseq + ":" + cookieValue);
            	} else {
            		session.setAttribute(sseq+":cookie ex", session.getAttribute(sseq+":cookie"));
            		if (!session.getAttribute(sseq+":cookie").equals(sseq + ":" + cookieValue)) {
            		 	session.setAttribute(sseq+":cookie", sseq + ":" + cookieValue);
            		}
            	}
             	
             	// 조회수 카운트
             	if (!session.getAttribute(seq+":cookie").equals(session.getAttribute(seq+":cookie ex"))) {
            	 	// 가시적으로  조회수 1 추가해줌
            	 	dao.readcount(seq);
             	}
             	//게시글 상세 정보
             	suggestDto dto = dao.getSuggest(seq);
             	//댓글 갯수
             	int answer = dao.getAllAnswer(seq);
             	//댓글 리스트
             	List<sug_AnswerDto> a_list = dao.getSu_AnswerList(seq);
	        // 상세화면으로 전송
             	req.setAttribute("a_list", a_list);
             	req.setAttribute("answerCount", answer);
				req.setAttribute("suggest_dto", dto); 
                forward("./board/suggestDetail.jsp", req, resp);
              
			  }
	          }
	 
 else if(detailwork.equals("writeIdcheck")) {  
	 
		   //로그인 여부 체크
	 
		   if(id == null) {  
			   
			out.print("<script> let result = confirm('로그인이 필요한 페이지입니다.  로그인페이지로 이동하시겠습니까?'); if(result){location.href = 'main/login.jsp';} else{alert('로그인후 이용해주세요'); location.href = 'suggest?work=suggest&detailwork=suggest_main';}</script>");
			out.flush();
		   }else {   
			   
			   //글 작성화면으로 전송
		    	forward("./board/suggestwrite.jsp?id="+id, req, resp);  
		    	} 
}else {
	// 오류시 메인으로
	forward("index.jsp", req, resp);
				}
				
				}
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
   req.setCharacterEncoding("utf-8");  resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/html; charset=UTF-8");

     String work= req.getParameter("work"); String detailwork= req.getParameter("detailwork"); 
	String sseq = req.getParameter("seq"); String title = req.getParameter("title"); String content = req.getParameter("content"); String id = req.getParameter("id");
		PrintWriter out = resp.getWriter();
		
if(work.equals("suggest")) {	
		suggestDao dao = suggestDao.getInstance();   
	if(detailwork.equals("suggest_write")) {
  	
		//글 작성시 오류 체크
	        boolean isS = dao.writeBbs(new suggestDto(id, title, content));
	        if(isS){ 
	        	 out.print("<script> alert('글이 등록되었습니다'); location.href = 'suggest?work=suggest&detailwork=suggest_main';</script>");
	        	 out.flush();
	       }else{
	    	     out.print("<script>alert('등록에 실패했습니다'); location.href = 'suggest?work=suggest&detailwork=suggest_main';</script>");
	             out.flush();
	       }    
		 }
	else if(detailwork.equals("suggest_delete")) {
		
		// 삭제 여부 확인 후 삭제
		         int seq = Integer.parseInt(sseq);
		         dao.deletesuggest(seq);
		         out.print("<script>alert('삭제되었습니다'); location.href = 'suggest?work=suggest&detailwork=suggest_main';</script>");
                 out.flush();
 
	}else if(detailwork.equals("suggest_update")) {
		
		//수정 여부 확인 후 삭제
				 int seq = Integer.parseInt(sseq);
				 dao.suggestUpdate(title, content, seq);
				 out.print("<script>alert('수정이 완료되었습니다.'); location.href = 'suggest?work=suggest&detailwork=suggest_main';</script>");
		         out.flush();
		 }
	else if(detailwork.equals("suggest_answer")) {
	      // 댓글 작성시 바로 뿌려줄 데이턴
	         int count = 0;
	         int seq = Integer.parseInt(sseq);
	         boolean isS = dao.answer(seq, new sug_AnswerDto(seq,id,content));
	         if(isS) {
	        	   count = dao.getAllAnswer(seq);
	        	   System.out.println(count);
	        	   List<sug_AnswerDto> list = dao.getSu_AnswerList(seq); 
	        
	        	 HashMap<String, Object> map = new HashMap<String, Object>();
	        	 map.put("answerList", list); map.put("answerCount", count);
	        	
	        	 JSONObject jobj = new JSONObject();
	     		jobj.put("map", map);			
	     		resp.setContentType("application/x-json; charset=UTF-8");
	     	     resp.getWriter().print(jobj); 
	         }else {
	        	 out.print("<script>alert('오류....하...'); location.href = 'suggest?work=suggest&detailwork=suggest_main'</script>");
	        	 out.flush();
	         }
}
	else if(detailwork.equals("answer_delete")) {
		 //댓글 삭제         
        int seq = Integer.parseInt(sseq);
        int a_seq = Integer.parseInt(req.getParameter("a_seq"));
        boolean isS = dao.su_Answer_Delete(a_seq);
        
        if(isS) {
        	out.print("<script>alert('삭제되었습니다'); location.href='suggest?work=suggest&detailwork=suggest_detail&seq="+ seq +"';</script>");
        	
        }else {
        	out.print("<script>alert('오류....하...'); location.href='suggest?work=suggest&detailwork=suggest_detail&seq="+ seq +"';</script>");
        }
		
	}
	else if(detailwork.equals("Update_Su_Answer")) {
		int seq = Integer.parseInt(sseq);
		boolean isS =  dao.Su_Answer_Update(content, seq);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(isS) {
		   sug_AnswerDto dto = dao.Su_Answer_UpdateAf(seq);	
			
			map.put("isS", isS); map.put("dto", dto);
			JSONObject jobj = new JSONObject();
     		jobj.put("map", map);			
     		resp.setContentType("application/x-json; charset=UTF-8");
     	     resp.getWriter().print(jobj); 
			
		}else {
			
		}
		
	}
	}
	}
	
	public void forward(String link, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher(link);
		dis.forward(req, resp);		
	}
}