package com.model2.mvc.service.purchase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;



public interface PurchaseDao {

		
		// INSERT
		public void addPurchase(Purchase purchase) throws Exception ;
	
		// SELECT ONE
		public Purchase getPurchase(int tranNo) throws Exception ;
	
		// SELECT LIST
		public List<Purchase> getPurchaseList(HashMap<String, Object> map) throws Exception ;
		//map안에 Search search, String userId 담겨져서 넘겨 받아야함.
		
		// UPDATE Purchase
		public void updatePurchase(Purchase purchase) throws Exception ;
		
		// UPDATE TranCode
		public void updateTranCode(Purchase purchase) throws Exception ;
		
		
		public int getTotalCount(String userId) throws Exception ;
		

	
}
