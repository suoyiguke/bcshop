package com.navi.website.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.navi.selectitem.model.SelectItem;
import com.navi.selectitem.service.SelectItemService;
import com.navi.utils.*;
import com.navi.web.AjaxMsg;
import com.navi.web.WebUtils;
import com.navi.website.model.Product;
import com.navi.website.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/website/product")
public class ProductAction {
	ObjectMapper mapper = SingletonUtils.getSingleton("com.fasterxml.jackson.databind.ObjectMapper"); 
	ProductService productService=SingletonUtils.getSingleton("com.navi.website.service.impl.ProductServiceImpl");
	SelectItemService selectitemService=SingletonUtils.getSingleton("com.navi.selectitem.service.impl.SelectItemServiceImpl");
	
	private void addTypeList(ModelAndView mav){
		SelectItem s=selectitemService.getByIdName("wproduct");
		if(s!=null){
			List<SelectItem> typeList=selectitemService.getByPid(s.getId());
			mav.addObject("typeList", typeList);
		}
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("/website/product_list");
		int currentPage=NumberUtils.objToInt(req.getParameter("currentPage"), 1);
		int pageSize=NumberUtils.objToInt(req.getParameter("pageSize"), 15);
		Product model=WebUtils.requestToBean(req, Product.class);
		IPage page=productService.getPageBean(currentPage, pageSize, model);
		mav.addObject("pageBean", page);
		mav.addObject("product",model);
		addTypeList(mav);
		return mav;
	}
	
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("/website/product_index");
		int currentPage=NumberUtils.objToInt(req.getParameter("currentPage"), 1);
		int pageSize=NumberUtils.objToInt(req.getParameter("pageSize"), 9);
		Product model=WebUtils.requestToBean(req, Product.class);
		model.setIsActive(1);
		IPage page=productService.getPageBean(currentPage, pageSize, model);
		mav.addObject("pageBean", page);
		mav.addObject("product",model);
		addTypeList(mav);
		return mav;
	}
	
	
	
	@RequestMapping("/delete")
	public void delete(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		AjaxMsg m=new AjaxMsg(1,"删除成功!");
		String id=req.getParameter("ids");
		String[] ids=null;
		if(StringUtils.isEmpty(id)){
			m.setMsg("您没有选择删除项!");
			m.setIsOk(0);
		}else{
			ids=new String[]{id};
			if(id.indexOf(",")!=-1){
				ids=id.split(",");
			}
			boolean flag=productService.deleteByIds(ids);
			if(!flag){
				m.setIsOk(0);
				m.setMsg("选中的对象中有对象包含子项，不能删除！");
			}
		}
		PrintWriter out=resp.getWriter();
		String json=mapper.writeValueAsString(m);
		out.print(json);
		out.close();
	}
	
	@RequestMapping("/addUI")
	public ModelAndView addUI(HttpServletRequest req){
		ModelAndView mav=new ModelAndView("/website/product_addUI");
		addTypeList(mav);
		return mav;
	}
	
	
	
	@RequestMapping("/add")
	public void add(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		Product s=WebUtils.requestToBean(req, Product.class);
		s.setCreatedate(DateUtils.getCurrentDateTime());
		productService.save(s);
		AjaxMsg m=new AjaxMsg(1,"添加成功!");
		PrintWriter out=resp.getWriter();
		String json=mapper.writeValueAsString(m);
		out.print(json);
		out.close();
	}
	
	@RequestMapping("/editUI")
	public ModelAndView editUI(HttpServletRequest req,String id){
		Product model=productService.getById(id);
		ModelAndView mav=new ModelAndView("/website/product_addUI");
		mav.addObject("product", model);
		addTypeList(mav);
		return mav;
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest req,String id){
		Product model=productService.getById(id);
		ModelAndView mav=new ModelAndView("/website/product_view");
		mav.addObject("product", model);
		addTypeList(mav);
		return mav;
	}
	
	@RequestMapping("/edit")
	public void edit(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		AjaxMsg m=new AjaxMsg(1,"修改成功!");
		String id=req.getParameter("id");
		if (StringUtils.isNotEmpty(id)) {
			Product s=productService.getById(id);
			s.setModifydate(DateUtils.getCurrentDateTime());
			WebUtils.requestToBean(s,req);
			productService.update(s);
		}else{
			m.setIsOk(0);
			m.setMsg("修改的id为空");
		}
		PrintWriter out=resp.getWriter();
		String json=mapper.writeValueAsString(m);
		out.print(json);
		out.close();
	}
}
