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
	

	@RequestMapping( value="json/price/{prodNo}", method=RequestMethod.GET )
	public Product getFileName(@PathVariable String prodNo) throws Exception{
		System.out.println("prodNo 넘어온거는 ??? "+prodNo);
		System.out.println("/product/json/getFileName : GET");
		
		int prodNo1 = Integer.parseInt(prodNo);
		Product product = new Product();
		product.setProdNo(prodNo1);
		//Business Logic
		
		product.setFileName(productService.getFileName(product));
		
		return product;
	}
	
}