package com.model2.mvc.web.purchase;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
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
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
	
	
	@RequestMapping( value="json/sendSMS/{uid}/{receiverPhone}/{receiverName}", method=RequestMethod.GET )
	public String sendSMS(@PathVariable String uid,
							@PathVariable String receiverPhone,
							@PathVariable String receiverName,
							HttpServletRequest request) throws Exception{
		System.out.println("   �Ѿ�°� ?"+uid+" & "+receiverPhone+" & "+receiverName);
		String userName =receiverName;
		String Phone =receiverPhone;
		String[] phoneNumber = Phone.split("-"); //body������ ��ȣ�� �ԷµǾ�� ��
		String userPhone = phoneNumber[0]+phoneNumber[1]+phoneNumber[2];
		String prodName =null;
		
		///////////prodNo �����ؼ� product ���� get�ϴ� ����
		if (uid.length() > 6) {
		System.out.println("   uid �Ѿ�°� 22? "+uid);
		String a = uid.substring(10); //prodNo ����
		int prodNo1 = Integer.parseInt(a);
		Product product = productService.getProduct(prodNo1);
		prodName =product.getProdName(); //����� ��ǰ �̸�
		}
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
	    if(uid.length() > 6) {
	    	toJson.put("content","�ȳ��ϼ���, "+userName+"��"+"\n"+"'"+prodName+"'"+" ��ǰ���Ű� �Ϸ�Ǿ����ϴ�.");	// Optional, messages.content	���� �޽��� ����, SMS: �ִ� 80byte, LMS, MMS: �ִ� 2000byte
	    } else if(uid.length() == 1) {
	    	toJson.put("content","������ ��ǰ���Ű� ��ҵǾ����ϴ�.");
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
	
		//���� ȯ�� ��û ����
		@RequestMapping( value="json/refund/{tranNo}", method=RequestMethod.GET )
		public String refund(@PathVariable int tranNo) throws Exception{
			System.out.println("   tranNO ??? "+tranNo);
			System.out.println("/purchase/json/refund : GET");
			
			Purchase purchase = purchaseService.getPurchase(tranNo);
			purchase.setRefund("1");
			purchaseService.updatePurchase(purchase);
			
			System.out.println("  refund �� 1�� ���� �Ϸ�");
			
			return "����Ϸ�";
		}
		
		//ȯ�� ��û �� �˸�
		@RequestMapping( value="json/getrefund", method=RequestMethod.GET )
		public String getrefund() throws Exception{
			
		int count = purchaseService.getRefund();
		System.out.println("  refund ���� ? "+count);
		String countRefund = Integer.toString(count);
			
		return countRefund;
		}
		
		
		//������Ʈ�� ȯ�� ��û
		@RequestMapping( value="json/importRefund/{merchantUid}/{tranNo}", method=RequestMethod.GET )
		public Purchase importRefund(@PathVariable String merchantUid, 
									@PathVariable int tranNo) throws Exception{
		System.out.println("  merUid�� ? "+merchantUid);
		
		//access_token �߱��� ���� api��û
			HttpURLConnection con =null;
			String access_token = null;
			URL url = new URL("https://api.iamport.kr/users/getToken"); //��ū �޾ƿ� �ּ�
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Accept", "application/json");
			con.setDoOutput(true);
			
			JSONObject obj = new JSONObject();
			obj.put("imp_key", "4255836747306555");
			obj.put("imp_secret", "kK2C2bK9csuHsNYd2joo532en1ceozF53kCqPNVQH4ySfonayKDFCiXtLli43TrrUCqsnUEY3TNFDRl4");
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			bw.write(obj.toString());
			bw.flush();
			bw.close();
			
			//�����κ��� ���� ������ �ޱ�
			String a =null;
			int result = 0;
			int responseCode = con.getResponseCode();
			System.out.println("  �����ڵ�?"+responseCode);
			if(responseCode == 200) {
				System.out.println("  ���伺�� !");
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder sb = new StringBuilder();
				String line = null;
				while ((line = br.readLine()) != null) {
					sb.append(line+"\n");
				}
				br.close();
				System.out.println(""+sb.toString());
				result = 1; // ���� �� 1 ��ȯ
				a = sb.toString(); //{"code":0,"message":null,"response":{"access_token":"0d48967625d8bdc10436308979c60b780932d27d","now":1683142902,"expired_at":1683144628}}
				JSONObject jsonObject = (JSONObject) new JSONParser().parse(a);
				access_token = (String) ((JSONObject) jsonObject.get("response")).get("access_token");
				System.out.println(access_token);
				
				///��� ����
				HttpsURLConnection conn = null;
				url = new URL("https://api.iamport.kr/payments/cancel");
		 
				conn = (HttpsURLConnection) url.openConnection();
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-type", "application/json");
				conn.setRequestProperty("Accept", "application/json");
				conn.setRequestProperty("Authorization", access_token);
				conn.setDoOutput(true);
				
				JSONObject json = new JSONObject();
				json.put("merchant_uid", merchantUid);
		 
			    bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(json.toString());
				bw.flush();
				bw.close();
				
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		 
				br.close();
				conn.disconnect();
				System.out.println("  ��� �Ϸ� !!");
			} else {
				System.out.println(con.getResponseMessage());
			}
			
			//�ٷ� ���� ������ ���� ���� ���� �����ֱ�.
			Purchase purchase = purchaseService.getPurchase(tranNo);
			System.out.println(" ������ ���� �� purchase? "+purchase);
			purchase.setRefund("2"); 			//refund db '1'(ȯ�ҿ�û) -> '2'(��ҿϷ�)�� ����
			purchaseService.updatePurchase(purchase);
		return purchase;
		}
		
}