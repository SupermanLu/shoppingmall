<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<div class="page_container">
			<div class="container">
				<div class="about_us_page normal_page">
					<div class="page_normal_title_wrap">
						<h2 class="page_normal_title" id="title"></h2>
						<p class="normal_tips"></p>
					</div>

					<div class="layouts" id="content"></div>
				</div>
			</div>
		</div>
		<style type="text/css">
div.shop {
	z-index: 100;
	width: 450px;
	height: 320px;
	position: absolute;
	top: 0
}

div.tmDiv {
	filter: alpha(opacity = 30);
	-moz-opacity: 0.30;
	opacity: 0.30;
	background: #000000;
}
</style>
		<script type="text/javascript">
			$(document).ready(function() {
				$(".dwDiv").mouseover(function() {
					/*  $(this).addClass("tmDiv");*/
					$(this).parent().find(".showNow").addClass("tmDiv");
					$(this).parent().find("span").css("top", "260px");
					/* $(this).find("div").css("margin-bottom","60px");*/
				});
				$(".dwDiv").mouseout(function() {
					/*$(this).removeClass("tmDiv");*/
					$(this).parent().find(".showNow").removeClass("tmDiv");
					$(this).parent().find("span").css("top", "200px");
					/* $(this).parent().find(".dwDiv").css("margin-bottom","0px");*/
					/*  $(this).find("div").css("margin-bottom","0px");*/
				});
			});
			
			$.ajax({
				url : '${domain}/rule/getRule',
				type : 'post',
				contentType : 'application/json',
				success : function(res) {
					console.log(res);
					
					$('#title').html('积分规则');
					$('#content').html(unescape(res.rulecontent));
				}
			})
		</script>
		
		

		<!--/Body-->

		<%@ include file="../common/footer_m.jsp"%>
	</div>
</body>
</html>