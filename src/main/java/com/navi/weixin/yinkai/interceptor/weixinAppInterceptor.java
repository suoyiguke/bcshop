package com.navi.weixin.yinkai.interceptor;

import com.navi.weixin.yinkai.jedis.JedisClient;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

public class weixinAppInterceptor implements HandlerInterceptor {



    @Resource
    private JedisClient jedisClient;

    @Value("${SESSION_TIME}")
    private  Integer SESSION_TIME;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HashMap<String, String> message = new HashMap<>();

        //判断用户的合法性

        String sessionId = (String) request.getParameter("sessionId");
        if (StringUtils.isBlank(sessionId)){
            message.put("state", "0");
            message.put("message", "sessionId为空，权限不足！");
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().println(message);
            return false;//页面请求没有传入sessionId，拦截

        }
        String openId = jedisClient.get(sessionId);
        if (StringUtils.isBlank(openId)){
            message.put("state", "0");
            message.put("message", "sessionId过期或不存在，请重新认证！");
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().println(message);
            return false;//sessionId过期或不存在，拦截
    }
        jedisClient.expire(sessionId,SESSION_TIME);//重置过期时间

        return true;


    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        //handler执行之后，ModerAndView返回之前
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//  ModelAndView 返回之后，异常处理
    }
}