<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle.jsp"%>
<body>
	<%@ include file="../common/head.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<div class="page_container">
			<div class="container">
				<div class="member_page normal_page">
					<div class="member_home">
						<div class="layouts">
							
							<div class="member_right_content">
								<div class="member_information clearfix">
									<div class="left_part clearfix">
										<div class="member_icon">
											<div class="icon">
												<img src="${domain}/jsp/user/images/img_head_default_bg.png" width="70" id="preview"
													style="cursor: pointer;">
											</div>
											<!--<a class="modify gray_tips" href="">modify</a>-->
										</div>
										<input type="hidden" name="picture" id="picture" value="">
										<form target="layui-upload-iframe" method="post"
											key="set-mine" enctype="multipart/form-data"
											action="https://www.wellymerck.com/majax/uploadpic?path=logo&amp;thumbw=200&amp;thumbh=200&amp;is_member=ture">
											<input type="file" class="file" name="setpicture"
												id="setpicture" style="display: none">
										</form>
										<style>
#layui-upload-iframe {
	display: none;
}
</style>
										<!--<link rel="stylesheet" href="/Public/Home/layui/css/layui.css"  media="all">-->
										<script src="${domain}/jsp/user/js/layui.js"></script>
										<script>
    layui.use('upload', function(){
        layui.upload({
            url: "/majax/uploadpic?path=logo&thumbw=200&thumbh=200&is_member=ture"
            ,elem: '#setpicture'
            ,method: 'post'
            ,ext: 'jpg|png|gif|jpeg'
            ,unwrap: true
            ,success: function(data, input){
                if(data['Success']){
                    $('#preview').attr('src',''+data['SaveName']);
                    $('#picture').val(data['SaveName']);
                }else{
                    layer.msg(data['Message'], {icon: 5});
                }
            }
        });
    });
</script>
										<div class="member_message">
										
											<div class="more_message clearfix">
												<div class="each_msg">
													<span class="c999">用户名:</span> <span class="c333">${custom.customname}</span>
												</div>
												<div class="each_msg">
													<span class="c999">电话 : </span> <span class="c333">${custom.mobile}</span>
												</div>
												<div class="each_msg">
													<span class="c999">银行卡号: </span> <span class="c333">${custom.bankno}</span>
												</div>
												<div class="each_msg">
													<span class="c999">真实姓名: </span> <span class="c333">${custom.truename}</span>
												</div>
											</div>
										</div>
									</div>
									<div class="right_part">
										<div class="each_one">
											<span class="c999">余额:</span> <span
												class="red">${custom.score}</span>
										</div>
										
									</div>
								</div>
								<!-- <div class="member_order_content">
									<h2 class="member_title">
										<span>所有订单</span>
										<a
											href="https://www.wellymerck.com/member/myorder"
											class="fr c999">more&gt;&gt;</a>
									</h2>
									<div class="member_order_table">
										<div class="member_th_title clearfix">
											<div class="each each1">订单详情</div>
											<div class="each each2">订单总额</div>
											<div class="each each2">订单状态</div>
											<div class="each each2">订单操作</div>
										</div>
									</div> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--/Body-->

		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>