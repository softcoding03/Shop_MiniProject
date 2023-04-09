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
	int pageSize;
	
	
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
		purchase.setTranCode("1"); // => ���� ���Ĵ� '���ſϷ�' / '�����(����ϱ�)' 2 / '���ǵ���' 3
		
		purchaseService.addPurchase(purchase);
			System.out.println("   ������ purchase��ü��?  : "+purchase);
			System.out.println("   ��ǰ�߰��Ϸ�");
		
//		model.addAttribute("purchase", purchase);
		
		//������Ʈ �� ��ǰ�� tranNo �ٷ� �������� ����
		int tranNo = purchaseService.getPurchaseLast();
		System.out.println("   tranNO�� ? "+tranNo);
		
		Purchase purchase2 = purchaseService.getPurchase(tranNo);	
		
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
	
	

	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search,
								Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("   /purchase/listPurchase : GET / POST");
		System.out.println("   search ��? "+ search);
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("  pageSize�� ? "+pageSize);
		
		HttpSession session=request.getSession();
		User user = (User)session.getAttribute("user");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("user", user);
		System.out.println("   search�� ����? :  "+search);
		System.out.println("   map�� ���� ? :  "+map);
		
		Map<String , Object> map2=purchaseService.getPurchaseList(map);
		
		System.out.println("   map2�� ���� ?  :  "+map2);

		// Model �� View ����
		model.addAttribute("list", map2.get("list"));

		System.out.println("   list ?? --->"+map2.get("list"));

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
		System.out.println("purchase ��ü�� ? : "+ purchase);
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
			System.out.println("Update�Ϸ�");
			
		Purchase purchase2 = purchaseService.getPurchase(purchase.getTranNo());
		model.addAttribute("purchase", purchase2);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranCode") String tranCode,
									@RequestParam("tranNo") int tranNo,
								Model model ) throws Exception{

		System.out.println("tranCode �� tranNo �� ?  :  " + tranCode+"&"+tranNo);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		System.out.println("����� UpdateTran �Ϸ�");
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo,
									@RequestParam("tranNo") int tranNo,
								Model model ) throws Exception{

		System.out.println("prodNo �� tranNo �� ?  :  " + prodNo+"&"+tranNo);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		
		
		purchaseService.updateTranCode(purchase);
		System.out.println("����� UpdateTranCode �Ϸ�");
		
		return "forward:/purchase/listProductManage.jsp";
	}
}