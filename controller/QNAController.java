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

import dao.blistDao;
import dto.ReplyDto;
import dto.blistDto;
import net.sf.json.JSONObject;

@WebServlet("/qnacont")
public class QNAController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		System.out.println("qnacont get");
		JSONObject obj = new JSONObject();
		String work = req.getParameter("work");
		String id ="";
		
		if(work.equals("getlist")) {
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			//System.out.println("받아오냐고~~~~ "+pageNumber);
			//System.out.println("받아온거 = "+pageNumber +" "+need+" "+fneed);
			
			blistDao dao = blistDao.getInstance();
			List<blistDto> list = dao.getbList(pageNumber,need,fneed);
			list = dao.addPartName(list);
		//	String str = makeHtmlList(list);
			
			for(int i=0; i<list.size(); i++) {
				int seq = list.get(i).getSeq();
				int count = dao.getRepCount(seq);
				if(count != 0) {
					list.get(i).setTitle(list.get(i).getTitle()+"        답글("+count+")");
				}
			}
			
			int len =0;
			if(need != null && !need.equals("")) {
				len = dao.getAllList(need,fneed);
			}else {
				len = dao.getAllList();
			}
			
			//System.out.println("cont = "+need +" ,fneed= "+fneed+" len ="+len+" listlen = "+list.size());
		
			obj.put("len", len);
			obj.put("list", list);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);

		}else if(work.equals("wmove")) {
			id = req.getParameter("id");
			resp.sendRedirect("./board/qna_write.jsp?id="+id);
		}else if(work.equals("addone")) {
			id = req.getParameter("id");
			String title = req.getParameter("title");
			String contents = req.getParameter("contents");
			int part = Integer.parseInt(req.getParameter("part"));
			int secret = req.getParameter("secret").equals("true")?1:0;
			
			//System.out.println("addone cont = "+id+" "+title+" "+contents+" "+part+" "+secret);
			
			blistDto dto = new blistDto(title,contents,part,id,secret);
			blistDao dao = blistDao.getInstance();
			boolean b = dao.writeOne(dto);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("dmove")) {
			String sseq = req.getParameter("seq");
			id = req.getParameter("id");
			int seq = Integer.parseInt(sseq);
			String sauth = req.getParameter("auth");
			int auth = Integer.parseInt(sauth);
			
			blistDao dao = blistDao.getInstance();
			blistDto sdto = dao.getDetailSecret(seq);
			//System.out.println("sdto = "+sdto.toString());
			// 작성자 혹은 관리자가 아닐 경우
			if( sdto.getSecret()==1 && (!(id.equals(sdto.getId())) && auth!=1 ) ) {
				resp.sendRedirect("./board/qna_warn.jsp");
			}else {
				sdto = dao.getDetailDto(seq);
				//System.out.println("sdto after = "+sdto.toString());
				
				//여기에 댓글까지 포함해서 보내기
				List<ReplyDto> list = new ArrayList<>();
				list = dao.getRepList(seq);
				
				req.setAttribute("sdto", sdto);
				req.setAttribute("list", list);
				
				forward("./board/qna_detail.jsp",req,resp);
			}
		}else if(work.equals("adddetail")) {
			String contents = req.getParameter("repcontents");
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			id = req.getParameter("id");
			
			blistDao dao = blistDao.getInstance();
			ReplyDto dto = dao.addrepOne(id, seq, contents);
			
			obj.put("ar",dto);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("updateReply")){
			String contents = req.getParameter("contents");
			id = req.getParameter("id");
			int seq = Integer.parseInt(req.getParameter("seq"));
			int qna_seq = Integer.parseInt(req.getParameter("qna_seq"));
			
			//System.out.println(" cont = "+contents+" "+id+" "+seq +" "+qna_seq);
		
			blistDao dao = blistDao.getInstance();
			boolean b = dao.updateReply(seq, qna_seq, contents);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("delQna")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			blistDao dao = blistDao.getInstance();
			boolean b = dao.delQnaOne(seq);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
			
		}else if(work.equals("delRepOne")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			String sqseq = req.getParameter("qnaseq");
			int qna_seq = Integer.parseInt(sqseq);
			
			blistDao dao = blistDao.getInstance();
			boolean b = dao.delRepOne(seq);
			
			List<ReplyDto> list = new ArrayList<>();
			list = dao.getRepList(qna_seq);
			
			obj.put("b",b);
			obj.put("list",list);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
			
		}else if(work.equals("dupmove")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			blistDao dao = blistDao.getInstance();
			blistDto sdto = dao.getDetailDtoforUpdate(seq);
			
			//System.out.println("cont = "+ sdto.toString());
			req.setAttribute("sdto", sdto);
			forward("./board/qna_update.jsp",req,resp);
		}else if(work.equals("upQna")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			String title = req.getParameter("title");
			String contents = req.getParameter("contents");
			int part_seq = Integer.parseInt(req.getParameter("part"));
			int secret = req.getParameter("secret").equals("true")?1:0;
			
			blistDao dao = blistDao.getInstance();
			boolean b = dao.updateQnaOne(seq, title, contents, part_seq, secret);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("qnacont post");
		
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
