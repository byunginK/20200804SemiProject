package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PurchaseDao;
import dto.MyOrderDto;

@WebServlet("/myorder")
public class MyorderlistController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		PurchaseDao dao = PurchaseDao.getInstance();
		List<MyOrderDto> list = dao.getMyOrderList(id);
		
		req.setAttribute("orderlist", list);
		RequestDispatcher dispatcher = req.getRequestDispatcher("./product/buylist.jsp");
		dispatcher.forward(req, resp);
	}

}
