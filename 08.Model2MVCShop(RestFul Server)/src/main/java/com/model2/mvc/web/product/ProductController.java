package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@Controller
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProductView() throws Exception {

		System.out.println("/product/addProductView : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
//	@RequestMapping("/addProduct.do")
	@RequestMapping(value="addProduct",method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, Model model ) throws Exception {

		System.out.println("/product/addProduct:POST");

		productService.addProduct(product);
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct",method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model , HttpServletRequest req) throws Exception {
		//@RequestParam("prodNo") int prodNo
		//=> int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		System.out.println("/product/getProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		if("manage".equals(req.getParameter("menu"))) {
			return "forward:/product/updateProductView.jsp";
		}
		
		return "forward:/product/getProduct.jsp";
		
	}
	
//	@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProductView: GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
//	@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct",method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		productService.updateProduct(product);
		
		return "redirect:/getProduct.do?prodNo="+product.getProdNo();
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println(request.getParameter("menu"));
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/product/listProduct.jsp";
	}
}