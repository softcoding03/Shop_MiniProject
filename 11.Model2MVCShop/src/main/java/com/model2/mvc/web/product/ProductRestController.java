package com.model2.mvc.web.product;

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


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	

	@RequestMapping( value="json/getAll/{searchCondition}/{searchKeyword1}", method=RequestMethod.GET )
	public List<String> getAll(@PathVariable String searchCondition,
								@PathVariable String searchKeyword1) throws Exception{
		System.out.println("searchCondition 넘어온거는 ??? "+searchCondition);
		System.out.println("searchKeyword 넘어온거는 ??? "+searchKeyword1);
		
		Search searchKeyword = new Search();
		searchKeyword.setSearchKeyword(searchKeyword1);
		
		List<String> list =null;
		
		if (searchCondition.equals("0")) {
			System.out.println("/product/json/getAll0 : GET");
				list =productService.getAll0(searchKeyword);
				
		} else if (searchCondition.equals("1")) {
			System.out.println("/product/json/getAll1 : GET");
				list =productService.getAll1(searchKeyword);
					
		} else if (searchCondition.equals("2")) {
//		} else {
			System.out.println("/product/json/getAll2 : GET");
				list =productService.getAll2(searchKeyword);
		}
		System.out.println("list는 무엇으로 구성? -> " + list );
		//Business Logic
		return list;
	}
	
	@RequestMapping( value="json/getFileName/{prodName}", method=RequestMethod.GET )
	public Product getFileName(@PathVariable String prodName) throws Exception{
		System.out.println("prodName 넘어온거는 ??? "+prodName);
		System.out.println("/product/json/getFileName : GET");
		
		Product product = new Product();
		product.setProdName(prodName);
		//Business Logic
		
		
	
		product.setFileName(productService.getFileName(product));
		
		
		return product;
	}
	
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct(@PathVariable int prodNo) throws Exception{
		System.out.println("prodNo 넘어온거는 ??? "+prodNo);
		System.out.println("/product/json/getProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		System.out.println("product 무엇인가요 ....? ->"+product);

		//Business Logic
		return product;
	}

	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public void addProduct(@RequestBody Product product) throws Exception{
		System.out.println("product 넘어온거는 ??? "+product);
		System.out.println("/product/json/addProduct : POST");

		//Business Logic
		productService.addProduct(product);
		System.out.println("add 완료");
	}
	
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public Map<String , Object> listProduct(@RequestBody Search search) throws Exception{
		
		System.out.println("Search 넘어온거는 ??? "+search);
		System.out.println("/product/json/listProduct : POST");

		//Business Logic
		int pageUnit = 3;
		int pageSize = 2;
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getProductList(search);
		map.put("message", "아주잘했어요");
		System.out.println("list 완료");
		
		return map;
	}
	
	@RequestMapping(value="json/updateProduct", method=RequestMethod.POST)
	public Product updateProduct(@RequestBody Product product) throws Exception{
		
		System.out.println("product ??? -> "+ product);
		System.out.println("/product/updateProduct : POST");
		//Business Logic
		
		productService.updateProduct(product);
		
		Product product2 = productService.getProduct(product.getProdNo());
		
		//Map으로 Return 해줘야한다? 
		return product2;
	}
}