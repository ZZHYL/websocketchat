package test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.liu.service.impl.UserServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:ApplicationContext.xml"})
public class testmybatis {
	@Resource
	private UserServiceImpl userServiceImpl;
	public void testmybatis()throws Exception
	{
		Integer list=userServiceImpl.selectCount(); 
		System.out.println("list:"+list);
	}
}
