package main.java.com.navi.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	private DateUtils(){
		
	}
	public static final String YYYY_MM_DD_HH_MM_SS="yyyy-MM-dd HH:mm:ss";
	public static final String YYYY_MM_DD_HH_MM_SSS="yyyy-MM-dd HH:mm:sss";
	public static final String YYYY_MM_DD="yyyy-MM-dd";
	public static final String HH_MM_SS="HH:mm:ss";
	public static final String HH_MM_SSS="HH:mm:sss";
	public static final String HH_MM="HH:mm";
	private static SimpleDateFormat df=new SimpleDateFormat();
	
	public static String getCurrentDateTime() {
		return date2String(YYYY_MM_DD_HH_MM_SS, new Date());
	}
	
	public static String getCurrentDate(){
		return date2String(YYYY_MM_DD, new Date());
	}
	
	public static String getCurrentDate(String pattern){
		return date2String(pattern, new Date());
	}
	
	public synchronized static String date2String(String pattern, Date date){
		if(pattern==null||date==null){
			throw new IllegalArgumentException();
		}
		df.applyPattern(pattern);
		return df.format(date);
	}
	/**
	 * 获取每个月的天数
	 * @param year
	 * @param month
	 * @return
	 */
	public static int getDaysOfMonth(int year, int month){
		Calendar calendar=Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month-1);
		int days=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		return days;
	}
	
	/**
	 * 将monthOrDay专成日期格式的月或者天
	 * @param monthOrDay
	 * @return
	 */
	public static String getFormatDayOrMonth(int monthOrDay){
		String ret=monthOrDay+"";
		if(monthOrDay<=9){
			ret="0"+monthOrDay;
		}
		return ret;
	}
	
	public synchronized static long getTimestamp(String dateStr, String pattern){
		df.applyPattern(pattern);
		try {
			Date date=df.parse(dateStr);
			return date.getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public static String timestampToStr(long timestamp, String pattern) {
		Date date=new Date(timestamp);
		return date2String(pattern, date);
	}
	
	public static String getShowTime(long timestamp){
		if(timestamp<=0){
			return "";
		}
		String result="";
		long currentTime=new Date().getTime();
		long sec=(currentTime-timestamp)/1000;
		long days=0;
		long hour=0;
		long min=0;
		long second=sec%60;
		Date date=new Date(timestamp);
		if(sec>7*24*3600){
			result=date2String(YYYY_MM_DD, date);
		}else if(sec>2*24*3600){
			days=sec/(3600*24);
			result=days+"days before";
//		}else if(sec>2*24*3600){
//			result="前天 "+date2String(HH_MM, date);
		}else if(sec>24*3600){
			result="yesterday "+date2String(HH_MM, date);
		}else if(sec>3600){
			hour=sec/3600;
			result=hour+"hours before";
		}else if(sec>60){
			min=sec/60;
			result=min+"mins before";
		}else if(sec>10){
			result=second+"secs before";
		}else{
			result="just now";
		}
		return result;
	}
	
	public static String getDateStr(long timestamp, String pattern){
		if(timestamp<=0){
			return "";
		}
		Date date=new Date(timestamp);
		return date2String(pattern, date);
	}
	
}
