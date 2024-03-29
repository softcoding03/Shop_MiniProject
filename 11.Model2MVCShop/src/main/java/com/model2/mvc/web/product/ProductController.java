package com.model2.mvc.web.product;


import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	//.
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	//@Value("#{commonProperties['pageUnit']}")
	@Value("#{commonProperties['pageUnit'] ?: 8}")
	int pageUnit;
	
	//@Value("#{commonProperties['pageSize']}")
	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product,
							@RequestParam("file") MultipartFile[] uploadFile,
							Model model) throws Exception {
/*
		String path =  "C:\\uploadFiles\\";
		
		for (MultipartFile mf : uploadFileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            long fileSize = mf.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            System.out.println("fileSize : " + fileSize);

            String saveFile = path + originFileName;
            
            String fileName = originFileName;
            
            try {
                mf.transferTo(new File(saveFile));
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }*/
		System.out.println("product는 ?????:  "+product);
		String path = "C:\\Users\\user\\git\\11Ref.CSS\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles";
		
				System.out.println("uploadFile넘어오는거 뭔가요 ? :" + uploadFile);
		
		for(MultipartFile file : uploadFile){
			
			//파일명 가져오기
            String originalName = file.getOriginalFilename();
    			System.out.println("originalName은 ??? : "+originalName);
    			
		    			//불필요한 코드? 언제사용?
		    	//String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
		    			//System.out.println("fileName은 ??? : "+fileName);
    		
    		//유니크한 정보 만들어내기 -> 저장 및 업로드 시 사용
            String uuid = UUID.randomUUID().toString();
           
            //저장을 위한 경로 설정: 일반 경로 + 유니크한 정보 + 파일명
            String savefileName = path + File.separator + uuid + "_" + originalName;
            			System.out.println("savfileName은 ??? : "+savefileName);
            
            //파일의 경로를 선언 및 저장
            Path savePath = Paths.get(savefileName);
						System.out.println("savePath은 ??? : "+savePath);
            
			//unique한 정보와 함께 파일명 지정하기
			String saveName = uuid+"_"+originalName;
						System.out.println("saveName은 ??? : "+saveName);
			
			//product 도메인 객체에 fileName 저장해주기
            product.setFileName(saveName);
            
            try {
            	//파일을 실제 저장하는 부분
                file.transferTo(savePath);
                System.out.println("file 저장 완료");
            } catch (IOException e) {
            	
                e.printStackTrace();
            }
		}
		
		System.out.println("/product/addProduct : POST");
		//Business Logic
		productService.addProduct(product);
		
		System.out.println("상품추가완료");
		//가장 최근에 insert 된 prod_no 가져오기 -> ?마지막에 insert 되었다는 뜻=prod_no가 가장 큰것 !
		int prodNo = productService.getProdNoLast();
		System.out.println("insert 완료 후 가져온 마지막 prodNo ? -> "+prodNo);
		
		Product product2 = new Product();
		product2 = productService.getProduct(prodNo);
		System.out.println("가져온 prodNo로 다시 getProduct한 객체 ->" + product2);
		
		model.addAttribute("product", product2);
		
		return "forward:/product/addProduct.jsp";
	}
	
	
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		System.out.println("prodNo int로 잘 연결되었나요 ?  --> "+prodNo);
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		System.out.println("product 무엇인가요 ....? ->"+product);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}

	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search,
							@RequestParam("menu") String menu,
							Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		System.out.println("menu 잘 넘어 왔나요 ?? --->"+menu);
		  System.out.println("  search넘어온게 있어?? "+search); //없음
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("  search설정해준거 뭐야?? "+search);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("  resultPage ? -> "+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		System.out.println("   resultpage 잘 세팅되었나요 ??? --->"+resultPage);
		System.out.println("   menu 잘 넘어 왔나요 222?? --->"+menu);
		System.out.println("   list 잘 넘어 왔나요 ?? --->"+map.get("list"));

		if (menu.equals("manage")) {
			return "forward:/product/listProductManage.jsp";
		}else {
			return "forward:/product/listProductSearch.jsp";
		}
	}
		
//	@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);

		String manudate;
		String a= product.getManuDate();
		String b = a.substring(0,4);
		String c = a.substring(4,6);
		String d = a.substring(6);
		manudate = b+"-"+c+"-"+d;
		System.out.println("제조일자???->" +manudate);
		
		product.setManuDate(manudate);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}

	
//	@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product,
								@RequestParam("file") MultipartFile[] uploadFile,
								Model model , HttpSession session) throws Exception{
		
		
			
		System.out.println("product ??? -> "+ product);
		System.out.println("/product/updateProduct : POST");
		//Business Logic
		String path = "C:\\Users\\user\\git\\11Ref.CSS\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles";
						
		
		System.out.println("uploadFile넘어오는거 뭔가요 ? :" + uploadFile);
		System.out.println("hidden에 있는 filename ! -->" +product.getFileName());
				
		for(MultipartFile file : uploadFile){
					
						//파일명 가져오기
			            String originalName = file.getOriginalFilename();
			            	System.out.println("file 이름은??? "+file);
			    			System.out.println("originalName은 ??? : "+originalName);
			    			
			    	//만약 update할때 사진 이미지를 변경해주지 않으면 원래 이미지 파일로 저장될 수 있도록...		
			    	if (originalName != "") {
			    			
					    			//불필요한 코드? 언제사용?
					    	//String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
					    			//System.out.println("fileName은 ??? : "+fileName);
			    		
			    		//유니크한 정보 만들어내기 -> 저장 및 업로드 시 사용
			            String uuid = UUID.randomUUID().toString();
			           
			            //저장을 위한 경로 설정: 일반 경로 + 유니크한 정보 + 파일명
			            String savefileName = path + File.separator + uuid + "_" + originalName;
			            			System.out.println("savfileName은 ??? : "+savefileName);
			            
			            //파일의 경로를 선언 및 저장
			            Path savePath = Paths.get(savefileName);
									System.out.println("savePath은 ??? : "+savePath);
			            
						//unique한 정보와 함께 파일명 지정하기
						String saveName = uuid+"_"+originalName;
									System.out.println("saveName은 ??? : "+saveName);
						
						//product 도메인 객체에 fileName 저장해주기
			            product.setFileName(saveName);
			    	   
			            try {
			            	//파일을 실제 저장하는 부분
			                file.transferTo(savePath);
			                System.out.println("file 저장 완료");
			            } catch (IOException e) {
			                e.printStackTrace();
			            }
			    	} 
				}
		
//		파싱해서 2013-03-01 처럼 만들어주기
		
		
			System.out.println("filename ! -->" +product.getFileName());
		productService.updateProduct(product);
		
		Product product2 = productService.getProduct(product.getProdNo());
		model.addAttribute("product", product2);
		return "forward:/product/updateProduct.jsp";
	}
}