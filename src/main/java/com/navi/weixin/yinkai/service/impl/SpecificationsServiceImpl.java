package com.navi.weixin.yinkai.service.impl;

import com.navi.service.impl.BaseServiceImpl;
import com.navi.weixin.yinkai.pojo.Specifications;
import com.navi.weixin.yinkai.service.SpecificationsService;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/7/2813:17
 */
public class SpecificationsServiceImpl extends BaseServiceImpl implements SpecificationsService {
    @Override
    protected Class<?> getEntityClass() {
        return Specifications.class;
    }
}
