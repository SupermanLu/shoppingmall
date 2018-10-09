
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Header-->
<div class="header">
	<div class="logo">
		<a href="${domain}/jsp/user/index.jsp"> <img
			src="${domain}/jsp/user/images/58cb41153eb32.png" width="205">
		</a>
	</div>

	<div class="nav_wrap">
		<div style="width: 1100px;" class="layouts">
			<div class="nav">
				<ul class="clearfix" id="menu">
					<li class="on"><a href="/" class="per">首页<span
							class="line"><i></i></span></a></li>
					<li class=""><a href="https://www.wellymerck.com/watch/men"
						class="per">MEN<span class="line"><i></i></span></a></li>
					<li class=""><a href="https://www.wellymerck.com/watch/women"
						class="per">WOMEN<span class="line"><i></i></span></a></li>
					<li class=""><a href="https://www.wellymerck.com/accessories"
						class="per">ACCESSORIES<span class="line"><i></i></span></a></li>
					<li class=""><a
						href="https://www.wellymerck.com/Customization" class="per">CUSTOMIZATION<span
							class="line"><i></i></span></a></li>
					<li class=""><a href="https://www.wellymerck.com/about-us"
						class="per">ABOUT US<span class="line"><i></i></span></a></li>
				</ul>
			</div>
			<div class="header_member">
				<span class="mem_btn"><em class="person"></em><i class="down"></i></span>
				<div class="down_list">
					<ul id="login">
						<li><a href="${domain}/jsp/user/login.jsp" class="each">登录</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="cart_btn">
				<a href="javascript:;" class="go_cart" id="hcart"></a>
			</div>
		</div>
	</div>
</div>

<script>
	var customid = '${custom.customid}';
	console.log(customid);

	if (customid != '') {
		$('#login')
				.html(
						'<li><a id="logout" href="javascript:;" class="each">注销</a></li><li><a href="${domain}/jsp/user/myinfo.jsp" class="each">账户信息</a></li>')
	} else {
		$('#login')
				.html(
						' <li><a href="${domain}/jsp/user/login.jsp" class="each">登录</a></li>')
	}

	$('body').on('click', '#logout', logout);

	$('body').on('click', '#hcart', function() {
		if (customid != '') {
			window.location.href = "${domain}/jsp/user/cart.jsp";
		} else {
			window.location.href = "${domain}/jsp/user/login.jsp";
		}
	});

	function logout() {
		$.ajax({
			url : "${domain}/custom/logout",
			type : "POST",
			contentType : "application/json",
			success : function(res) {
				if (res.status == "success") {
					window.location.href = "${domain}/jsp/user/login.jsp";
				}
			}
		});
	}

	$
			.ajax({
				url : '${domain}/category/getcategorybypid',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify({
					parentcateid : ''
				}),
				success : function(res) {
					var cateid = GetQueryString('cateid');
					var cls = '';
					if (cateid == null) {
						cls = 'on';
					}
					var innerHtml = '<li class="'+cls+'"><a href="${domain}/jsp/user/index.jsp" class="per">首页<span class="line"><i></i></span></a></li>';
					for ( var i in res) {
						var item = res[i];
						var itemCls = '';
						if (cateid == item.cateid) {
							itemCls = 'on';
						}
						innerHtml += '<li class="'+itemCls+'"><a href="'
								+ '${domain}/jsp/user/product.jsp?cateid='
								+ item.cateid + '" class="per">'
								+ item.catename
								+ '<span class="line"><i></i></span></a></li>';
					}

					$('#menu').html(innerHtml);
				}
			});

	$(".header_member .mem_btn").click(function() {
		$(this).next().slideToggle();
	})
	$(".header .show_wrap").click(function() {
		$(this).next().slideToggle();
	})
	/**
	 * 自动将form表单封装成json对象
	 */
	$.fn.serializeObject = function() {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
			if (o[this.name]) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};

	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);//search,查询？后面的参数，并匹配正则    
		if (r != null)
			return unescape(r[2]);
		return null;
	}
	
	
	function refreshCart(){
		$.ajax({
			url : "${domain}/cart/getCart",
			type : "POST",
			contentType : "application/json",
			data:JSON.stringify({
				cid:'${custom.customid}'
			}),
			success : function(res) {
				if(parseInt(res.total)>0){
					$('#hcart').html('<i class="num" id="hcartnumber">'+res.total+'</i>');
				}
			}
		});
	}
	
	refreshCart();
	
	function addCart(pid){
		var customid = '${custom.customid}';
		console.log(customid);

		if (customid != '') {
			$.ajax({
				url : "${domain}/cart/addCart",
				type : "POST",
				contentType : "application/json",
				data:JSON.stringify({
					pid:pid,
					cid:'${custom.customid}',
					num:1
				}),
				success : function(res) {
					refreshCart();
				}
			});
		} else {
			window.location.href = "${domain}/jsp/user/login.jsp";
		}
		
	}
	
	
</script>

<!--/Header-->