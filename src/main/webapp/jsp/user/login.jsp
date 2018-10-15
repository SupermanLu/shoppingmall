<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/headstyle.jsp"%>
<body>
	<%@ include file="../common/head.jsp"%>

	<!--Body-->
	<div class="all_body_container">

		<!--LOGIN~-->
		<div class="page_container">
			<div class="container">
				<div class="login_page normal_page">
					<div class="page_normal_title_wrap">
						<h2 class="page_normal_title">登陆已有账号</h2>
					</div>
					<div class="clearfix">
						<form id="Memberlogin" novalidate="novalidate">
							<div class="each_side login_wrap">

								<div class="login_form">
									<div class="label_input">
										<div class="label_wrap">
											<label>用户名</label>
										</div>
										<div class="input_wrap">
											<input name="customname" id="customname" type="text"
												placeholder="用户名 *" class="input_text">
										</div>
									</div>
									<div class="label_input">
										<div class="label_wrap">
											<label>密码</label>
										</div>
										<div class="input_wrap">
											<input name="password" type="password" placeholder="密码"
												class="input_text">
										</div>
									</div>

									<div class="submit_wrap">
										<input type="submit" class="blackbtn" value="Login">
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
														"customname" : {
															"required" : true,
															"maxlength" : 100
														},
														"password" : {
															"required" : true,
															"maxlength" : 20
														}
													},
													messages : {
														"username" : {
															"required" : "请输入用户名",
															"maxlength" : "至多100个字符"
														},
														"password" : {
															"required" : "请输入密码",
															"minlength" : "至少6个字符",
															"maxlength" : "至多20个字符"
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
															dfpaycard("${domain}/custom/customlogin");
														} else {
															$
																	.ajax({
																		type : "post",
																		url : "${domain}/custom/customlogin",
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
																								data['msg'],
																								{
																									icon : 6
																								});
																				layer
																				.closeAll('loading');
																				window.location.href = "${domain}/jsp/user/myinfo.jsp";
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

		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>