package com.model2.mvc.service.post;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

//==> 상품관리에서 서비스할 내용 추상화/캡슐화한 Service Interface Definition  
public interface PostService {
	
	public void addPost(Post post) throws Exception ;
	public Post getPost(int postNo) throws Exception ;
}
