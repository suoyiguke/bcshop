package com.navi.weixin.yinkai.service;

import com.navi.category.model.Category;
import com.navi.service.BaseService;
import com.navi.weixin.yinkai.pojo.EUTreeNode;

import java.util.List;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${商品分类}
 * @date 2018/7/623:16
 */
public interface ItemCategoryService extends BaseService {
    List<Category> getListFl();

    List<EUTreeNode> getCategoryList(String parentId);
/*
	AjaxMsg insertContentCategory(long parentId, String name);
*/
    List<Category>  getByIds(String[] ids);

}
