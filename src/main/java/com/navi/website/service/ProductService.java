package com.navi.website.service;

import com.navi.service.BaseService;
import com.navi.utils.IPage;

import java.util.List;

public interface ProductService extends BaseService{

	IPage getPageBean(int currentPage, int pageSize, com.navi.website.model.Product model);

	List<com.navi.website.model.Product> getList(String type);

	List<com.navi.website.model.Product> getListWx(String type);


}
