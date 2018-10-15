<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>类别列表</title>
<head>
<script type="text/javascript" src="${domain}/js/jquery-2.1.1.min.js"></script>

<script type="text/javascript" src="${domain}/js/bootstrap.min.js"></script>

<!-- Bootstrap Core CSS -->
<link href="${domain}/css/bootstrap.css" rel='stylesheet'
	type='text/css' />


<!-- 配置文件 -->
<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/ueditor.all.min.js"></script>

<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<!-- 加载编辑器的容器 -->
	<script id="edit" name="content" type="text/plain"> </script>
	<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	<script>
		var ue;

		var ruleid = '';

		ue = UE.getEditor('edit', {
			initialFrameWidth : "100%", //初始化宽度
			initialFrameHeight : 800, //初始化高度
		});
		ue.ready(function() {
			$.ajax({
				url : "${domain}/rule/getRule",
				type : "POST",
				contentType : "application/json",
				success : function(data) {
					if (data.ruleid == null) {
						ue.setContent('');
					} else {
						ruleid = data.ruleid;
						ue.setContent(unescape(data.rulecontent));
					}
				}
			});

		});

		

		$('#submitBtn').click(function() {
			if (ruleid == '') {
				$.ajax({
					url : "${domain}/rule/addRule",
					type : "POST",
					contentType : "application/json",
					data : JSON.stringify({
						rulecontent : escape(ue.getContent())
					}),
					success : function(data) {
						if (data.status == 'success') {
							alert('修改成功');
						} else {
							alert(data.msg);
						}
					}
				});
			} else {
				$.ajax({
					url : "${domain}/rule/updateRule",
					type : "POST",
					contentType : "application/json",
					data : JSON.stringify({
						ruleid : ruleid,
						rulecontent : escape(ue.getContent())
					}),
					success : function(data) {
						if (data.status == 'success') {
							alert('修改成功');
						} else {
							alert(data.msg);
						}
					}
				});
			}

		});
	</script>
</body>

