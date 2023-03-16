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


//==> ��ǰ���� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
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
            String originFileName = mf.getOriginalFilename(); // ���� ���� ��
            long fileSize = mf.getSize(); // ���� ������

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
		System.out.println("product�� ?????:  "+product);
		String path = "C:\\Users\\user\\git\\11Ref.CSS\\11.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles";
		
				System.out.println("uploadFile�Ѿ���°� ������ ? :" + uploadFile);
		
		for(MultipartFile file : uploadFile){
			
			//���ϸ� ��������
            String originalName = file.getOriginalFilename();
    			System.out.println("originalName�� ??? : "+originalName);
    			
		    			//���ʿ��� �ڵ�? �������?
		    	//String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
		    			//System.out.println("fileName�� ??? : "+fileName);
    		
    		//����ũ�� ���� ������ -> ���� �� ���ε� �� ���
            String uuid = UUID.randomUUID().toString();
           
            //������ ���� ��� ����: �Ϲ� ��� + ����ũ�� ���� + ���ϸ�
            String savefileName = path + File.separator + uuid + "_" + originalName;
            			System.out.println("savfileName�� ??? : "+savefileName);
            
            //������ ��θ� ���� �� ����
            Path savePath = Paths.get(savefileName);
						System.out.println("savePath�� ??? : "+savePath);
            
			//unique�� ������ �Բ� ���ϸ� �����ϱ�
			String saveName = uuid+"_"+originalName;
						System.out.println("saveName�� ??? : "+saveName);
			
			//product ������ ��ü�� fileName �������ֱ�
            product.setFileName(saveName);
            
            try {
            	//������ ���� �����ϴ� �κ�
                file.transferTo(savePath);
                System.out.println("file ���� �Ϸ�");
            } catch (IOException e) {
            	
                e.printStackTrace();
            }
		}
		
		System.out.println("/product/addProduct : POST");
		//Business Logic
		productService.addProduct(product);
		
		System.out.println("��ǰ�߰��Ϸ�");
		//���� �ֱٿ� insert �� prod_no �������� -> ?�������� insert �Ǿ��ٴ� ��=prod_no�� ���� ū�� !
		int prodNo = productService.getProdNoLast();
		System.out.println("insert �Ϸ� �� ������ ������ prodNo ? -> "+prodNo);
		
		Product product2 = new Product();
		product2 = productService.getProduct(prodNo);
		System.out.println("������ prodNo�� �ٽ� getProduct�� ��ü ->" + product2);
		
		model.addAttribute("product", product2);
		
		return "forward:/product/addProduct.jsp";
	}
	
	
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		System.out.println("prodNo int�� �� ����Ǿ����� ?  --> "+prodNo);
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		System.out.println("product �����ΰ��� ....? ->"+product);
		// Model �� View ����
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search,
							@RequestParam("menu") String menu,
							Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		System.out.println("menu �� �Ѿ� �Գ��� ?? --->"+menu);
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		System.out.println("resultpage �� ���õǾ����� ??? --->"+resultPage);
		System.out.println("menu �� �Ѿ� �Գ��� 222?? --->"+menu);
		System.out.println("list �� �Ѿ� �Գ��� ?? --->"+map.get("list"));

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
		System.out.println("��������???->" +manudate);
		
		product.setManuDate(manudate);
		
		// Model �� View ����
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
						
		
		System.out.println("uploadFile�Ѿ���°� ������ ? :" + uploadFile);
		System.out.println("hidden�� �ִ� filename ! -->" +product.getFileName());
				
		for(MultipartFile file : uploadFile){
					
						//���ϸ� ��������
			            String originalName = file.getOriginalFilename();
			            	System.out.println("file �̸���??? "+file);
			    			System.out.println("originalName�� ??? : "+originalName);
			    			
			    	//���� update�Ҷ� ���� �̹����� ���������� ������ ���� �̹��� ���Ϸ� ����� �� �ֵ���...		
			    	if (originalName != "") {
			    			
					    			//���ʿ��� �ڵ�? �������?
					    	//String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
					    			//System.out.println("fileName�� ??? : "+fileName);
			    		
			    		//����ũ�� ���� ������ -> ���� �� ���ε� �� ���
			            String uuid = UUID.randomUUID().toString();
			           
			            //������ ���� ��� ����: �Ϲ� ��� + ����ũ�� ���� + ���ϸ�
			            String savefileName = path + File.separator + uuid + "_" + originalName;
			            			System.out.println("savfileName�� ??? : "+savefileName);
			            
			            //������ ��θ� ���� �� ����
			            Path savePath = Paths.get(savefileName);
									System.out.println("savePath�� ??? : "+savePath);
			            
						//unique�� ������ �Բ� ���ϸ� �����ϱ�
						String saveName = uuid+"_"+originalName;
									System.out.println("saveName�� ??? : "+saveName);
						
						//product ������ ��ü�� fileName �������ֱ�
			            product.setFileName(saveName);
			    	   
			            try {
			            	//������ ���� �����ϴ� �κ�
			                file.transferTo(savePath);
			                System.out.println("file ���� �Ϸ�");
			            } catch (IOException e) {
			                e.printStackTrace();
			            }
			    	} 
				}
		
//		�Ľ��ؼ� 2013-03-01 ó�� ������ֱ�
		
		
			System.out.println("filename ! -->" +product.getFileName());
		productService.updateProduct(product);
		
		Product product2 = productService.getProduct(product.getProdNo());
		model.addAttribute("product", product2);
		return "forward:/product/updateProduct.jsp";
	}
}