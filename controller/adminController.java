package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.adminDao;
import dto.InfoDto;
import dto.ProductDto;
import dto.ReplyDto;
import dto.blistDto;
import dto.sug_AnswerDto;
import dto.suggestDto;
import net.sf.json.JSONObject;

@WebServlet("/admincont")
public class adminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet");
		req.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		String work = req.getParameter("work");
		
		//-ADMIN_QNA-------------------------------------------------------
		if(work.equals("moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			//System.out.println("controller page = "+pageNumber+", how= "+how);
			adminDao dao = adminDao.getInstance();
			List<blistDto> list = dao.getQnaList(pageNumber,how); // 0 pageNumber 찾기
			int len = dao.getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("how", how);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_qna_delete.jsp",req,resp);
		}else if(work.equals("qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			adminDao dao = adminDao.getInstance();
			List<blistDto> list =dao.getQnaList(need, fneed, pageNumber,how);
			int len = dao.getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("how", how);
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_qna_delete.jsp",req,resp);
		}else if(work.equals("delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//---rep----------------------------------------------------
		else if(work.equals("rep_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<ReplyDto> list = dao.rep_getQnaList(pageNumber,how); // 0 pageNumber 찾기
			int len = dao.rep_getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("how", how);
			req.setAttribute("pageNumber", pageNumber);
			
			forward("./admin/admin_qna_repdelete.jsp",req,resp);
		}else if(work.equals("rep_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			System.out.println("hello = "+need +" ," +fneed+", "+pageNumber+" , how" +show);
			adminDao dao = adminDao.getInstance();
			List<ReplyDto> list =dao.rep_getQnaList(need, fneed, pageNumber,how);
			int len = dao.rep_getQnaLen(need, fneed);
			
			System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("how", how);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_qna_repdelete.jsp",req,resp);
		}else if(work.equals("rep_delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.rep_delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//---product-------------------------------------------------
		else if(work.equals("pro_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<ProductDto> list = dao.pro_getQnaList(pageNumber); // 0 pageNumber 찾기
			int len = dao.pro_getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_product_delete.jsp",req,resp);
		}else if(work.equals("pro_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			fneed = fneed.toLowerCase();
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			
			adminDao dao = adminDao.getInstance();
			List<ProductDto> list =dao.pro_getQnaList(need, fneed, pageNumber);
			int len = dao.pro_getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_product_delete.jsp",req,resp);
		}else if(work.equals("pro_delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.pro_delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//---info-------------------------------------------------
		else if(work.equals("info_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<InfoDto> list = dao.info_getQnaList(pageNumber,how); // 0 pageNumber 찾기
			int len = dao.info_getQnaLen();
			
			
			//System.out.println("list = "+list.size()+", len="+len);
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("how", how);
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_info_delete.jsp",req,resp);
		}else if(work.equals("info_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			fneed = fneed.toLowerCase();
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			adminDao dao = adminDao.getInstance();
			List<InfoDto> list =dao.info_getQnaList(need, fneed, pageNumber,how);
			int len = dao.info_getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("how", how);
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_info_delete.jsp",req,resp);
		}else if(work.equals("info_delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.info_delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//-ADMIN_Suggeest-------------------------------------------------------
		else if(work.equals("sug_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<suggestDto> list = dao.sug_getQnaList(pageNumber,how); // 0 pageNumber 찾기
			int len = dao.sug_getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("how", how);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_suggest_delete.jsp",req,resp);
		}else if(work.equals("sug_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			adminDao dao = adminDao.getInstance();
			List<suggestDto> list =dao.sug_getQnaList(need, fneed, pageNumber,how);
			int len = dao.sug_getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("how", how);
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_suggest_delete.jsp",req,resp);
		}else if(work.equals("sug_delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.sug_delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//-ADMIN_repSuggeest-------------------------------------------------------
		else if(work.equals("sugrep_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<sug_AnswerDto> list = dao.sugrep_getQnaList(pageNumber,how); // 0 pageNumber 찾기
			int len = dao.sugrep_getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("how", how);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_suggest_repdelete.jsp",req,resp);
		}else if(work.equals("sugrep_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			String show =  (req.getParameter("how")==null)?"0":req.getParameter("how");
			int how = Integer.parseInt(show);
			
			adminDao dao = adminDao.getInstance();
			List<sug_AnswerDto> list =dao.sugrep_getQnaList(need, fneed, pageNumber,how);
			int len = dao.sugrep_getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("how", how);
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_suggest_repdelete.jsp",req,resp);
		}else if(work.equals("sugrep_delchklist")) {
			String s = req.getParameter("chklist");
			List<String> list = Arrays.asList(s.split(","));
			
			//System.out.println("cont = "+ s);
			adminDao dao = adminDao.getInstance();
			boolean b= dao.sugrep_delchkList(list);
			
			obj.put("b",b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		//--------------제품 수정 이동
		else if(work.equals("proup_moveQnadel")) {
			String spageNumber = (req.getParameter("pageNumber")==null)?"0":req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spageNumber);
			
			//System.out.println("controller page = "+pageNumber);
			adminDao dao = adminDao.getInstance();
			List<ProductDto> list = dao.pro_getQnaList(pageNumber); // 0 pageNumber 찾기
			int len = dao.pro_getQnaLen();
			
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_product_update.jsp",req,resp);
		}else if(work.equals("proup_qsearch")) {
			String need = req.getParameter("need");
			String fneed = req.getParameter("fneed");
			fneed = fneed.toLowerCase();
			String spage = req.getParameter("pageNumber");
			int pageNumber = Integer.parseInt(spage);
			
			adminDao dao = adminDao.getInstance();
			List<ProductDto> list =dao.pro_getQnaList(need, fneed, pageNumber);
			int len = dao.pro_getQnaLen(need, fneed);
			
			//System.out.println("check = "+ list.toString());
			req.setAttribute("list", list);
			req.setAttribute("len", len);
			req.setAttribute("need", "");
			req.setAttribute("fneed", "");
			req.setAttribute("pageNumber", pageNumber);
			forward("./admin/admin_product_update.jsp",req,resp);
		}else if(work.equals("updemove")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			adminDao dao = adminDao.getInstance();
			ProductDto dto = dao.getProduct(seq);
			req.setAttribute("product", dto);
			forward("./admin/updateProduct.jsp",req,resp);
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doPost");
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
