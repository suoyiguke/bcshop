//
// 覆盖jar包中的category
//

package com.navi.category.model;

import com.navi.dao.Table;

import java.io.Serializable;

@Table(
        name = "category"
)
public class Category implements Serializable {
    private String id;
    private String objname;
    private String pid;
    private int position;
    private int isDelete;
    private String img;

    private  String objdesc;

    private   int isActive;

    private  String createdate;
    private String modifydate;

    public Category() {
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getObjname() {
        return this.objname;
    }

    public void setObjname(String objname) {
        this.objname = objname;
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



    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public String getObjdesc() {
        return objdesc;
    }

    public void setObjdesc(String objdesc) {
        this.objdesc = objdesc;
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = createdate;
    }

    public String getModifydate() {
        return modifydate;
    }

    public void setModifydate(String modifydate) {
        this.modifydate = modifydate;
    }


    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }
}
