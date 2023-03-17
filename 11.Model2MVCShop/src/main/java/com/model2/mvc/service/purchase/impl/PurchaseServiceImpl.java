package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
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

	
	public Map<String, Object> getPurchaseList(HashMap<String, Object> map) throws Exception {
		
		List<Purchase> list = purchaseDao.getPurchaseList(map); 
		User user = (User) map.get("user");
		
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