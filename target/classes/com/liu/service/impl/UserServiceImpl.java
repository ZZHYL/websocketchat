package com.liu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.liu.dao.UserDao;
import com.liu.pojo.User;
import com.liu.service.UserService;
@Service(value="userService")
public class UserServiceImpl implements UserService {
	@Resource
	private UserDao userDao;
	public List<User> selectAll(int page, int pageSize) {
		// TODO Auto-generated method stub
		return userDao.selectAll(page, pageSize);
	}

	public User selectUserByUserId(String userid) {
		// TODO Auto-generated method stub
		return userDao.selectUserByUserId(userid);
	}

	public Integer selectCount() {
		// TODO Auto-generated method stub
		return userDao.selectCount();
	}

	public boolean insertUser(User user) {
		// TODO Auto-generated method stub
		return userDao.insertUser(user);
	}

	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user);
	}

	public boolean deleteUser(String userid) {
		// TODO Auto-generated method stub
		return userDao.deleteUser(userid);
	}

}
