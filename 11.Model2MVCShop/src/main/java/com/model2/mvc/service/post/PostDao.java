package com.model2.mvc.service.post;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.*;


//==> 상품관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
	public interface PostDao {
		
		public void addPost(Post post) throws Exception ;
		public Post getPost(int postNo) throws Exception ;
		
	}
