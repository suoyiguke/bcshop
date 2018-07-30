package com.navi.website.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.navi.setitem.service.SetItemService;
import com.navi.utils.*;
import com.navi.web.AjaxMsg;
import com.navi.web.WebUtils;
import com.navi.website.model.Mail;
import com.navi.website.service.MailService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/website/mail")
public class MailAction {
	ObjectMapper mapper = SingletonUtils.getSingleton("com.fasterxml.jackson.databind.ObjectMapper"); 
	MailService mailService=SingletonUtils.getSingleton("com.navi.website.service.impl.MailServiceImpl");
	SetItemService setItemService=SingletonUtils.getSingleton("com.navi.setitem.service.impl.SetItemServiceImpl");
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("/website/mail_list");
		int currentPage=NumberUtils.objToInt(req.getParameter("currentPage"), 1);
		int pageSize=NumberUtils.objToInt(req.getParameter("pageSize"), 15);
		Mail model=WebUtils.requestToBean(req, Mail.class);
		IPage page=mailService.getPageBean(currentPage, pageSize, model);
		mav.addObject("pageBean", page);
		mav.addObject("mail",model);
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
			boolean flag=mailService.deleteByIds(ids);
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
	
	
	
	@RequestMapping("/index")
	public ModelAndView addUI(HttpServletRequest req){
		ModelAndView mav=new ModelAndView("/website/mail_index");
		mav.addObject("coords",setItemService.getValueByIdName("website-coords"));
		mav.addObject("name", setItemService.getValueByIdName("website-username"));
		mav.addObject("tel1", setItemService.getValueByIdName("website-tel1"));
		mav.addObject("tel2", setItemService.getValueByIdName("website-tel2"));
		mav.addObject("email", setItemService.getValueByIdName("website-email"));
		mav.addObject("address", setItemService.getValueByIdName("website-address"));
		return mav;
	}
	
	
	@RequestMapping("/add")
	public void add(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		Mail s=WebUtils.requestToBean(req, Mail.class);
		s.setCreatedate(DateUtils.getCurrentDateTime());
		mailService.save(s);
		AjaxMsg m=new AjaxMsg(1,"添加成功!");
		PrintWriter out=resp.getWriter();
		String json=mapper.writeValueAsString(m);
		out.print(json);
		out.close();
	}
	
	@RequestMapping("/handle")
	public void handle(HttpServletRequest req,HttpServletResponse resp,String id) throws IOException {
		Mail s=mailService.getById(id);
		s.setIsView(1);
		mailService.update(s);
		AjaxMsg m=new AjaxMsg(1,"处理成功!");
		PrintWriter out=resp.getWriter();
		String json=mapper.writeValueAsString(m);
		out.print(json);
		out.close();
	}
	
	
}
