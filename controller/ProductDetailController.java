package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDetailDao;
import dto.ProductDto;
import dto.ReplyDto;
import net.sf.json.JSONObject;

@WebServlet("/productDetail")
public class ProductDetailController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		// 제품의 시퀀스 번호 받기
		int seq = Integer.parseInt(req.getParameter("seq"));

		ProductDetailDao dao = ProductDetailDao.getInstance();
		List<ReplyDto> list = new ArrayList<ReplyDto>();
		List<ProductDto> prolist = new ArrayList<ProductDto>();
		List<ProductDto> prolist2 = new ArrayList<ProductDto>();
		// 해당 시퀀스번호의 제품 정보를 다시 dto에 담아줌
		ProductDto pro = dao.getProduct(seq);

		// 리뷰 페이징을 위한 값
		String spageNum = req.getParameter("pageNum");
		JSONObject jobj = new JSONObject();
		HashMap<String, Object> map = new HashMap<String, Object>();

		// 페이징을 위한 초기값들 설정
		int pageNum;
		if (spageNum == null || spageNum.length() == 0) {
			pageNum = 1;
		}
		try {
			pageNum = Integer.parseInt(spageNum);
		} catch (NumberFormatException e) {
			pageNum = 1;
		}
		int currentBlock = pageNum % 5 == 0 ? pageNum / 5 : (pageNum / 5) + 1;
		int startPage = (currentBlock - 1) * 5 + 1;
		int endPage = startPage + 5 - 1;
		// object로 넘겨주기위해 String화
		String sp = startPage + "";
		String ep = endPage + "";
		String len = dao.getAllReview(seq) + "";
		String pn = pageNum + "";
		// 전체 글 갯수
		int totalRow = Integer.parseInt(len);

		int totalPage = totalRow % 5 == 0 ? totalRow / 5 + 1 : (totalRow / 5) + 1;
		if (totalPage == 0) {
			totalPage = 1;
		}
		if (pageNum > totalPage) {
			pageNum = 0;
		}
		String tp = totalPage + "";
		//처음 카테고리에서 상품으로 넘어갈때 실행
		if (work.equals("product")) {
			//제품의 정보들, 페이징 값들 전달
			req.setAttribute("productDetail", pro);
			req.setAttribute("startPage", sp.trim());
			req.setAttribute("endPage", ep.trim());
			req.setAttribute("totalPage", tp.trim());
			//리뷰 글 리스트 전달
			list = dao.getReplyList(seq, pageNum);
			req.setAttribute("list", list);
			
			//첫 페이지의 같은 카테고리의 상품들 리스트 값들
			prolist = dao.getplist(seq, 1, pro.getP_category());
			req.setAttribute("prolist", prolist);
			
			forward("./product/productDetail.jsp", req, resp);
			
			//리뷰 작성 값을 받아줌
		} else if (work.equals("writeReply")) {
			String contents = req.getParameter("contents");
			String id = req.getParameter("id");
			//리뷰를 작성하지 않으면 db에 추가 되지 않음
			if (!(contents == null || contents.equals("") || id == null)) {
				boolean isS = dao.writeReview(id, seq, contents);
				map.put("writeR", isS);
			}
			
			//System.out.println(seq + " " + contents + " " + id);
			//System.out.println("pg" + pageNum);

			//리뷰의 값들을 리스트로 넘겨줌
			list = dao.getReplyList(seq, pageNum);
			map.put("rlist", list);
			map.put("startPage", sp.trim());
			map.put("endPage", ep.trim());
			map.put("totalPage", tp.trim());
			map.put("pageNum", pn.trim());

			jobj.put("map", map);

			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);

			//같은 종류 카테고리 리스트의 버튼을 누르면 다음 상품들 리스트 값 전달
		} else if (work.equals("display")) {
			int listNum = Integer.parseInt(req.getParameter("listNum"));

			prolist2 = dao.getplist(seq, listNum, pro.getP_category());
			map.put("plist", prolist2);
			jobj.put("map", map);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
		} else if(work.equals("remove")) {
			String id = req.getParameter("id");
			
		}

	}

	public void forward(String linkname, HttpServletRequest req, HttpServletResponse resp) {
		RequestDispatcher dispatcher = req.getRequestDispatcher(linkname);
		try {
			dispatcher.forward(req, resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}