package com.liu.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.liu.pojo.UserLog;

public interface UserLogService {
	List<UserLog> selectAllLog(int page,int pageSize);
	List<UserLog> selectLogByUserid( String userid,int page,int pageSize);
	Integer selectLogCount();
	Integer selectLogCountByUserid(String userid,int PageSize);
	Integer selectLogcountfromuserid(String userid);
	boolean insertLog(UserLog userLog);
	boolean deleteLog(Integer id);
	boolean deleteThisUserLog(String userid);
	boolean deleteAllLog();
}
