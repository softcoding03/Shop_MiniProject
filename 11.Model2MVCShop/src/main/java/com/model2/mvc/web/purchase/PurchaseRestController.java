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


//==> ��ǰ���� RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	

	@RequestMapping( value="json/price/{prodNo}/{price}", method=RequestMethod.GET )
	public String comparePrice(@PathVariable String prodNo,
								@PathVariable int price) throws Exception{
		System.out.println("   prodNo �Ѿ�°Ŵ� ??? "+prodNo);
		System.out.println("   price �Ѿ�°Ŵ� ??? "+price);
		//�� prodNo�� ������ db�� price�� import���� ������ �����̶� ������ �Ǵ�
		String a = prodNo.substring(10);
		System.out.println(a);
		int prodNo1 = Integer.parseInt(a);
		System.out.println(prodNo1);
		
		Product product = productService.getProduct(prodNo1);
		System.out.println("   product �����°Ŵ� ???"+product);
		
		String text = null;
		if (price == product.getPrice()) {
			text = "����";
		} else { 
			text ="����";
		}
		System.out.println("   text ?"+text);
		return text;
	}
	
}