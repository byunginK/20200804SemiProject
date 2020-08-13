package controller;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDetailDao;
import dto.ProductDto;
import net.sf.json.JSONObject;

@WebServlet("/purchaseCon")
public class PurchaseController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String work = req.getParameter("work");
		if (work.equals("purchasego")) {
			int seq = Integer.parseInt(req.getParameter("purseq"));
			ProductDetailDao dao = ProductDetailDao.getInstance();
			ProductDto product = dao.getProduct(seq);
			String color = req.getParameter("color");
			String size = req.getParameter("size");
			String count = req.getParameter("buy_count");
			String totalPrice = req.getParameter("totalprice");

			req.setAttribute("product", product);
			req.setAttribute("color", color);
			req.setAttribute("size", size);
			req.setAttribute("count", count);
			req.setAttribute("totalPrice", totalPrice);

			RequestDispatcher dispatcher = req.getRequestDispatcher("purchase.jsp");
			dispatcher.forward(req, resp);
		} else if (work.equals("successpay")) {
			resp.sendRedirect("thank.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String imp_uid = req.getParameter("imp_uid");
		
		JSONObject jobj = new JSONObject();
		jobj.put("imp_uid", imp_uid);
		resp.setContentType("application/x-json; charset=UTF-8");
		resp.getWriter().print(jobj);
	}

	
}
