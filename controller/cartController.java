package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDetailDao;
import dao.cartDao;
import dto.cartDto;
import net.sf.json.JSONObject;

@WebServlet("/cartcont")
public class cartController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8"); 
		req.setCharacterEncoding("utf-8");
		PrintWriter out = resp.getWriter();
		
		JSONObject obj = new JSONObject();
		String work = req.getParameter("work");
		if(work.equals("purchasego")) {
			String id = req.getParameter("id");
			int item_seq = Integer.parseInt(req.getParameter("seq"));
			String color = req.getParameter("color");
			String item_size = req.getParameter("size");
			int qty = Integer.parseInt(req.getParameter("buy_count"));
			ProductDetailDao dao = ProductDetailDao.getInstance();
			boolean isS = dao.insertcart(id, item_seq, qty, color, item_size);
			
			if(isS) {
				 out.print("<script> let result = confirm('상품이 장바구니에 담겼습니다.  장바구니 페이지로 이동하시겠습니까?'); "
				 		+ "if(result){location.href = 'cartcont?work=cmove&id="+id+"';} "
				 		+ "else{location.href = 'addPro?work=list';}</script>");
					out.flush(); 
			}else {
				out.print("<script>alert('장바구니는 로그인 이후 이용 가능합니다'); location.href='addPro?work=main';</script>");
			}
		}
		else if(work.equals("cmove")) {
			String id = req.getParameter("id");
			cartDao dao = cartDao.getInstance();
			List<cartDto> list = dao.getList(id);
			
			req.setAttribute("list", list);
			forward("./cart/cart_main.jsp", req, resp);
		}else if(work.equals("chgqty")) {
			String sqty = req.getParameter("qty");
			int qty = Integer.parseInt(sqty);
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			cartDao dao = cartDao.getInstance();
			boolean b = dao.updateQty(seq, qty);
			
			obj.put("b", b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}else if(work.equals("delitem")) {
			String s = req.getParameter("seq");
			List<String> list = Arrays.asList(s.split(","));
			
			cartDao dao = cartDao.getInstance();
			boolean b =dao.deleteItem(list);
			
			obj.put("b", b);
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(obj);
		}
		
	}

	@Override
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
