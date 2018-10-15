<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<div class="page_container">
			<div class="container">
				<div class="member_page normal_page">
					<div class="member_home">
						<div class="layouts">
							<div class="member_side_bar">
								<div class="tips">个人中心:</div>
								<div class="side_bar">
									<ul>
										<li class="menu on" data-index="1"><a href="javascript:;"
											class="per">我的账户</a></li>
										<li class="menu" data-index="2"><a href="javascript:;"
											class="per">我的订单</a></li>
										<li class="menu" data-index="3"><a href="javascript:;"
											class="per">积分明细</a></li>
										<li class="menu" data-index="4"><a href="javascript:;"
											class="per">修改密码</a></li>
										<li class="logout"><a href="javascript:;" class="per">注销</a></li>
									</ul>
								</div>
							</div>
							<div class="member_right_content">
								<div class="member_information clearfix content" data-index="1">
									<div class="left_part clearfix">
										<div class="member_icon">
											<div class="icon">
												<img src="${domain}/jsp/user/images/img_head_default_bg.png"
													width="70" id="preview" style="cursor: pointer;">
											</div>
											<!--<a class="modify gray_tips" href="">modify</a>-->
										</div>

										<!--<link rel="stylesheet" href="/Public/Home/layui/css/layui.css"  media="all">-->
										<script src="${domain}/jsp/user/js/layui.js"></script>
										<script>
											$(function() {
												var customid = '${custom.customid}';
												console.log(customid);

												if (customid == '') {
													window.location.href = "${domain}/jsp/mobile/login.jsp";
												}
											})
											layui
													.use(
															'upload',
															function() {
																layui
																		.upload({
																			url : "/majax/uploadpic?path=logo&thumbw=200&thumbh=200&is_member=ture",
																			elem : '#setpicture',
																			method : 'post',
																			ext : 'jpg|png|gif|jpeg',
																			unwrap : true,
																			success : function(
																					data,
																					input) {
																				if (data['Success']) {
																					$(
																							'#preview')
																							.attr(
																									'src',
																									''
																											+ data['SaveName']);
																					$(
																							'#picture')
																							.val(
																									data['SaveName']);
																				} else {
																					layer
																							.msg(
																									data['Message'],
																									{
																										icon : 5
																									});
																				}
																			}
																		});
															});

											$('body')
													.on(
															'click',
															'.logout',
															function() {
																$
																		.ajax({
																			url : "${domain}/custom/logout",
																			type : "POST",
																			contentType : "application/json",
																			success : function(
																					res) {
																				if (res.status == "success") {
																					window.location.href = "${domain}/jsp/mobile/login.jsp";
																				}
																			}
																		});
															})

											$
													.ajax({
														url : '${domain}/score/selectListByCid',
														type : 'post',
														contentType : 'application/json',
														data : JSON
																.stringify({
																	customid : '${custom.customid}'
																}),
														success : function(res) {
															console.log(res);
															var innerHtml = '<div class="member_th_title clearfix">'
																	+ '<div class="each each1">积分类目</div>'
																	+ '<div class="each each2">积分</div>'
																	+ '<div class="each each3">产生时间</div>'
																	+ '</div>';
															for ( var i in res) {
																var item = res[i];
																innerHtml += ('<div class="member_th_title clearfix">'
																		+ '<div class="each each1">'
																		+ (item.oid == null ? '后台操作'
																				: (item.pname
																						+ '*' + item.num))
																		+ '</div>'
																		+ '<div class="each each2">'
																		+ (item.type == '0' ? ('<font color="green">+'
																				+ item.score + '</font>')
																				: ('<font color="red">-'
																						+ item.score + '</font>'))
																		+ '</div>'
																		+ '<div class="each each3">'
																		+ (item.operatetime == null ? ''
																				: item.operatetime)
																		+ '</div>' + '</div>');
															}
															$('#scorelist')
																	.html(
																			innerHtml);

														}
													})

											$
													.ajax({
														url : '${domain}/order/selectListByCid',
														type : 'post',
														contentType : 'application/json',
														data : JSON
																.stringify({
																	customid : '${custom.customid}'
																}),
														success : function(res) {
															console.log(res);
															var innerHtml = '<div class="member_th_title clearfix">'
																	+ '<div class="each each1">订单详情</div>'
																	+ '<div class="each each2">订单状态</div>'
																	+ '<div class="each each3">下单时间</div>'
																	+ '<div class="each each4">发货时间</div>'
																	+ '</div>';
															for ( var i in res) {
																var item = res[i];
																innerHtml += ('<div class="member_th_title clearfix">'
																		+ '<div class="each each1">'
																		+ item.pname
																		+ '*'
																		+ item.num
																		+ '</div>'
																		+ '<div class="each each2">'
																		+ (item.status == '1' ? '已发货'
																				: '待发货')
																		+ '</div>'
																		+ '<div class="each each3">'
																		+ item.ordertime
																		+ '</div>'
																		+ '<div class="each each4">'
																		+ (item.deliverytime == null ? ''
																				: item.deliverytime)
																		+ '</div>' + '</div>');
															}
															$('#orderlist')
																	.html(
																			innerHtml);
														}
													})

											$('body')
													.on(
															'click',
															'.side_bar .menu',
															function() {
																$(
																		'.side_bar li')
																		.removeClass(
																				'on');
																$(this)
																		.addClass(
																				'on');
																var index = $(
																		this)
																		.attr(
																				'data-index');
																var contents = $('.member_right_content .content');
																$(
																		'.member_right_content .content')
																		.hide();
																for (var i = 0; i < contents.length; i++) {
																	if ($(
																			contents[i])
																			.attr(
																					'data-index') == index) {
																		$(
																				contents[i])
																				.show();
																	}
																}
															})

											$
													.ajax({
														url : '${domain}/custom/getCustombyid',
														type : 'post',
														contentType : 'application/json',
														data : JSON
																.stringify({
																	customid : '${custom.customid}'
																}),
														success : function(res) {
															$('#customname')
																	.html(
																			res.customname);
															$('#mobile').html(
																	res.mobile);
															$('#bankno').html(
																	res.bankno);
															$('#truename')
																	.html(
																			res.truename);
															$('#score').html(
																	res.score);
														}
													});
										</script>
										<div class="member_message">

											<div class="more_message clearfix">
												<div class="each_msg">
													<span class="c999">用户名:</span> <span class="c333"
														id="customname">${custom.customname}</span>
												</div>
												<div class="each_msg">
													<span class="c999">电话 : </span> <span class="c333"
														id="mobile">${custom.mobile}</span>
												</div>
												<div class="each_msg">
													<span class="c999">银行卡号: </span> <span class="c333"
														id="bankno">${custom.bankno}</span>
												</div>
												<div class="each_msg">
													<span class="c999">真实姓名: </span> <span class="c333"
														id="truename">${custom.truename}</span>
												</div>
											</div>
										</div>
									</div>
									<div class="right_part">
										<div class="each_one">
											<span class="c999">余额:</span> <span class="red" id="score">${custom.score}</span>
										</div>

									</div>
								</div>
								<div class="member_order_content content" data-index="2"
									style="display: none;">
									<h2 class="member_title">
										<span>所有订单</span>
									</h2>
									<div class="member_order_table" id="orderlist">
										<div class="member_th_title clearfix">
											<div class="each each1">订单详情</div>
											<div class="each each2">订单状态</div>
											<div class="each each3">下单时间</div>
											<div class="each each4">发货时间</div>
										</div>


									</div>

								</div>
								<div class="member_order_content content" data-index="3"
									style="display: none;">
									<h2 class="member_title">
										<span>积分明细</span>
									</h2>
									<div class="member_order_table" id="scorelist">
										<div class="member_th_title clearfix">
											<div class="each each1">积分类目</div>
											<div class="each each2">积分</div>
											<div class="each each3">产生时间</div>
										</div>
									</div>
								</div>
								<div class="member_order_content content" data-index="4"
									style="display: none;">
									<div class="login_page normal_page">
										<div class="page_normal_title_wrap">
											<h2 class="page_normal_title">修改密码</h2>
										</div>
										<div class="clearfix">
											<form id="Memberlogin" novalidate="novalidate">
												<div class="each_side login_wrap">

													<div class="login_form">
														<div class="label_input">
															<div class="label_wrap">
																<label>老密码</label>
															</div>
															<div class="input_wrap">
																<input name="oldpassword" id="oldpassword"
																	type="password" placeholder="老密码" class="input_text">
															</div>
														</div>
														<div class="label_input">
															<div class="label_wrap">
																<label>新密码</label>
															</div>
															<div class="input_wrap">
																<input name="newpassword" id="newpassword"
																	type="password" placeholder="新密码" class="input_text">
															</div>
														</div>
														<input name="customid" type="hidden" value="${custom.customid}"/>
														<div class="submit_wrap">
															<input type="submit" class="blackbtn" value="修改密码">
														</div>
													</div>
												</div>
											</form>
											<script src="${domain}/jsp/user/js/jquery.validate-1.13.1.js"></script>
											<script>
												var dfpaycard = 0;

												jQuery.validator
														.addMethod(
																"isMobile",
																function(value,
																		element) {
																	var length = value.length;
																	var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
																	return this
																			.optional(element)
																			|| (length == 11 && mobile
																					.test(value));
																}, "");

												jQuery.validator
														.addMethod(
																"isCard",
																function(value,
																		element) {
																	return this
																			.optional(element)
																			|| (checkCardNoLength(value) && luhnCheckSum(value));
																}, "");
												//ccv2
												jQuery.validator
														.addMethod(
																"isccv2",
																function(value,
																		element) {
																	return this
																			.optional(element)
																			|| (checkCvvLength(value) && checkCvvFormat(value));
																}, "");

												$()
														.ready(
																function() {
																	$(
																			'#Memberlogin')
																			.validate(
																					{
																						//debug: true,
																						rules : {
																							"oldpassword" : {
																								"required" : true,
																								"maxlength" : 20
																							},
																							"newpassword" : {
																								"required" : true,
																								"maxlength" : 20
																							}
																						},
																						messages : {
																							"oldpassword" : {
																								"required" : "请输入旧密码",
																								"maxlength" : "至多20个字符"
																							},
																							"newpassword" : {
																								"required" : "请输入新密码",
																								"maxlength" : "至多20个字符"
																							}
																						},
																						showErrors : function(
																								errorMap,
																								errorList) {
																							var msg = "";
																							$
																									.each(
																											errorList,
																											function(
																													i,
																													v) {
																												layer
																														.tips(
																																v.message,
																																v.element,
																																{
																																	time : 1000
																																});
																												return false;
																											});
																						},
																						onkeyup : false,
																						onfocusout : false,
																						submitHandler : function() {
																							$(
																									":submit")
																									.attr(
																											"disabled",
																											true);
																							layer
																									.load(1);
																							if (dfpaycard
																									&& typeof (dfpaycard) == "function") {
																								dfpaycard("${domain}/custom/customlogin");
																							} else {
																								$
																										.ajax({
																											type : "post",
																											url : "${domain}/custom/changePassword",
																											dataType : 'json',
																											contentType : 'application/json',
																											data : JSON
																													.stringify($(
																															'#Memberlogin')
																															.serializeObject()),
																											success : function(
																													data) {
																												console
																														.log(data)
																												if (data['status'] == 'success') {
																													layer
																															.msg(
																																	'修改成功',
																																	{
																																		icon : 6
																																	});
																													layer
																															.closeAll('loading');
																													
																												} else {
																													layer
																															.msg(
																																	data['msg'],
																																	{
																																		icon : 5
																																	});
																													layer
																															.closeAll('loading');
																													$(
																															":submit")
																															.removeAttr(
																																	"disabled");
																												}
																											}
																										});
																							}
																						}
																					});
																});
											</script>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--/Body-->

	<%@ include file="../common/footer_m.jsp"%>
	</div>
</body>
</html>