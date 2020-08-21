package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ProductDetailDao;
import dto.ProductDto;

@WebServlet("/updatePro")
public class updateProductController extends HttpServlet {

	@Override // 제품 추가와 비슷 내용
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		ProductDetailDao dao = ProductDetailDao.getInstance();

		String savePath = req.getServletContext().getRealPath("/productimg");
		System.out.println(savePath);
		int sizeLimit = 1024 * 1024 * 15;
		String encoding = "UTF-8";

		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encoding,
				new DefaultFileRenamePolicy());

		int seq = Integer.parseInt(multi.getParameter("seq"));

		String name = multi.getParameter("p_name");
		String mertiral = multi.getParameter("p_material");
		String madeIn = multi.getParameter("p_madeIn");
		int price = Integer.parseInt(multi.getParameter("price"));
		String category = multi.getParameter("selbig");
		String kind = multi.getParameter("selsmall");
		int p_kind = Integer.parseInt(kind);
		String info = multi.getParameter("p_info");

		//기존의 추가했던 이미지 이름 받기
		String oldfile = multi.getParameter("oldfile");
		//새롭게 추가된 이미지 받기
		String filename = multi.getFilesystemName("fileload");

		String fileFullPath = savePath + "/" + filename;

		System.out.println(name + " " + mertiral + " " + madeIn + " " + price + " " + category + " " + kind + " "
				+ fileFullPath + " " + oldfile + " " + info + " ");

		//만약 이미지를 변경하지 않으면 기존의 이미지로 설정
		if (filename == null) {
			filename = oldfile;
		}

		ProductDto dto = new ProductDto(seq, name, info, mertiral, madeIn, price, category, 0, p_kind, filename);

		//db에서 데이터값들 수정
		boolean isS = dao.updateProduct(dto);
		req.setAttribute("updateP", isS);

		forward("./admin/updateProductAf.jsp", req, resp);
	}

	public void forward(String linkname, HttpServletRequest req, HttpServletResponse resp) {
		RequestDispatcher dispatcher = req.getRequestDispatcher(linkname);
		try {
			dispatcher.forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
