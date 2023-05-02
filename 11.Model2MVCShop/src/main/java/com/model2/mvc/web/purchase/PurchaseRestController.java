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
	
	//�������� ������ �����ϴ� ����
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
			text = "��������";
		} else { 
			text ="��������";
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
			//tranNumber�� receiverPhone ��ȣ �����ͼ� �� ��ȣ�� �߼�
			System.out.println("   uid �Ѿ�°� 11?"+uid);
			int tranNo = Integer.parseInt(uid);
			Purchase purchase = purchaseService.getPurchase(tranNo);
			System.out.println("   purchase ? "+purchase);
			String phone = purchase.getReceiverPhone();
			String[] phoneNumber = phone.split("-"); //body������ ��ȣ�� �ԷµǾ�� ��
			userPhone = phoneNumber[0]+phoneNumber[1]+phoneNumber[2];
		} else {
			//prodNo �����ؼ� product ���� get�ϴ� ����
			System.out.println("   uid �Ѿ�°� 22?"+uid);
			String a = uid.substring(10); //prodNo ����
			int prodNo1 = Integer.parseInt(a);
			Product product = productService.getProduct(prodNo1);
			prodName =product.getProdName(); //����� ��ǰ �̸�
			
			//�������� get
			HttpSession session=request.getSession();
			User user = (User)session.getAttribute("user");
			userName = user.getUserName(); //����� user �̸�
			String phone = user.getPhone();
			String[] phoneNumber = phone.split("-"); //body������ ��ȣ�� �ԷµǾ�� ��
			userPhone = phoneNumber[0]+phoneNumber[1]+phoneNumber[2]; //����� user��ȭ��ȣ
			System.out.println("   split���� userPhone�� ??"+userPhone);
		}
			
			
			//���� ��
		
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		// ȣ��Ʈ URL
		String requestUrl= "/sms/v2/services/";               		// ��û URL
		String requestUrlType = "/messages";                      		// ��û URL
		String accessKey = "HoFpKO3WT9dHwGbJhDe5";                     	// ���̹� Ŭ���� �÷��� ȸ������ �߱޵Ǵ� ���� ����Ű			// Access Key : https://www.ncloud.com/mypage/manage/info > ����Ű ���� > Access Key ID
		String secretKey = "SET9yjOk6tNijRDhpxVy0DjPdMswALE8YepbtqoT";  // 2�� ������ ���� ���񽺸��� �Ҵ�Ǵ� service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > ����Ű ���� > Access Key ID	
		String serviceId = "ncp:sms:kr:305202255084:200ok";       // ������Ʈ�� �Ҵ�� SMS ���� ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > ���� ID
		String method = "POST";											// ��û method
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		
		// JSON �� Ȱ���� body data ����
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();
	    
	    //body �κп� �� ����� �ۼ�. 
	    //���� ���� �߼��� ���ؼ� APi���� �� ��.
	    bodyJson.put("type","SMS");
	    bodyJson.put("contentType","COMM");
	    bodyJson.put("from","01097833446");					// Mandatory, �߽Ź�ȣ, ���� ��ϵ� �߽Ź�ȣ�� ��� ����		
	    bodyJson.put("content","�������̾ȵǴ���..?");		// Mandatory(�ʼ�), �⺻ �޽��� ����, SMS: �ִ� 80byte, LMS, MMS: �ִ� 2000byte
	    if(uid.length() >6) {
	    	toJson.put("content","�ȳ��ϼ���, "+userName+"��"+"\n"+"'"+prodName+"'"+" ��ǰ���Ű� �Ϸ�Ǿ����ϴ�.");	// Optional, messages.content	���� �޽��� ����, SMS: �ִ� 80byte, LMS, MMS: �ִ� 2000byte
	    } else {
	    	toJson.put("content","��ǰ ����� ���۵Ǿ����ϴ�.");	// Optional, messages.content	���� �޽��� ����, SMS: �ִ� 80byte, LMS, MMS: �ִ� 2000byte
	    }
	    toJson.put("to", userPhone);						// Mandatory(�ʼ�), messages.to	���Ź�ȣ, -�� ������ ���ڸ� �Է� ����
	    toArr.add(toJson);
	    bodyJson.put("messages", toArr);					// Mandatory(�ʼ�), �Ʒ� �׸�� ���� (messages.XXX), �ִ� 1,000��
	    
	    //�ѱ� ���� �ذ��ϱ� ���� ���ڵ�
	    String body = new String(bodyJson.toString().getBytes("UTF-8"), "UTF-8");
	    
	    System.out.println("  ���� body? "+body);
	    
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
            if(responseCode == 202) { // ���� ȣ��
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // ���� �߻�
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
        return "����";
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
		System.out.println("   encodeBase64String��? "+encodeBase64String);
	  return encodeBase64String;
	}
		
	//�������� ��ȸ ����
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

		System.out.println("   ���������� map �������ذ� ?"+map);
		return map;
	}
}