package com.wuyedemo.wuye_demo.dao;


import com.wuyedemo.wuye_demo.bean.PropertyRecord;

import javax.sql.DataSource;
import java.util.List;

/**
 *  房产登记接口
 */
public interface PropertyDao {

    public void setDataSource(DataSource dataSource);

    public void create(String residentID, String residenceID, double fee);

    public List<PropertyRecord> listProperties();
}
