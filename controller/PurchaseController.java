package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDetailDao;
import dao.PurchaseDao;
import dto.ProductDto;
import dto.cartDto;
import net.sf.json.JSONObject;

@WebServlet("/purchaseCon")
public class PurchaseController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		
		if (work.equals("purchasego")) {
			int item_seq = Integer.parseInt(req.getParameter("seq"));
			ProductDetailDao dao = ProductDetailDao.getInstance();
			ProductDto product = dao.getProduct(item_seq);
			String color = req.getParameter("color");
			String item_size = req.getParameter("size");
			String count = req.getParameter("buy_count");
			
			System.out.println(item_seq+" "+color+" "+item_size+" "+count);

			req.setAttribute("product", product);
			req.setAttribute("color", color);
			req.setAttribute("size", item_size);
			req.setAttribute("count", count);
			
			RequestDispatcher dispatcher = req.getRequestDispatcher("./product/purchase.jsp");
			dispatcher.forward(req, resp);
		}else if(work.equals("buylist")) {
			String s = req.getParameter("item_seq");
			List<String> list = Arrays.asList(s.split(","));
			List<cartDto> cartlist = new ArrayList<cartDto>();
			for (int i = 0; i < list.size(); i++) {
				int item_seq = Integer.parseInt(list.get(i));
				System.out.println(item_seq);
				PurchaseDao buydao = PurchaseDao.getInstance();
				cartDto cart = buydao.getbuylist(item_seq);
				cartlist.add(cart);
			}
			System.out.println(cartlist);
			req.setAttribute("cartlist", cartlist);
			RequestDispatcher dispatcher = req.getRequestDispatcher("./product/purchase.jsp");
			dispatcher.forward(req, resp);
		}else if(work.equals("buy")) {
			String seq = req.getParameter("seq");
			String count = req.getParameter("count");
			String size = req.getParameter("size");
			String color = req.getParameter("color");
			String id = req.getParameter("id");
			List<String> list = Arrays.asList(seq.split(","));
			List<String> countlist = Arrays.asList(count.split(","));
			List<String> sizelist = Arrays.asList(size.split(","));
			List<String> colorlist = Arrays.asList(color.split(","));
			for (int i = 0; i < list.size(); i++) {
				int item_seq = Integer.parseInt(list.get(i));
				int qty = Integer.parseInt(countlist.get(i));
				PurchaseDao buydao = PurchaseDao.getInstance();
				//주문 내역에 insert
				buydao.insertbuylist(id, item_seq, qty, colorlist.get(i), sizelist.get(i));
				
				//상품 판매량(readcount) 업데이트
				buydao.sellcount(item_seq);
			}
			
			resp.sendRedirect("./product/thank.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String imp_uid = req.getParameter("imp_uid");
		String id = req.getParameter("id");
		String item_seq = req.getParameter("item_seq");
		String qty = req.getParameter("count");
		String size = req.getParameter("size");
		String color = req.getParameter("color");
		
		System.out.println(id+" "+item_seq+" "+qty+" "+size+" "+color);
		
		JSONObject jobj = new JSONObject();
		jobj.put("imp_uid", imp_uid);
		resp.setContentType("application/x-json; charset=UTF-8");
		resp.getWriter().print(jobj);
	}

	
}
