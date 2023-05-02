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



//==> ���Ű��� Controller
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
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit'] ?: 8}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize = 15;
	
	
	//����View
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model, HttpServletRequest session) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		System.out.println("prodNo�� ?"+prodNo);
		
		Product product = productService.getProduct(prodNo);
		
		User user = (User)session.getAttribute("user");
		
		System.out.println("Session-user��ü�� ?"+user);
		
		model.addAttribute("user", user);
		model.addAttribute("product", product);
		
		//return "forward:/purchase/addPurchaseView.jsp";
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	// REDIRECT�� ���ΰ�ħ �� ȭ�� �ڷΰ��� ���� �ؾ��ϴ��� ?
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
								@RequestParam("prodNo") int prodNo,
								@RequestParam("userId") String userId,
								RedirectAttributes redirect) throws Exception {

			System.out.println("   purchase��ü�� ?:  "+purchase);
			System.out.println("   prodNo ?:  "+prodNo);
			System.out.println("   userId ?:  "+userId);
			System.out.println("   /purchase/addPurchase : POST");
		
		Product product = productService.getProduct(prodNo); //product ��ü ���� �ϴ� ��������
		User user = userService.getUser(userId); //user ��ü ���� �ϴ� ��������
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setDlvyAddr(purchase.getDlvyAddr1()+" "+purchase.getDlvyAddr2());
		purchase.setTranCode("1"); // => ���� ���Ĵ� '���ſϷ�' / '�����(����ϱ�)' 2 / '���ǵ���' 3
		
		purchaseService.addPurchase(purchase);
			System.out.println("   ������ purchase��ü��?  : "+purchase);
			System.out.println("   ��ǰ�߰��Ϸ�");
		
//		model.addAttribute("purchase", purchase);
		
		//������Ʈ �� ��ǰ�� tranNo �ٷ� �������� ����
		int tranNo = purchaseService.getPurchaseLast();
		System.out.println("   tranNO�� ? "+tranNo);
		
		Purchase purchase2 = purchaseService.getPurchase(tranNo);	
		
		//������ ��ǰ ������ user���� �������� ����
		purchase2.setBuyer(user);
		purchase2.setPurchaseProd(product);
		
		redirect.addFlashAttribute("purchase",purchase2);
		System.out.println("   ���� ? -> "+ purchase2);
		
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
		System.out.println("purchase��ü ?  : "+purchase);
		
		
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
		System.out.println("   list�� ???"+map.get("list"));
		
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
		System.out.println("   list�� ???"+map.get("list"));
		
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
		System.out.println("purchase ��ü�� ? : "+ purchase);
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
			System.out.println("Update�Ϸ�");
			
		Purchase purchase2 = purchaseService.getPurchase(purchase.getTranNo());
		model.addAttribute("purchase", purchase2);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranNo") int tranNo,
								@RequestParam("tranCode") String tranCode,
								Model model ) throws Exception{

		System.out.println("tranNo �� tranCode �� ?  :  " + tranNo+"&"+tranCode);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		System.out.println("  ������ purchase ? "+purchase);
		
		purchaseService.updateTranCode(purchase);
		System.out.println("  UpdateTranCode �Ϸ�");
		String result;
		if (tranCode.equals("3")) {
			result ="listPurchase";
		} else if (tranCode.equals("2")){
			result ="listPurchaseManager";
		} else {
			result = null;
		}
		System.out.println("  result��,�� ?"+result);
		return result;
	}
}