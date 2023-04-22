package com.model2.mvc.web.purchase;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 상품관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	

	/*
	 * @RequestMapping( value="json/getAll/{searchCondition}/{searchKeyword1}",
	 * method=RequestMethod.GET ) public List<String> getAll(@PathVariable String
	 * searchCondition,
	 * 
	 * @PathVariable String searchKeyword1) throws Exception{
	 * System.out.println("searchCondition 넘어온거는 ??? "+searchCondition);
	 * System.out.println("searchKeyword 넘어온거는 ??? "+searchKeyword1);
	 * 
	 * Search searchKeyword = new Search();
	 * searchKeyword.setSearchKeyword(searchKeyword1);
	 * 
	 * List<String> list =null;
	 * 
	 * if (searchCondition.equals("0")) {
	 * System.out.println("/product/json/getAll0 : GET"); list
	 * =productService.getAll0(searchKeyword);
	 * 
	 * } else if (searchCondition.equals("1")) {
	 * System.out.println("/product/json/getAll1 : GET"); list
	 * =productService.getAll1(searchKeyword);
	 * 
	 * } else if (searchCondition.equals("2")) { // } else {
	 * System.out.println("/product/json/getAll2 : GET"); list
	 * =productService.getAll2(searchKeyword); }
	 * System.out.println("list는 무엇으로 구성? -> " + list ); //Business Logic return
	 * list; }
	 */
	
}