package com.navi.weixin.yinkai.pojo;

import java.io.Serializable;

/**
 * easyUI树形控件节点格式====>改成ztree
 * <p>Title: EUTreeNode</p>
 * <p>Description: </p>
 * <p>Company: www.itcast.com</p> 
 * @author	入云龙
 * @date	2015年9月4日上午9:13:14
 * @version 1.0
 */
public class EUTreeNode implements Serializable{

	private String id;
	private String text;
	private String state;
	
	private long pid;


	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
