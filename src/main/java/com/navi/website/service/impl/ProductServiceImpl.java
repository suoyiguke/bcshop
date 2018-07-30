package com.navi.website.service.impl;

import com.navi.dao.QueryModel;
import com.navi.dao.SqlQueryModel;
import com.navi.service.impl.BaseServiceImpl;
import com.navi.utils.IPage;
import com.navi.utils.StringUtils;
import com.navi.website.model.Product;

import java.util.List;


public class ProductServiceImpl extends BaseServiceImpl implements com.navi.website.service.ProductService {

	@Override
	protected Class<?> getEntityClass() {
		return com.navi.website.model.Product.class;
	}

	@Override
	public IPage getPageBean(int currentPage, int pageSize,com.navi.website.model.Product s) {
		QueryModel m=new SqlQueryModel(tableName)
		.addCondition(StringUtils.isNotEmpty(s.getObjname()), "objname like ?", "%"+s.getObjname()+"%")
		.addCondition(StringUtils.isNotEmpty(s.getObjdesc()), "objdesc like ?", "%"+s.getObjdesc()+"%")
		.addCondition(StringUtils.isNotEmpty(s.getTypeId()), "typeId=?", s.getTypeId())
		.addCondition(StringUtils.isNotEmpty(s.getType()), "type=?", s.getType())
		.addCondition(s.getIsActive()!=-1, "isActive=?",s.getIsActive())
				.addCondition(StringUtils.isNotEmpty("app滑块"),"type!=?","app滑块")
		.addCondition("isDelete=?", 0).addOrderBy("position", true);
		IPage page=getPageBean(currentPage, pageSize, m);
		return page;
	}


	@Override
	public List<Product> getList(String type) {
		QueryModel m=new SqlQueryModel(tableName)
		.addCondition(StringUtils.isNotEmpty(type), "type=?", type)
		.addCondition("isDelete=?", 0).addOrderBy("position", true);
		return getList(m);
	}

	@Override
	public List<Product> getListWx(String type) {
		QueryModel m=new SqlQueryModel(tableName)
				.addCondition(StringUtils.isNotEmpty(type), "type=?", type)
				//发布
				.addCondition( "isActive=?",1)
				.addCondition("isDelete=?", 0)
				.addOrderBy("position", true);
		return getList(m);
	}


}
