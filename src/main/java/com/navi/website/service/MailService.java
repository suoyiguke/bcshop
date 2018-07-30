package com.navi.website.service;

import com.navi.service.BaseService;
import com.navi.utils.IPage;


public interface MailService extends BaseService{

	IPage getPageBean(int currentPage, int pageSize, com.navi.website.model.Mail model);
	
}
