package test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.liu.pojo.User;
import com.liu.pojo.UserLog;
import com.liu.service.impl.UserLogServiceImpl;
import com.liu.service.impl.UserServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:ApplicationContext.xml"})
public  class testtest {
	@Resource
	private UserServiceImpl userServiceImpl;
	@Resource
	private UserLogServiceImpl userLogServiceImpl; 
	@Test
	public void testmybatis()throws Exception
	{
//		Integer list=userServiceImpl.selectCount(); 
//		System.out.println("list:"+list);
//		List<User> list=userServiceImpl.selectAll(0, 1);
//		System.out.println(list.get(0).getPassword());
//		System.out.println(userServiceImpl.selectUserByUserId("admin").getNickname());
//		User user=new User();
//		user.setUserid("SinceNovember");
//		user.setNickname("lyda");
//		user.setPassword("6666");
//		System.out.println(userServiceImpl.deleteUser("SinceNovember"));
//		System.out.println(userLogServiceImpl.selectAllLog(0, 1));
//		System.out.println(userLogServiceImpl.selectLogByUserid("admin", 0, 5).size());
//		UserLog userLog=new UserLog();
//		userLog.setId("ASD");
//		userLog.setTime("456");
//		System.out.println(userLogServiceImpl.deleteLog("ASD"));
//		User user=new User();
//		user.setUserid("admin");
//		user.setSex(-1);
//		userServiceImpl.updateUser(user);
//		System.out.println(userServiceImpl.selectUserByUserId("admin"));
//		System.out.println(userLogServiceImpl.selectAllLog(0, 1));                             
//		System.out.println(userLogServiceImpl.selectAllLog(0, 1).get(0).getId());
//		System.out.println(userLogServiceImpl.selectLogByUserid("admin", 0, 1));
//		System.out.println(userLogServiceImpl.selectLogCount());
//		System.out.println(userLogServiceImpl.selectLogC                                                                                                                                                                                                                                                                                                                   ountByUserid("admin"));
//		UserLog userLog=new UserLog();
//		userLog.setUserid("admin");
//		userLog.setDetail("1111");
//		userLogServiceImpl.insertLog(userLog);
//		userLogServiceImpl.deleteThisUserLog("admin");
//		userLogServiceImpl.deleteAllLog();
//		System.out.println(userLogServiceImpl.selectLogByUserid("admin", 1, 7).size());
	}
}
