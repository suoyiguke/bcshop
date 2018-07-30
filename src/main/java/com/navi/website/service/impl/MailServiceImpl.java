package com.navi.website.service.impl;

import com.navi.dao.QueryModel;
import com.navi.dao.SqlQueryModel;
import com.navi.service.impl.BaseServiceImpl;
import com.navi.utils.IPage;
import com.navi.utils.StringUtils;
import com.navi.website.service.MailService;


public class MailServiceImpl extends BaseServiceImpl implements MailService {

	@Override
	protected Class<?> getEntityClass() {
		return com.navi.website.model.Mail.class;
	}




	@Override
	public IPage getPageBean(int currentPage, int pageSize,com.navi.website.model.Mail model) {
		QueryModel m=new SqlQueryModel(tableName)
				.addCondition(StringUtils.isNotEmpty(model.getObjname()), "objname like ?", "%"+model.getObjname()+"%")
				.addCondition(StringUtils.isNotEmpty(model.getCompanyname()), "companyname like ?", "%"+model.getCompanyname()+"%")
				.addCondition(StringUtils.isNotEmpty(model.getUsername()), "username like ?", "%"+model.getUsername()+"%")
				.addCondition("isDelete=?", 0)
				.addOrderBy("isView", false)
				.addOrderBy("createdate", false);
		IPage page=getPageBean(currentPage, pageSize, m);
		return page;
	}
}
