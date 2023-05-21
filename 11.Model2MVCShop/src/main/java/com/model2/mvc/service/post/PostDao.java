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


//==> ��ǰ�������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
	public interface PostDao {
		
		public void addPost(Post post) throws Exception ;
		public Post getPost(int postNo) throws Exception ;
		
	}
