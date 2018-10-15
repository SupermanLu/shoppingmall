<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle_m.jsp"%>
<body>
	<%@ include file="../common/head_m.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<!--LOGIN~-->
		<div class="page_container">
			<div class="container">
				<div class="login_page normal_page">
					<div class="page_normal_title_wrap">
						<h2 class="page_normal_title">留言专区</h2>
					</div>
					<div class="clearfix">
						<form id="Memberlogin" novalidate="novalidate">
							<div class="each_side login_wrap">

								<div class="login_form">
									<div class="label_input">
										<div class="label_wrap">
											<label>用户名:${custom.customname==null?'匿名用户':custom.customname}</label>
										</div>
									
									</div>
									<div class="label_input">
										<div class="label_wrap">
											<label>电子邮件地址</label>
										</div>
										<div class="input_wrap">
											<input name="email" type="text" placeholder="电子邮件"
												class="input_text">
										</div>
									</div>
									
									<div class="label_input">
										<div class="label_wrap">
											<label>留言类型</label>
										</div>
										<div>
											<input type="radio" name="bbstype" value="1" checked/>留言
											<input type="radio" name="bbstype" value="2"/>投诉
											<input type="radio" name="bbstype" value="3"/>询问
											<input type="radio" name="bbstype" value="4"/>售后
											<input type="radio" name="bbstype" value="5"/>求购
										</div>
									</div>
									
									<div class="label_input">
										<div class="label_wrap">
											<label>主题</label>
										</div>
										<div class="input_wrap">
											<input name="subject" type="text" placeholder="主题"
												class="input_text">
										</div>
									</div>
									
									<div class="label_input">
										<div class="label_wrap">
											<label>留言内容</label>
										</div>
										<div class="input_wrap">
											<textarea name="bbscontent" rows="5" placeholder="留言内容"
												class="input_text" style="width:100%;"></textarea>
										</div>
									</div>
									<input type="hidden" value="${custom.customid}" name="cid"/>

									<div class="submit_wrap">
										<input type="submit" class="blackbtn" value="我要留言">
									</div>
								</div>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
		<!--<script src="/Public/Common/layer/layer.js"></script>-->
		<script src="${domain}/jsp/user/js/jquery.validate-1.13.1.js"></script>
		<script>
			var dfpaycard = 0;

			jQuery.validator
					.addMethod(
							"isMobile",
							function(value, element) {
								var length = value.length;
								var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
								return this.optional(element)
										|| (length == 11 && mobile.test(value));
							}, "");

			jQuery.validator.addMethod("isCard", function(value, element) {
				return this.optional(element)
						|| (checkCardNoLength(value) && luhnCheckSum(value));
			}, "");
			//ccv2
			jQuery.validator.addMethod("isccv2", function(value, element) {
				return this.optional(element)
						|| (checkCvvLength(value) && checkCvvFormat(value));
			}, "");


			$()
					.ready(
							function() {
								$('#Memberlogin')
										.validate(
												{
													//debug: true,
													rules : {
														"subject" : {
															"required" : true,
															"maxlength" : 100
														},
														"bbstype" : {
															"required" : true
														},
														"bbscontent" : {
															"required" : true,
															"maxlength" : 500
														},
														"email" : {
															"required" : true
														}
													},
													messages : {
														"subject" : {
															"required" : "请输入主题",
															"maxlength" : "至多100个字符"
														},
														"bbstype" : {
															"required" : "请选择留言类型",
															"maxlength":"至多500个字符"
														},
														"bbscontent" : {
															"required" : "请输入留言内容"
														},
														"email" : {
															"required" : "请输入电子邮件"
														}
													},
													showErrors : function(
															errorMap, errorList) {
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
														$(":submit").attr(
																"disabled",
																true);
														layer.load(1);
														if (dfpaycard
																&& typeof (dfpaycard) == "function") {
															dfpaycard("${domain}/bbs/addBbs");
														} else {
															$
																	.ajax({
																		type : "post",
																		url : "${domain}/bbs/addBbs",
																		dataType : 'json',
																		contentType:'application/json',
																		data : JSON.stringify($('#Memberlogin')
																				.serializeObject()),
																		success : function(
																				data) {
																			console.log(data)
																			if (data['status']=='success') {
																				layer
																						.msg(
																								'留言成功',
																								{
																									icon : 6
																								});
																				layer
																				.closeAll('loading');
																				
																				window.location.href="${domain}/jsp/mobile/bbs.jsp?cateid=bbs"
																				
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
		<!--end LOGIN-->

		<!--/Body-->

		<%@ include file="../common/footer_m.jsp"%>
	</div>
</body>
</html>