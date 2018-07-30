package com.navi.weixin.yinkai.controller;

import com.navi.attach.service.AttachService;
import com.navi.category.model.Category;
import com.navi.utils.FastJsonUtils;
import com.navi.utils.MyUtils;
import com.navi.utils.SingletonUtils;
import com.navi.website.model.Product;
import com.navi.website.service.ProductService;
import com.navi.weixin.yinkai.jedis.JedisClient;
import com.navi.weixin.yinkai.pojo.CheckBean;
import com.navi.weixin.yinkai.pojo.TbUser;
import com.navi.weixin.yinkai.pojo.TbUserW;
import com.navi.weixin.yinkai.service.ItemCategoryService;
import com.navi.weixin.yinkai.service.TbUserService;
import com.navi.weixin.yinkai.service.impl.ItemCategoryServiceImpl;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author yinkai
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo 用户控制类}
 * @date 2018/6/2415:23
 */
@Controller
public class TbUserController {
    @Resource
    JedisClient jedisClient;


    TbUserService tbUserService = SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.TbUserServiceImpl");
    AttachService attachService = SingletonUtils.getSingleton("com.navi.attach.service.impl.AttachServiceImpl");
    ProductService productService = SingletonUtils.getSingleton("com.navi.website.service.impl.ProductServiceImpl");
    ItemCategoryService categoryService = (ItemCategoryServiceImpl) SingletonUtils.getSingleton("com.navi.weixin.yinkai.service.impl.ItemCategoryServiceImpl");

    @Value("${SESSION_TIME}")
    String SESSION_TIME;

    /**
     * 小程序----用户验证
     */
    @RequestMapping(value = "/weixin/checkUser", method = RequestMethod.GET)
    public void checkUser(HttpServletResponse response, @RequestParam(value = "js_code", required = false) String code) throws Exception {

        String checkString = tbUserService.checkUser(code);
        CheckBean checkBean = FastJsonUtils.getSingleBean(checkString, CheckBean.class);
        String uuid = MyUtils.getUUID();

        //存入redis，模拟session
        //z
        jedisClient.set(uuid, checkBean.getOpenid());
        System.out.println(SESSION_TIME);
        jedisClient.expire(uuid, Integer.parseInt(SESSION_TIME));
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println("{\"sessionId\":\"" + uuid + "\"}");//将sessionid返回


    }

    @RequestMapping(value = "/weixin/addUser", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public void addUser(@RequestBody TbUserW tbUserw, String sessionId) {
        TbUser tbUser = new TbUser();
        String openId = jedisClient.get(sessionId);
        tbUser = (TbUser) tbUserService.getList("select * from tb_user where openid = ?", openId).get(0);

        /*修改*/
        if (tbUser != null) {
            tbUser.setCity(tbUserw.getCity());
            tbUser.setCountry(tbUserw.getCountry());
            tbUser.setImgfile(tbUserw.getAvatarUrl());
            tbUser.setUsername(tbUserw.getNickName());

            tbUser.setUpdated(new Date());
            tbUserService.update(tbUser);

            /*添加*/
        } else {
            tbUser.setCity(tbUserw.getCity());
            tbUser.setCountry(tbUserw.getCountry());
            tbUser.setImgfile(tbUserw.getAvatarUrl());
            tbUser.setUsername(tbUserw.getNickName());
            tbUser.setCreated(new Date());
            tbUser.setId(MyUtils.getUUID());
            tbUser.setOpenId(jedisClient.get(sessionId));

            tbUserService.save(tbUser);
        }
    }


    //app获得滑块图片接口
    @RequestMapping(value = "/weixin/getHk", method = RequestMethod.GET)
    @ResponseBody
    public List<Product> getHk() throws Exception {

        List<Product> list = productService.getListWx("app滑块");
        return  list;
    }

    //app获得分类list接口
    @RequestMapping(value = "/weixin/getFlList",  method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Category> getFlList() throws Exception {

        List<Category> list = categoryService.getListFl();
        return  list;
    }
}




