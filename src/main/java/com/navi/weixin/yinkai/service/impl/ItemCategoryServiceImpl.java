package com.navi.weixin.yinkai.service.impl;

import com.navi.category.model.Category;
import com.navi.dao.QueryModel;
import com.navi.dao.SqlQueryModel;
import com.navi.dao.jdbc.IDataService;
import com.navi.service.impl.BaseServiceImpl;
import com.navi.weixin.yinkai.pojo.EUTreeNode;
import com.navi.weixin.yinkai.service.ItemCategoryService;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${商品分类service}
 * @date 2018/7/623:17
 */
public class ItemCategoryServiceImpl extends BaseServiceImpl implements ItemCategoryService {

    static final String ITEM_PID = "4028a6816234766001623476eed40003";

    @Override
    protected Class<?> getEntityClass() {
        return Category.class;
    }

    @Override
    public List<Category> getListFl() {

        QueryModel queryModel = new SqlQueryModel("category")
                //必要约束条件
                .addCondition("isdelete=?", 0)
                //必要约束条件
                .addCondition("pid=?", ITEM_PID)
                //按position升序
                .addOrderBy("position", true);

        return super.getList(queryModel);
    }


    //根据parentid查询节点列表
    @Override
    public List<EUTreeNode> getCategoryList(String  parentId) {

        QueryModel queryModel = new SqlQueryModel("category")
                //必要约束条件
                .addCondition("isdelete=?", 0)
                //必要约束条件
                .addCondition("pid=?", parentId)
                //按position升序
                .addOrderBy("position", true);

        List<Category> list = super.getList(queryModel);

        //执行查询

        List<EUTreeNode> resultList = new ArrayList<>();
        for (Category category : list) {
            //创建一个节点
            EUTreeNode node = new EUTreeNode();
            node.setId(category.getId());
            node.setText(category.getObjname());
            node.setState(false?"closed":"open");

            resultList.add(node);
        }
        return resultList;
    }

    @Override
    public List<Category> getByIds(String[] ids) {
        List arrayList = new ArrayList();
        for (int i = 0; i < ids.length; i++) {
            Category category = super.getById(ids[i]);
            arrayList.add(category);
        }
        return  arrayList;
    }
}
