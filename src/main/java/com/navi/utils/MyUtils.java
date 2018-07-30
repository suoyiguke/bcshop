package com.navi.utils;

import java.util.UUID;

/**
 * @author ceshi
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/6/3020:59
 */
public class MyUtils {

    public static String getUUID(){
       return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
