package com.navi.website.action;

import com.navi.utils.SingletonUtils;
import com.navi.website.model.News;
import com.navi.website.model.Product;
import com.navi.website.service.NewsService;
import com.navi.website.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 网站首页
 */
@Controller
@RequestMapping("/website")
public class WebSiteAction {
	private ProductService productService=SingletonUtils.getSingleton("com.navi.website.service.impl.ProductServiceImpl");
	private NewsService newsService=SingletonUtils.getSingleton("com.navi.website.service.impl.NewsServiceImpl");
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest req){
		ModelAndView mav=new ModelAndView("/website/index");
		List<Product> lbList=productService.getList("首页轮播");
		List<Product> twList=productService.getList("首页图文");
		mav.addObject("lbList", lbList);
		mav.addObject("twList", twList);
		return mav;
	}
	
	@RequestMapping("/aboutus")
	public ModelAndView aboutus(HttpServletRequest req){
		ModelAndView mav=new ModelAndView("/website/aboutus");
		News news=newsService.getById("402881ec6343804c016343804c300000");
		mav.addObject("news", news);
		return mav;
	}
	
}
