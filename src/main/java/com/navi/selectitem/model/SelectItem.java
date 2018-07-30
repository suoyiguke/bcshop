//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.navi.selectitem.model;

import com.navi.dao.Table;

import java.io.Serializable;

@Table(
        name = "selectitem"
)
public class SelectItem implements Serializable {
    private String id;
    private String idName;
    private String objname;
    private String objdesc;
    private String pid;
    private int position;
    private int isdelete;
    private String typeId;

    private String categoryId;

    public SelectItem() {
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdName() {
        return this.idName;
    }

    public void setIdName(String idName) {
        this.idName = idName;
    }

    public String getObjname() {
        return this.objname;
    }

    public void setObjname(String objname) {
        this.objname = objname;
    }

    public String getObjdesc() {
        return this.objdesc;
    }

    public void setObjdesc(String objdesc) {
        this.objdesc = objdesc;
    }

    public String getPid() {
        return this.pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public int getPosition() {
        return this.position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public int getIsdelete() {
        return this.isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public String getTypeId() {
        return this.typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }
}
