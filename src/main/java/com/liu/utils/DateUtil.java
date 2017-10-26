package com.liu.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public String getDateformat()
	{
		Date date=new Date();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowdate=format.format(date);
		return nowdate;
	}
}
