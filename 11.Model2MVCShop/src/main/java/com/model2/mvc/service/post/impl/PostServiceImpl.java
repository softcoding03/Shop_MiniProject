package com.model2.mvc.service.post.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.post.PostDao;
import com.model2.mvc.service.post.PostService;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserDao;
import com.model2.mvc.service.user.UserService;


@Service("postServiceImpl")
public class PostServiceImpl implements PostService{
	
	@Autowired
	@Qualifier("postDaoImpl")
	private PostDao postDao;
	public void setPostDao(PostDao postDao) {
		this.postDao = postDao;
	}
	
	
	//Constructor
	public PostServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addPost(Post post) throws Exception {
	postDao.addPost(post);
		
	}


	@Override
	public Post getPost(int postNo) throws Exception {
		return postDao.getPost(postNo);
		// TODO Auto-generated method stub
		
	}

}