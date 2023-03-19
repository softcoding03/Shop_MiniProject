package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	public void setProductDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	//Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
		System.out.println("구매정보 insert완료");
	}

	
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.getPurchase(tranNo);
	}

	
	//마지막 insert된 구매이력의 tran_no
	public int getPurchaseLast() throws Exception {
		int tranNo = purchaseDao.getPurchaseLast();
		return tranNo;
	}
	
	
	public Map<String, Object> getPurchaseList(HashMap<String, Object> map) throws Exception {
		
		List<Purchase> list = purchaseDao.getPurchaseList(map); 
		User user = (User) map.get("user");
		
		System.out.println("    ServiceImple에서 list 는 ?" +list);
		
		int prodNo = list.get(0).getPurchaseProd().getProdNo();
		System.out.println("    prodNo는 ? "+prodNo);
		
		//prodNo있는 걸로 product 객체 Get 해오고 그 정보들 purchaseProd로 세팅해주기
		Product product = productDao.getProduct(prodNo);
		System.out.println("    새롭게 세팅해준 product ? : "+product);
		
		list.get(0).setPurchaseProd(product);
		
		int totalCount = purchaseDao.getTotalCount(user.getUserId());
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("list", list );
		map2.put("totalCount", new Integer(totalCount));
		
		return map2;
	}

	
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
		System.out.println("구매정보 수정완료");
	}

	
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
		System.out.println("구매 상태 코드 수정완료");
	}

	
}