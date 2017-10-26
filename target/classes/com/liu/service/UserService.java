package com.liu.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.liu.pojo.User;

public interface UserService {
	List<User> selectAll(int page, int pageSize);
	User selectUserByUserId(String userid);
	Integer selectCount();
	boolean insertUser(User user);
	boolean updateUser(User user);
	boolean deleteUser(String userid);
}
