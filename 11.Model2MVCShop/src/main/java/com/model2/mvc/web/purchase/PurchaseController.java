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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;



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
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
		
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
	int pageSize = 15;
	
	
	//구매View
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model, HttpServletRequest session) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		System.out.println("prodNo는 ?"+prodNo);
		
		Product product = productService.getProduct(prodNo);
		
		User user = (User)session.getAttribute("user");
		
		System.out.println("Session-user객체는 ?"+user);
		
		model.addAttribute("user", user);
		model.addAttribute("product", product);
		
		//return "forward:/purchase/addPurchaseView.jsp";
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	// REDIRECT로 새로고침 및 화면 뒤로가기 방지 해야하는지 ?
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
								@RequestParam("prodNo") int prodNo,
								@RequestParam("userId") String userId,
								RedirectAttributes redirect) throws Exception {

			System.out.println("   purchase객체는 ?:  "+purchase);
			System.out.println("   prodNo ?:  "+prodNo);
			System.out.println("   userId ?:  "+userId);
			System.out.println("   /purchase/addPurchase : POST");
		
		Product product = productService.getProduct(prodNo); //product 객체 정보 싹다 가져오기
		User user = userService.getUser(userId); //user 객체 정보 싹다 가져오기
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setDlvyAddr(purchase.getDlvyAddr1()+" "+purchase.getDlvyAddr2());
		purchase.setTranCode("1"); // => 구매 직후는 '구매완료' / '배송중(배송하기)' 2 / '물건도착' 3
		
		purchaseService.addPurchase(purchase);
			System.out.println("   세팅한 purchase객체는?  : "+purchase);
			System.out.println("   상품추가완료");
		
		//업데이트 된 제품의 tranNo 바로 가져오는 쿼리
		int tranNo = purchaseService.getPurchaseLast();
		System.out.println("   tranNO는 ? "+tranNo);
		
		Purchase purchase2 = purchaseService.getPurchase(tranNo);	
		
		//구매한 상품 정보랑 user정보 가져오기 위함
		purchase2.setBuyer(user);
		purchase2.setPurchaseProd(product);
		
		redirect.addFlashAttribute("purchase",purchase2);
		System.out.println("   뭐야 ? -> "+ purchase2);
		
		return "redirect:redirectedPage";
	}
	
	@RequestMapping(value="/redirectedPage", method = RequestMethod.GET)
	    public String redirectedPage(@ModelAttribute("purchase") Purchase purchase, Model model) {
		System.out.println("    model?? ->"+purchase);
		model.addAttribute("purchase", purchase);
		
	    return "/purchase/addPurchase.jsp";
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

	@RequestMapping("listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search ,@RequestParam(value="currentPage", required = false) Integer currentPage,
			HttpSession session) throws Exception{
		if(currentPage == null) {
			currentPage =1;
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, ((User)session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultPage",resultPage);
		modelAndView.addObject("list", map.get("list"));
		System.out.println("   list는 ???"+map.get("list"));
		
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		return modelAndView;
	}
	
	@RequestMapping("listPurchaseManager")
	public ModelAndView listPurchaseManager(@ModelAttribute("search") Search search ,@RequestParam(value="currentPage", required = false) Integer currentPage,
			HttpSession session) throws Exception{
		if(currentPage == null) {
			currentPage =1;
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(15);
		
		Map<String, Object> map = purchaseService.getPurchaseList2(search, ((User)session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit, 15);
		System.out.println("   resultPage ??"+resultPage);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultPage",resultPage);
		modelAndView.addObject("list", map.get("list"));
		System.out.println("   list는 ???"+map.get("list"));
		
		modelAndView.setViewName("forward:/purchase/listPurchaseManager.jsp");
		return modelAndView;
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
	public String updateTranCode(@RequestParam("tranNo") int tranNo,
								@RequestParam("tranCode") String tranCode,
								Model model ) throws Exception{

		System.out.println("tranNo 와 tranCode 는 ?  :  " + tranNo+"&"+tranCode);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		System.out.println("  세팅한 purchase ? "+purchase);
		
		purchaseService.updateTranCode(purchase);
		System.out.println("  UpdateTranCode 완료");
		String result;
		if (tranCode.equals("3")) {
			result ="listPurchase";
		} else if (tranCode.equals("2")){
			result ="listPurchaseManager";
		} else {
			result = null;
		}
		System.out.println("  resultㄴ,ㄴ ?"+result);
		return result;
	}
}