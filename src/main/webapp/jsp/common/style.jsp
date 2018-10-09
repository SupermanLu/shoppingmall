<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<!-- load css -->
<link rel="stylesheet" type="text/css" href="${domain}/js/layui/css/layui.css"
	media="all">
<link rel="stylesheet" type="text/css" href="${domain}/css/global.css"
	media="all">
<link rel="stylesheet" type="text/css"
	href="${domain}/css/adminstyle.css" media="all">
<!-- 加载js文件-->
<script type="text/javascript" src="${domain}/js/jquery-2.1.1.min.js"></script>
<script>
	function logout() {
		$.ajax({
			url : "${domain}/users/logout",
			type : "POST",
			contentType : "application/json",
			success : function(res) {
				if(res.status=="success"){
					window.location.href="${domain}/jsp/sys/login.jsp";
				}
			}
		});
	}

	$(function() {
		$('body').on('click', '#loginout', function() {
			logout();
		})
	})
</script>
<script type="text/javascript" src="${domain}/js/layui/layui.js"></script>
<script type="text/javascript" src="${domain}/js/larry.js"></script>
<!-- <script type="text/javascript" src="${domain}/js/larry.js"></script> -->

