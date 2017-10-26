<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>WebChat | 个人信息</title>
    <jsp:include page="view/include/commonfile.jsp"/>
</head>
<body>
<jsp:include page="view/include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="view/include/sidebar.jsp"/>

    <!-- content start -->
    <div class="admin-content">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">${userid}的个人信息</strong> / <small>info</small></div>
        </div>
        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="#tab1">个人信息</a></li>
            </ul>
            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                    <div class="am-g">
                        <div class="am-u-md-3"><b>昵称:保密</b></div>
                        <div class="am-u-md-6" style="float: right">
                            <img class="am-circle" src="${pageContext.request.contextPath}/${user.profilehead}" width="140" height="140" alt="${user.nickname}"/>
                        </div>

                        <div class="am-u-md-3"><b>性别:保密</b></div>
                        <div class="am-u-md-3"><b>年龄:保密</b></div>
                        <div class="am-u-md-3"><b>简介:保密</b></div>
                        <div class="am-u-md-3"><b>注册时间:保密</b></div>
                        <div class="am-u-md-3"><b>最后登录:保密</b></div>
                    </div>
                </div>
            </div>
    </div>
    <!-- content end -->
</div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span>
</a>
<jsp:include page="view/include/footer.jsp"/>
</div>
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
}</script>
</body>
</html>
