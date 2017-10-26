package com.liu.pojo;

public class User {
	   private String userid;      //用户名
	    private String password;    //密码
	    private String nickname;    //昵称
	    private int sex;            //性别
	    private int age;            //年龄
	    private String profilehead; //头像
	    private String profile;     //简介
	    private String firsttime;   //注册时间
	    private String lasttime;    //最后登录时间
	    private int status;      //账号资料是否公开（1公开-1不公开
		public String getUserid() {
			return userid;
		}
		public void setUserid(String userid) {
			this.userid = userid;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public int getSex() {
			return sex;
		}
		public void setSex(int sex) {
			this.sex = sex;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
		public String getProfilehead() {
			return profilehead;
		}
		public void setProfilehead(String profilehead) {
			this.profilehead = profilehead;
		}
		public String getProfile() {
			return profile;
		}
		public void setProfile(String profile) {
			this.profile = profile;
		}
		public String getFirsttime() {
			return firsttime;
		}
		public void setFirsttime(String firsttime) {
			this.firsttime = firsttime;
		}
		public String getLasttime() {
			return lasttime;
		}
		public void setLasttime(String lasttime) {
			this.lasttime = lasttime;
		}
		public int getStatus() {
			return status;
		}
		public void setStatus(int status) {
			this.status = status;
		}
	    
}
