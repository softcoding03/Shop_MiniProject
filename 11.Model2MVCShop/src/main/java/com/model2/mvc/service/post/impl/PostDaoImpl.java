package com.model2.mvc.service.post.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.*;
import com.model2.mvc.service.post.PostDao;
import com.model2.mvc.service.product.ProductDao;

//==> 惑前包府 DAO CRUD 备泅
@Repository("postDaoImpl")
public class PostDaoImpl implements PostDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public PostDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addPost(Post post) throws Exception {
		sqlSession.insert("PostMapper.addPost", post);
	}

	public Post getPost(int postNo) throws Exception {
		return sqlSession.selectOne("PostMapper.getPost", postNo);
	}
}