package com.zhi.controller;

import java.text.SimpleDateFormat;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

/**
 * json-lib JSON日期处理类
 * @author 稚
 *
 */
public class DateJsonValueProcessor implements JsonValueProcessor{

	private String format;  
	
    public DateJsonValueProcessor(String format){ //构造  
        this.format = format;  
    }
    
    @Override
    public Object processArrayValue(Object arg0, JsonConfig arg1) {
    	// TODO Auto-generated method stub
    	return null;
    }
    
    @Override
	public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
		if(value == null){  
            return "";  
        }  
        if(value instanceof java.sql.Timestamp){  
            String str = new SimpleDateFormat(format).format((java.sql.Timestamp)value);  
            return str;  
        }  
        if (value instanceof java.util.Date){  
            String str = new SimpleDateFormat(format).format((java.util.Date) value);  
            return str;  
        }  
        return value.toString(); 
	}

}
