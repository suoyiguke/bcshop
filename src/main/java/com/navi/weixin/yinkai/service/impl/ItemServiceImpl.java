package com.navi.weixin.yinkai.service.impl;

import com.navi.service.impl.BaseServiceImpl;
import com.navi.weixin.yinkai.pojo.TbItem;
import com.navi.weixin.yinkai.service.ItemService;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/7/2322:24
 */
public class ItemServiceImpl extends BaseServiceImpl  implements ItemService {
    @Override
    protected Class<?> getEntityClass() {
        return TbItem.class;
    }
}
