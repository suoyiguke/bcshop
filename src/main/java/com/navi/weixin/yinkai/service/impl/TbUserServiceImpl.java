package com.navi.weixin.yinkai.service.impl;

import com.navi.service.impl.BaseServiceImpl;
import com.navi.utils.HttpRequest;
import com.navi.weixin.yinkai.pojo.TbUser;
import com.navi.weixin.yinkai.service.TbUserService;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/6/2415:37
 */

public class TbUserServiceImpl extends BaseServiceImpl  implements TbUserService {
    @Override
    protected Class<?> getEntityClass() {
        return TbUser.class;
    }

    @Override
    public String checkUser(String code) {

        String url = "https://api.weixin.qq.com/sns/jscode2session";
        String param = "appid=wx46ea0c1fbfbd6710&secret=d13b7177ca0e3e58aa4fcfa34c8c8881&js_code=" + code + "&grant_type=authorization_code";
        return HttpRequest.sendGet(url, param);
    }
}
