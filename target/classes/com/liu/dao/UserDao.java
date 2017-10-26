package com.liu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.liu.pojo.User;

public interface UserDao {
	List<User> selectAll(@Param("offset") int offset,@Param("limit") int limit);
	User selectUserByUserId(String userid);
	int selectCount();
	boolean insertUser(User user);
	boolean updateUser(User user);
	boolean deleteUser(String userid);
}
