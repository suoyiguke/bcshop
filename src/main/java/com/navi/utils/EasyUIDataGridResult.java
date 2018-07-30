package com.navi.utils;

import java.io.Serializable;
import java.util.List;

public class EasyUIDataGridResult implements Serializable {

    private Integer total;//数据条数/list.size()

    private List<?> rows;//存放目标pojo的list

    public void  EasyUIResult(Integer total, List<?> rows) {
        this.total = total;
        this.rows = rows;
    }

    public void  EasyUIResult(Long total, List<?> rows) {
        this.total = total.intValue();
        this.rows = rows;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }

}