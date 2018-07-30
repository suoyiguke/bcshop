package com.navi.website.service;

import com.navi.service.BaseService;
import com.navi.utils.IPage;


public interface NewsService extends BaseService{

	IPage getPageBean(int currentPage, int pageSize, com.navi.website.model.News model);

}
