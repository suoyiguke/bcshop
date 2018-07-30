package com.navi.weixinmanager.yinkai.controller;

import com.navi.attach.service.AttachService;
import com.navi.category.model.Category;
import com.navi.dao.QueryModel;
import com.navi.dao.SqlQueryModel;
import com.navi.dao.jdbc.IDataService;
import com.navi.selectitem.model.SelectItem;
import com.navi.selectitem.service.SelectItemService;
import com.navi.utils.*;
import com.navi.web.AjaxMsg;
import com.navi.web.WebUtils;
import com.navi.website.model.Product;
import com.navi.website.service.ProductService;
import com.navi.weixin.yinkai.pojo.EUTreeNode;
import com.navi.weixin.yinkai.pojo.Specifications;
import com.navi.weixin.yinkai.pojo.TbItem;
import com.navi.weixin.yinkai.service.ItemCategoryService;
import com.navi.weixin.yinkai.service.ItemService;
import com.navi.weixin.yinkai.service.SpecificationsService;
import com.navi.weixin.yinkai.service.TbUserService;
import com.navi.weixin.yinkai.service.impl.ItemCategoryServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author yinkai
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/7/111:09
 */

@Controller
public class ManagerController {

    static final String ITEM_PID = "4028a6816234766001623476eed40003";
    static final String FL_PID = "402880e664898817016489a8ba3a0028";


    SpecificationsService specificationsService = SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.SpecificationsServiceImpl");

    ItemService itemService = SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.ItemServiceImpl");

    TbUserService tbUserService = SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.TbUserServiceImpl");
    ProductService productService = SingletonUtils.getSingleton("com.navi.website.service.impl.ProductServiceImpl");
    ItemCategoryService categoryService = (ItemCategoryServiceImpl) SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.ItemCategoryServiceImpl");
    AttachService attachService = (AttachService) SingletonUtils.getSingleton("com.navi.attach.service.impl.AttachServiceImpl");
    IDataService dataService = SingletonUtils.getSingleton("com.navi.dao.jdbc.impl.MySQLDataServiceImpl");

    SelectItemService selectitemService = (SelectItemService) SingletonUtils.getSingleton("com.navi.selectitem.service.impl.SelectItemServiceImpl");

    /*用户管理*/
    @RequestMapping(value = "/weixinmanager/getAllUser", produces = "application/json")
    @ResponseBody
    public EasyUIDataGridResult getAllUser(Integer page, Integer rows) {
        QueryModel queryModel = new SqlQueryModel("tb_user");

        IPage pageBean = tbUserService.getPageBean(NumberUtils.objToInt(page, 1), NumberUtils.objToInt(rows, 10), queryModel);
        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(pageBean.getRecordList());
        easyUIDataGridResult.setTotal(pageBean.getRecordCount());
        return easyUIDataGridResult;
    }

    /*滑块管理*/

    //滑块查询
    @RequestMapping(value = "/weixinmanager/getHk", produces = "application/json")
    @ResponseBody
    public EasyUIDataGridResult getHk(Integer page, Integer rows) {

        List<Product> list = productService.getList("app滑块");
        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(list);
        easyUIDataGridResult.setTotal(list.size());

        return easyUIDataGridResult;
    }

    //滑块修改回显页面
    @RequestMapping("/weixinmanager/editUI")
    public ModelAndView editUI(HttpServletRequest req, String id) {
        Product model = productService.getById(id);
        ModelAndView mav = new ModelAndView("/weixin/hk_addUI");
        mav.addObject("product", model);

        return mav;
    }

    //滑块添加
    @RequestMapping(value = "/weixinmanager/addHk", produces = "application/json")
    @ResponseBody
    public AjaxMsg addHk(Integer page, Integer rows, Product product) {

        product.setCreatedate(DateUtils.getCurrentDateTime());
        product.setType("app滑块");
        productService.save(product);
        AjaxMsg m = new AjaxMsg(1, "添加成功!");

        return m;

    }


    @RequestMapping(value = "/weixinmanager/deleteHk")
    public AjaxMsg deleteHk(String id) throws IOException {

        AjaxMsg m = new AjaxMsg(1, "删除成功!");
        String[] ids = null;
        if (StringUtils.isEmpty(id)) {
            m.setMsg("您没有选择删除项!");
            m.setIsOk(0);
        } else {
            ids = new String[]{id};
            if (id.indexOf(",") != -1) {
                ids = id.split(",");
            }
            boolean flag = productService.deleteByIds(ids);
            if (!flag) {
                m.setIsOk(0);
                m.setMsg("选中的对象中有对象包含子项，不能删除！");
            }
        }

        return m;

    }

    @RequestMapping(value = "/weixinmanager/editHk", produces = "application/json")
    @ResponseBody
    public AjaxMsg editHk(String id, HttpServletRequest request) throws IOException {
        AjaxMsg m = new AjaxMsg(1, "修改成功!");
        if (StringUtils.isNotEmpty(id)) {
            Product s = productService.getById(id);
            s.setModifydate(DateUtils.getCurrentDateTime());
            WebUtils.requestToBean(s, request);
            productService.update(s);
        } else {
            m.setIsOk(0);
            m.setMsg("修改的id为空");
        }
        return m;
    }

    /*==============================管理分类===============================================*/
    //查看商品分类
    @RequestMapping(value = "/weixinmanager/getItemFlList", produces = "application/json")
    @ResponseBody
    public EasyUIDataGridResult getItemFlList(Integer page, Integer rows) throws IOException {

        QueryModel queryModel = new SqlQueryModel("category")
                //必要约束条件
                .addCondition("isdelete=?", 0)
                //必要约束条件
                .addCondition("pid=?", ITEM_PID)
                //按position升序
                .addOrderBy("position", true);

        IPage pageBean = categoryService.getPageBean(NumberUtils.objToInt(page, 1), NumberUtils.objToInt(rows, 10), queryModel);
        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(pageBean.getRecordList());
        easyUIDataGridResult.setTotal(pageBean.getRecordCount());
        return easyUIDataGridResult;


    }


    //添加商品分类
    @RequestMapping(value = "/weixinmanager/addItemFl", produces = "application/json")
    @ResponseBody
    public AjaxMsg addItemFl(Category category) {
        category.setPid(ITEM_PID);
        category.setCreatedate(DateUtils.getCurrentDateTime());
        category.setModifydate(DateUtils.getCurrentDateTime());
        this.categoryService.save(category);
        AjaxMsg m = new AjaxMsg(1, "添加成功!");

        return m;

    }

    //商品分类修改UI
    @RequestMapping("/weixinmanager/editItemFlUI")
    public ModelAndView editItemFlUI(String id) {


        Category category = categoryService.getById(id);
        ModelAndView mav = new ModelAndView("/weixin/fl_addUI");
        mav.addObject("category", category);

        return mav;
    }

    //商品分类修改
    @RequestMapping(value = "/weixinmanager/editItemFl", produces = "application/json")
    @ResponseBody
    public AjaxMsg editItemFl(String id, HttpServletRequest request) throws IOException {
        AjaxMsg m = new AjaxMsg(1, "修改成功!");
        if (StringUtils.isNotEmpty(id)) {
            Category s = categoryService.getById(id);
            s.setModifydate(DateUtils.getCurrentDateTime());
            WebUtils.requestToBean(s, request);
            categoryService.update(s);
        } else {
            m.setIsOk(0);
            m.setMsg("修改的id为空");
        }
        return m;
    }

    //商品分类删除
    @RequestMapping(value = "/weixinmanager/deleteItemFl")
    public AjaxMsg deleteItemFl(String id) throws IOException {

        AjaxMsg m = new AjaxMsg(1, "删除成功!");
        String[] ids = null;
        int length;
        if (StringUtils.isEmpty(id)) {
            m.setMsg("您没有选择删除项!");
            m.setIsOk(0);
        } else {
            ids = new String[]{id};
            length = ids.length;
            if (id.indexOf(",") != -1) {
                ids = id.split(",");
            }
            boolean flag = categoryService.deleteByIds(ids);

            if (!flag) {
                m.setIsOk(0);
                m.setMsg("选中的对象中有对象包含子项，不能删除！");
            }

            //删除对应图片====
            String inSelect = getInSelect(ids);
            System.out.println(inSelect);
            //查出分类的img
            String s = "select img from category where id in " + inSelect;
            System.out.println(s);
            List<Category> list = categoryService.getList(s);
            String[] arr = new String[length];
            for (int i = 0; i < arr.length; i++) {
                arr[i] = list.get(i).getImg();
            }
            attachService.deleteByIds(arr);
            // int i = dataService.executeSql("delete from category where img in " + getInSelect(arr));


        }

        return m;

    }

    public String getInSelect(String[] strs) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < strs.length; i++) {
            sb.append("'" + strs[i] + "'");//拼接单引号,到数据库后台用in查询.
            if (i != strs.length - 1) {//前面的元素后面全拼上",",最后一个元素后不拼
                sb.append(",");
            }
        }
        return "(" + sb.toString() + ")";
    }

    @RequestMapping("/weixinmanager/getFlTreeList")
    @ResponseBody
    private List<EUTreeNode> getFlTreeList(String id) {

        if (StringUtils.isEmpty(id)) {
            id = ITEM_PID;
        }
        List<EUTreeNode> list = categoryService.getCategoryList(id);
        return list;
    }


    /*规格**************************************************/

    /**
     * @Description(TODO 按商品分类查询它的规格参数)
     * @author 尹凯
     * @date 2018/7/14 16:41
     */
    @RequestMapping(value = "/weixinmanager/getGgcsListByFlId")
    @ResponseBody
    public EasyUIDataGridResult getGgcsListByFlId(Integer page, Integer rows, String id) {


        QueryModel queryModel = new SqlQueryModel("selectitem")
                //必要约束条件
                .addCondition("isdelete=?", 0)
                //必要约束条件
                .addCondition("pid=?", FL_PID)
                .addCondition(StringUtils.isNotEmpty(id), "categoryId=?", id)//动态约束条件
                //按position升序
                .addOrderBy("position", true);


        IPage pageBean = selectitemService.getPageBean(NumberUtils.objToInt(page, 1), NumberUtils.objToInt(rows, 10), queryModel);
        List<SelectItem> recordList = pageBean.getRecordList();
        String[] arr = new String[recordList.size()];
        for (int i = 0; i < recordList.size(); i++) {
            arr[i] = recordList.get(i).getCategoryId();
        }


        List<Category> categorys = categoryService.getByIds(arr);

        for (int i = 0; i < categorys.size(); i++) {
            recordList.get(i).setCategoryId(categorys.get(i).getObjname());
        }

        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(pageBean.getRecordList());
        easyUIDataGridResult.setTotal(pageBean.getRecordCount());
        return easyUIDataGridResult;


    }


    //添加商品规格参数
    @RequestMapping(value = "/weixinmanager/addItemGg", produces = "application/json")
    @ResponseBody
    public AjaxMsg addItemGg(SelectItem selectItem) {
        selectItem.setPid(FL_PID);

        selectitemService.save(selectItem);
        AjaxMsg m = new AjaxMsg(1, "添加成功!");

        return m;

    }


    //修改商品规格参数
    @RequestMapping(value = "/weixinmanager/updateItemGg", produces = "application/json")
    @ResponseBody
    public AjaxMsg updateItemGg(String id, HttpServletRequest request) {
        AjaxMsg m = new AjaxMsg(1, "修改成功!");
        if (StringUtils.isNotEmpty(id)) {
            SelectItem se = selectitemService.getById(id);

            WebUtils.requestToBean(se, request);
            selectitemService.update(se);
        } else {
            m.setIsOk(0);
            m.setMsg("修改的id为空");
        }
        return m;

    }


    //商品规格批量删除
    @RequestMapping(value = "/weixinmanager/deleteSelectItems", produces = "application/json")
    @ResponseBody
    public AjaxMsg deleteSelectItems(String id) {

        AjaxMsg m = new AjaxMsg(1, "删除成功!");
        String[] ids = null;
        if (StringUtils.isEmpty(id)) {
            m.setMsg("您没有选择删除项!");
            m.setIsOk(0);
        } else {
            ids = new String[]{id};
            if (id.indexOf(",") != -1) {
                ids = id.split(",");
            }
            boolean flag = selectitemService.deleteByIds(ids);
            if (!flag) {
                m.setIsOk(0);
                m.setMsg("选中的对象中有对象包含子项，不能删除！");
            }
        }

        return m;


    }

    //

    //商品列表
    @RequestMapping(value = "/weixinmanager/getItemList", produces = "application/json")
    @ResponseBody
    public EasyUIDataGridResult getItemList(Integer page, Integer rows, String id) throws IOException {


        QueryModel queryModel = new SqlQueryModel("tb_item")

                //必要约束条件
                .addCondition("isdelete=?", 0)

                //商品分类查询
                .addCondition(StringUtils.isNotEmpty(id), "cid=?", id)
                //按position升序
                .addOrderBy("position", true);


        IPage pageBean = itemService.getPageBean(NumberUtils.objToInt(page, 1), NumberUtils.objToInt(rows, 10), queryModel);
        List<TbItem> recordList = pageBean.getRecordList();

        //==================分类名==========================
        String arry[] = new String[recordList.size()];
        for (int i = 0; i < recordList.size(); i++) {
            arry[i] = recordList.get(i).getCid();
        }

        if (arry.length == 0) {
            EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
            easyUIDataGridResult.setRows(pageBean.getRecordList());
            easyUIDataGridResult.setTotal(pageBean.getRecordCount());
            return easyUIDataGridResult;
        }

        List<Category> categoryList = dataService.getBeanList(Category.class, "SELECT * from category where id in" + getInSelect(arry));
        for (int j = 0; j < categoryList.size(); j++) {
            for (int k = 0; k < recordList.size(); k++) {
                if (categoryList.get(j).getId().equals(recordList.get(k).getCid())) {
                    recordList.get(k).setCid(categoryList.get(j).getObjname());
                }
            }
        }


        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(pageBean.getRecordList());
        easyUIDataGridResult.setTotal(pageBean.getRecordCount());
        return easyUIDataGridResult;


    }


    //规格参数列表Specifications
    @RequestMapping(value = "/weixinmanager/getGgcsValue", produces = "application/json")
    @ResponseBody
    public EasyUIDataGridResult getGgcsValue(Integer page, Integer rows, String id) throws IOException {


        QueryModel queryModel = new SqlQueryModel("specifications")

                //必要约束条件
                .addCondition(StringUtils.isNotEmpty(id), "itemid=?", id)//动态约束条件

                //必要约束条件
                .addCondition("isdelete=?", 0)

                //按position升序
                .addOrderBy("position", true);

        IPage pageBean = specificationsService.getPageBean(NumberUtils.objToInt(page, 1), NumberUtils.objToInt(rows, 10), queryModel);
        List<Specifications> recordList = pageBean.getRecordList();
        String arr[] = new String[recordList.size()];
        for (int i = 0; i < recordList.size(); i++) {
            arr[i] = recordList.get(i).getItemid();
        }

        if (arr.length == 0) {
            EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
            easyUIDataGridResult.setRows(pageBean.getRecordList());
            easyUIDataGridResult.setTotal(pageBean.getRecordCount());
            return easyUIDataGridResult;
        }

        //==================商品名==========================
        List<TbItem> tbItemList = dataService.getBeanList(TbItem.class, "SELECT * from tb_item where id in" + getInSelect(arr));
        for (int j = 0; j < tbItemList.size(); j++) {
            for (int k = 0; k < recordList.size(); k++) {
                if (tbItemList.get(j).getId().equals(recordList.get(k).getItemid())) {
                    recordList.get(k).setItemid(tbItemList.get(j).getTitle());
                }
            }
        }


        //==================分类名==========================
        String arry[] = new String[recordList.size()];
        for (int i = 0; i < recordList.size(); i++) {
            arry[i] = recordList.get(i).getFlid();
        }

        List<SelectItem> selectItemList = dataService.getBeanList(SelectItem.class, "SELECT * from selectitem where id in" + getInSelect(arry));
        for (int j = 0; j < selectItemList.size(); j++) {
            for (int k = 0; k < recordList.size(); k++) {
                if (selectItemList.get(j).getId().equals(recordList.get(k).getFlid())) {
                    recordList.get(k).setFlid(selectItemList.get(j).getObjname());
                }
            }
        }


        EasyUIDataGridResult easyUIDataGridResult = new EasyUIDataGridResult();
        easyUIDataGridResult.setRows(pageBean.getRecordList());
        easyUIDataGridResult.setTotal(pageBean.getRecordCount());
        return easyUIDataGridResult;


    }


    //添加/修改商品规格参数
    @RequestMapping(value = "/weixinmanager/addANDeditItemGgcs", produces = "application/json")
    @ResponseBody
    public AjaxMsg addANDeditItemGgcs(Specifications specifications, HttpServletRequest request) {
        AjaxMsg m=new AjaxMsg();

        if (StringUtils.isNotEmpty(specifications.getId())) {
            //修改
            m = new AjaxMsg(1, "修改成功!");
            Specifications s = specificationsService.getById(specifications.getId());
            s.setModifydate(DateUtils.getCurrentDateTime());
            WebUtils.requestToBean(s, request);
            specificationsService.update(s);
        } else {
            //添加
            m = new AjaxMsg(1, "添加成功!");
            specifications.setCreatedate(DateUtils.getCurrentDateTime());
            specifications.setModifydate(DateUtils.getCurrentDateTime());
            specifications.setIsDelete(0);
            this.specificationsService.save(specifications);


        }
        return m;


    }


    //删除商品规格参数
    @RequestMapping(value = "/weixinmanager/deleteGgcsValue", produces = "application/json;charset=utf-8")
    @ResponseBody
    public AjaxMsg deleteGgcsValue(String id) throws IOException {

        AjaxMsg m = new AjaxMsg(1, "删除成功!");
        String[] ids = null;
        if (StringUtils.isEmpty(id)) {
            m.setMsg("您没有选择删除项!");
            m.setIsOk(0);
        } else {
            ids = new String[]{id};
            if (id.indexOf(",") != -1) {
                ids = id.split(",");
            }
            boolean flag = specificationsService.deleteByIds(ids);
            if (!flag) {
                m.setIsOk(0);
                m.setMsg("选中的对象中有对象包含子项，不能删除！");
            }
        }

        return m;

    }





    /*easyUI控件的ajax请求***************************************************************************************************/

    //easyUI回显数据
    @RequestMapping(value = "/weixinmanager/getSelectItem", produces = "application/json")
    @ResponseBody
    public SelectItem getSelectItem(String id) {

        return selectitemService.getById(id);

    }


    //
    @RequestMapping(value = "/weixinmanager/getGgTitle", produces = "application/json")
    @ResponseBody
    public List<Map<String, Object>> getGgTitle(String id) {


        String sql = "SELECT\n" +
                "	se.id,\n" +
                "  se.objname\n" +
                "	\n" +
                "FROM\n" +
                "	tb_item item\n" +
                "	INNER JOIN category ca ON item.cid = ca.id\n" +
                "	INNER JOIN selectitem se ON ca.id = se.categoryId\n" +
                "	\n" +
                "	WHERE item.id = ?";


        List<Map<String, Object>> mapList = dataService.getMapList(sql, id);

        return mapList;

    }

    ///weixinmanager/getAddGgcsValue
    @RequestMapping(value = "/weixinmanager/getAddGgcsFormValue", produces = "application/json")
    @ResponseBody
    public Specifications getAddGgcsFormValue(String id) {

        return specificationsService.getById(id);

    }
}
