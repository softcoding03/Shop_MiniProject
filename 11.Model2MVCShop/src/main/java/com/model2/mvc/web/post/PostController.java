package com.model2.mvc.web.post;


import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.post.PostService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 게시판관리 Controller
@Controller
@RequestMapping("/post/*")
public class PostController {
	///Field
		@Autowired
		@Qualifier("postServiceImpl")
		private PostService postService;
	
	public PostController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addPost", method=RequestMethod.GET)
	public String addPost() throws Exception {

		System.out.println("/post/addPostView : GET");
			
		return "forward:/post/addPostView.jsp";
	}
	
	@RequestMapping(value="addPost", method=RequestMethod.POST)
	public String addPost2(@ModelAttribute("post") Post post,
							Model model) throws Exception {

		System.out.println("/post/addPostView : POST");
			post.setPostImage("이미지");
			postService.addPost(post);
			
			Post post2 = postService.getPost(10000);
			System.out.println("product 무엇인가요 ....? ->"+post2);
			// Model 과 View 연결
			model.addAttribute("post", post2);
		return "forward:/post/getPost.jsp";
	}
	/*
	 * @RequestMapping(value="getPost", method=RequestMethod.GET) public String
	 * getPost(Model model) throws Exception {
	 * 
	 * System.out.println("/get/getPost: GET"); //Business Logic
	 * 
	 * 
	 * return "forward:/post/getPost.jsp"; }
	 */
	
	
	
	
	
	
	
	@RequestMapping(value="analytics", method=RequestMethod.GET)
	public String analytics() throws Exception {

		System.out.println("/post/analytics : GET");
		
		return "forward:/etc/analytics.jsp";
	}
} 