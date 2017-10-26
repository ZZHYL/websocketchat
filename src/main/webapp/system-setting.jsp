<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>WebChat | 系统设置</title>
    <jsp:include page="view/include/commonfile.jsp"/>
</head>
<body>
<jsp:include page="view/include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="view/include/sidebar.jsp"/>

    <!-- content start -->
    <div class="admin-content">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">系统设置</strong> / <small>form</small></div>
        </div>

        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="#tab1">基本设置</a></li>
                <li ><a href="#tab2">修改头像</a></li>
                <li ><a href="#tab3">修改密码</a></li>
            </ul>
				<div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                    <form class="am-form am-form-horizontal" action="${ctx}/changesystem/${userid}"  method="post">
                    <div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">分页大小</label>
                     <div class="am-u-sm-10">
                    <div class="am-btn-group doc-js-btn-1" data-am-button>
  					<label class="am-btn am-btn-primary">
  				 	<input type="radio" name="options" value=5 checked="checked">5
  					</label>
  					<label class="am-btn am-btn-primary">
   					<input type="radio" name="options" value=10>10
  					</label>
  					<label class="am-btn am-btn-primary">
    				<input type="radio" name="options" value=15>15 
 					</label>
 					<label class="am-btn am-btn-primary ">
   					<input type="radio" name="options" value=20>20
  					</label>
  					</div>
					</div>
					</div>					
					<div class="am-form-group">
                    <label class="am-u-sm-2 am-form-label">我的信息</label>
                     <div class="am-u-sm-10">
                    <div class="am-btn-group doc-js-btn-1" data-am-button>
  					<label class="am-btn am-btn-primary">
  				 	<input type="radio" name="secrecy" value=-1>保密
  					</label>
  					<label class="am-btn am-btn-primary">
   					<input type="radio" name="secrecy" value=1 checked="checked">不保密
  					</label>
  					</div>
					</div>
					</div>
                           <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交</button>
                            </div>
                        </div>
                          </form>
                          </div>

 					<div class="am-tab-panel am-fade" id="tab2">
                    <form class="am-form am-form-horizontal" action="${ctx}/upload/${userid}" enctype="multipart/form-data" method="post" onsubmit="return checkFileType();" style="text-align: center;">
                        <div style="text-align: center;margin-bottom: 10px">
                            <img class="am-circle" src="${ctx}/${user.profilehead}" width="140" height="140" alt="加载失败"/>
                        </div>
                        <div class="am-form-group am-form-file">
                            <button type="button" class="am-btn am-btn-secondary am-btn-sm">
                                <i class="am-icon-cloud-upload"></i> 选择要上传的文件</button>
                            <input id="file" type="file" name="file" multiple>
                        </div>
                        <div id="file-list"></div>
                        <button type="submit" class="am-btn am-round am-btn-success"><span class="am-icon-upload"></span> 上传头像</button>
                        <script>
                            $(function() {
                                $('#file').on('change', function() {
                                    var fileNames = '';
                                    $.each(this.files, function() {
                                        fileNames += '<span class="am-badge">' + this.name + '</span> ';
                                    });
                                    $('#file-list').html(fileNames);
                                });
                            });
                        </script>
                    </form>
                </div>
                  <div class="am-tab-panel am-fade" id="tab3">
                    <form class="am-form am-form-horizontal" data-am-validator action="${ctx}/modifypassword/${userid}" method="post">
                        <div class="am-form-group">
                            <label for="password1" class="am-u-sm-2 am-form-label">原密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password1" name="oldpass" required placeholder="请输入原密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="password2" class="am-u-sm-2 am-form-label">新密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password2" name="newpass" required placeholder="请输入新密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="password3" class="am-u-sm-2 am-form-label">确认新密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password3" data-equal-to="#password2" required placeholder="请确认新密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交修改</button>
                            </div>
                        </div>
                    </form>
                </div>
                          </div>
                          </div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span>
</a>
<jsp:include page="view/include/footer.jsp"/>
<script>
    if("${message}"){
        layer.msg('${message}', {
            offset: 0,
        });
    }
    if("${error}"){
        layer.msg('${error}', {
            offset: 0,
            shift: 6
        });
    }
</script>
</body>
</html>
