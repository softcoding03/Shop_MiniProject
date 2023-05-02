package com.model2.mvc.web.purchase;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
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
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	//가격으로 결제를 검증하는 로직
	@RequestMapping( value="json/price/{prodNo}/{price}", method=RequestMethod.GET )
	public String comparePrice(@PathVariable String prodNo,
								@PathVariable int price) throws Exception{
		System.out.println("   prodNo 넘어온거는 ??? "+prodNo);
		System.out.println("   price 넘어온거는 ??? "+price);
		//이 prodNo를 가지고 db의 price랑 import에서 결제한 가격이랑 같은지 판단
		String a = prodNo.substring(10);
		System.out.println(a);
		int prodNo1 = Integer.parseInt(a);
		System.out.println(prodNo1);
		
		Product product = productService.getProduct(prodNo1);
		System.out.println("   product 가져온거는 ???"+product);
		
		String text = null;
		if (price == product.getPrice()) {
			text = "검증성공";
		} else { 
			text ="검증실패";
		}
		System.out.println("   text ?"+text);
		return text;
	}
	
	
	@RequestMapping( value="json/sendSMS/{uid}", method=RequestMethod.GET )
	public String sendSMS(@PathVariable String uid, HttpServletRequest request) throws Exception{
		String userName =null;
		String prodName=null;
		String userPhone;
		if(uid.length() <=6) {
			//tranNumber로 receiverPhone 번호 가져와서 그 번호로 발송
			System.out.println("   uid 넘어온거 11?"+uid);
			int tranNo = Integer.parseInt(uid);
			Purchase purchase = purchaseService.getPurchase(tranNo);
			System.out.println("   purchase ? "+purchase);
			String phone = purchase.getReceiverPhone();
			String[] phoneNumber = phone.split("-"); //body에서는 번호만 입력되어야 함
			userPhone = phoneNumber[0]+phoneNumber[1]+phoneNumber[2];
		} else {
			//prodNo 추출해서 product 정보 get하는 로직
			System.out.println("   uid 넘어온거 22?"+uid);
			String a = uid.substring(10); //prodNo 추출
			int prodNo1 = Integer.parseInt(a);
			Product product = productService.getProduct(prodNo1);
			prodName =product.getProdName(); //사용할 상품 이름
			
			//유저정보 get
			HttpSession session=request.getSession();
			User user = (User)session.getAttribute("user");
			userName = user.getUserName(); //사용할 user 이름
			String phone = user.getPhone();
			String[] phoneNumber = phone.split("-"); //body에서는 번호만 입력되어야 함
			userPhone = phoneNumber[0]+phoneNumber[1]+phoneNumber[2]; //사용할 user전화번호
			System.out.println("   split해준 userPhone은 ??"+userPhone);
		}
			
			
			//저장 끝
		
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		// 호스트 URL
		String requestUrl= "/sms/v2/services/";               		// 요청 URL
		String requestUrlType = "/messages";                      		// 요청 URL
		String accessKey = "HoFpKO3WT9dHwGbJhDe5";                     	// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
		String secretKey = "SET9yjOk6tNijRDhpxVy0DjPdMswALE8YepbtqoT";  // 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID	
		String serviceId = "ncp:sms:kr:305202255084:200ok";       // 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
		String method = "POST";											// 요청 method
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		
		// JSON 을 활용한 body data 생성
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();
	    
	    //body 부분에 들어갈 내용들 작성. 
	    //예약 문자 발송을 위해선 APi참고 할 것.
	    bodyJson.put("type","SMS");
	    bodyJson.put("contentType","COMM");
	    bodyJson.put("from","01097833446");					// Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능		
	    bodyJson.put("content","왜전송이안되는지..?");		// Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    if(uid.length() >6) {
	    	toJson.put("content","안녕하세요, "+userName+"님"+"\n"+"'"+prodName+"'"+" 상품구매가 완료되었습니다.");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    } else {
	    	toJson.put("content","상품 배송이 시작되었습니다.");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    }
	    toJson.put("to", userPhone);						// Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
	    toArr.add(toJson);
	    bodyJson.put("messages", toArr);					// Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개
	    
	    //한글 에러 해결하기 위한 인코딩
	    String body = new String(bodyJson.toString().getBytes("UTF-8"), "UTF-8");
	    
	    System.out.println("  세팅 body? "+body);
	    
        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            		
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes("UTF-8"));
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
        return "성공";
	}
		
	private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
	    String space = " ";                    // one space
	    String newLine = "\n";                 // new line
	    

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey;
	    String encodeBase64String;
		try {
			
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		    encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			encodeBase64String = e.toString();
		}
		System.out.println("   encodeBase64String는? "+encodeBase64String);
	  return encodeBase64String;
	}
		
	//간략정보 조회 로직
	@RequestMapping( value="json/getPurchase/{tranNo}/{prodNo}", method=RequestMethod.GET )
	public Map<String , Object> getPurchase(@PathVariable int tranNo,
											@PathVariable int prodNo) throws Exception{
		System.out.println("   tranNO ??? "+tranNo);
		System.out.println("   prodNo ??? "+prodNo);
		System.out.println("/purchase/json/getPurchase : GET");
		
		Map<String , Object> map = new HashMap<String , Object>();
		
		Product product = productService.getProduct(prodNo);
		Purchase purchase = purchaseService.getPurchase(tranNo);
		map.put("product", product);
		map.put("purchase", purchase);

		System.out.println("   마지막으로 map 세팅해준거 ?"+map);
		return map;
	}
}