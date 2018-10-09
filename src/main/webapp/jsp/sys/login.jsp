<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>登录</title>
<link rel="stylesheet" type="text/css" href="${domain}/css/styles.css">
<link rel="stylesheet" type="text/css" href="${domain}/layui/css/layui.css">


<script src="${domain}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="${domain}/layui/layui.js" type="text/javascript"></script>
</head>
<body>
	<div class="htmleaf-container">
		<div class="wrapper">
			<div class="container">
				<h1>Welcome</h1>

				<form class="form">
					<input id="username" type="text" placeholder="Username"> <input
						id="password" type="password" placeholder="Password">
					<button type="submit" id="login-button">Login</button>
				</form>
			</div>

			<ul class="bg-bubbles">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
		</div>
	</div>

	<script>
		layui.use('layer', function() { //独立版的layer无需执行这一句
			var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

			$('#login-button').click(function(event) {
				event.preventDefault();

				loginIn();
			});
			//用户名密码错误
			function alertError(msg) {
				layer.open({
					title:'错误提示',
					id : 'layerDemoauto' //防止重复弹出
					,
					content : '<font color="#000">'+msg+'</font>',
					yes : function() {
						layer.closeAll();
					},
					btn:[],
					time:2000,
					icon:2
				});
			}
			//成功登录
			function successLogin() {
				$('form').fadeOut(500);
				$('.wrapper').addClass('form-success');
				setTimeout(function(){
					window.location.href="${domain}/jsp/sys/master.jsp";
				},500);
						
			}

			//登录操作
			function loginIn() {
				$.ajax({
					url:'${domain}/users/adminlogin',
					type : "POST",
					data:JSON.stringify({
						username:$('#username').val(),
						password:$('#password').val()
					}),
					contentType : "application/json",
					success : function(res) {
						
						console.log(res);
						
						if(res.status=='success'){
							successLogin();
						}
						else{
							alertError(res.msg);
						}
					}
				})
			}
		});
	</script>

	<div
		style="text-align: center; margin: 50px 0; font: normal 14px/24px 'MicroSoft YaHei'; color: #000000">
		<h1>商城后台管理系统</h1>
	</div>
</body>
</html>