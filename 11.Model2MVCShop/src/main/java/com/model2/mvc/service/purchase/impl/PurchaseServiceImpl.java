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
	
	
	public Map<String, Object> getPurchaseList(Search search, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list",purchaseDao.getPurchaseList(search, userId));
		map.put("totalCount",purchaseDao.getTotalCount(search,userId));
		return map;
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