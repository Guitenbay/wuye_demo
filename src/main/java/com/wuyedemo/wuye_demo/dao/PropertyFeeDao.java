package com.wuyedemo.wuye_demo.dao;


import com.wuyedemo.wuye_demo.bean.PropertyFeeRecord;

import javax.sql.DataSource;
import java.util.List;

/**
 * 物业费缴纳接口
 */
public interface PropertyFeeDao {

    public void setDataSource(DataSource dataSource);

    public void create(String residentID, String residenceID, double fee);

    public List<PropertyFeeRecord> listFees();
}
