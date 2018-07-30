package com.navi.website.service.impl;

import com.navi.dao.QueryModel;
import com.navi.dao.SqlQueryModel;
import com.navi.service.impl.BaseServiceImpl;
import com.navi.utils.IPage;
import com.navi.utils.StringUtils;
import com.navi.website.model.News;
import com.navi.website.service.NewsService;

public class NewsServiceImpl extends BaseServiceImpl implements NewsService{

	@Override
	protected Class<?> getEntityClass() {
		return News.class;
	}

	@Override
	public IPage getPageBean(int currentPage, int pageSize, News s) {
		QueryModel m=new SqlQueryModel(tableName)
		.addCondition(StringUtils.isNotEmpty(s.getObjname()), "objname like ?", "%"+s.getObjname()+"%")
		.addCondition(StringUtils.isNotEmpty(s.getObjdesc()), "objdesc like ?", "%"+s.getObjdesc()+"%")
		.addCondition(StringUtils.isNotEmpty(s.getTypeId()), "typeId=?", s.getTypeId())
		.addCondition(s.getIsActive()!=-1, "isActive=?",s.getIsActive())
		.addCondition("isDelete=?", 0)
		.addOrderBy("publishdate", false)
		.addOrderBy("position", true);
		IPage page=getPageBean(currentPage, pageSize, m);
		return page;
	}


}
