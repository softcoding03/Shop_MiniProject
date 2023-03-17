package com.model2.mvc.web.purchase;


import java.util.HashMap;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;



//==> 구매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit'] ?: 8}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	//구매View
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		System.out.println("prodNo는 ?"+prodNo);
		
		Product product = productService.getProduct(prodNo);
		HttpSession session=request.getSession();
		User user = (User)session.getAttribute("user");
		
		System.out.println("Session-user객체는 ?"+user);
		
		model.addAttribute("user", user);
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
								@RequestParam("prodNo") int prodNo,
										Model model) throws Exception {

			System.out.println("purchase객체는 ???:  "+purchase);
			System.out.println("prodNo ???:  "+prodNo);
			System.out.println("/purchase/addPurchase : POST");
		
		Product product = productService.getProduct(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1"); // => 구매 직후는 '구매완료' / '배송중(배송하기)' 2 / '물건도착' 3
		
		purchaseService.addPurchase(purchase);
			System.out.println("세팅한 purchase객체는?  : "+purchase);
			System.out.println("상품추가완료");
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model ) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		System.out.println("tranNo ?  : "+tranNo);
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println("purchase객체 ?  : "+purchase);
		
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	

	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search,
							Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		HttpSession session=request.getSession();
		User user = (User)session.getAttribute("user");
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("user", user);
		
		Map<String , Object> map2=purchaseService.getPurchaseList(map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map2.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		System.out.println("resultpage 잘 세팅되었나요 ??? --->"+resultPage);
		System.out.println("list 잘 넘어 왔나요 ?? --->"+map2.get("list"));

		
			return "forward:/purchase/listPurchase.jsp";
		
	}
		

	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);

		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}

	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase,
									@RequestParam("tranNo") int tranNo,
								Model model) throws Exception{
		
		purchase.setTranNo(tranNo);
		System.out.println("purchase 객체는 ? : "+ purchase);
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
			System.out.println("Update완료");
			
		Purchase purchase2 = purchaseService.getPurchase(purchase.getTranNo());
		model.addAttribute("purchase", purchase2);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranCode") String tranCode,
									@RequestParam("tranNo") int tranNo,
								Model model ) throws Exception{

		System.out.println("tranCode 와 tranNo 는 ?  :  " + tranCode+"&"+tranNo);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		System.out.println("디버깅 UpdateTran 완료");
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo,
									@RequestParam("tranNo") int tranNo,
								Model model ) throws Exception{

		System.out.println("prodNo 와 tranNo 는 ?  :  " + prodNo+"&"+tranNo);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setProdNo(prodNo);
		
		purchaseService.updateTranCode(purchase);
		System.out.println("디버깅 UpdateTranCode 완료");
		
		return "forward:/purchase/listProductManage.jsp";
	}
}