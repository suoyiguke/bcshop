package com.yinkai;

import com.navi.utils.SingletonUtils;

import com.navi.website.service.MailService;
import com.navi.weixin.yinkai.jedis.JedisClient;
import com.navi.weixin.yinkai.jedis.JedisClientPool;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class test {

    ApplicationContext applicationContext;
    @Before
    public void Before(){

    }

    @Test
    public void tets() {

        applicationContext =new ClassPathXmlApplicationContext("classpath:bean-jedis.xml","classpath:bean-properties.xml");
        System.err.println(applicationContext);
        JedisClient jedisClient = (JedisClientPool) applicationContext.getBean("jedisClientPool");
        System.out.println(jedisClient);

        System.out.println(jedisClient.get("username"));


    }


  @Test
    public void testDao(){
      applicationContext =new ClassPathXmlApplicationContext("classpath:beans.xml");
      System.err.println(applicationContext);


        MailService mailService=SingletonUtils.getSingleton("com.navi.website.service.impl.MailServiceImpl");


    }
}
