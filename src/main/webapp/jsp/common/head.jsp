
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#menu {
	display: -webkit-box;
	overflow-x: scroll;
	-webkit-overflow-scrolling: touch;
}
/*去掉滚动条*/
#menu::-webkit-scrollbar {
	width: 0;
	height: 0;
	display: none;
}

.nav {
	width: calc(100% - 225px);
}

.nav_wrap{
	height: 50px;
}

.subper{
	position: relative;
    display: block;
    margin: 8px 35px 5px;
    padding: 8px 0 5px;
    font-family: 'regular';
    font-size: 16px;
    color: #ccc;
    text-transform: uppercase;
    transition: all .3s;
    -moz-transition: all .3s;
    -webkit-transition: all .3s;
}

.nav .sub-nav-item:hover .subper {
    color:#fff;
    border-color:#fff
}
.nav .subper .line {
    position:absolute;
    bottom:14px;
    left:0;
    width:100%;
    height:1px;
    text-align:center
}
.nav .subper .line i {
    display:inline-block;
    width:0;
    height:1px;
    line-height:1px;
    background-color:#fff;
    transition:all .3s;
    -moz-transition:all .3s;
    -webkit-transition:all .3s
}
.nav .sub-nav-item:hover .subper i{
    width:100%
}

#dhzx{
width:137.2px;
}

#dhzx ul{
	overflow:hidden;
	width:600px;
}

#dhzx ul li{
	float:left;
	width:200px;
	height:50px;
}


</style>
<!--Header-->
<div class="header">
	<div class="logo">
		<a href="${domain}/jsp/user/index.jsp"> <img
			src="${domain}/jsp/user/images/58cb41153eb32.png" width="205">
		</a>
	</div>

	<div class="nav_wrap">
		<div style="width: 1200px;" class="layouts">
			<div class="nav">
				<div id="left"></div>
				<ul class="clearfix" id="menu">

				</ul>
			</div>
			<div class="cart_btn">
				<a href="http://www.baidu.com" target="_blank" class="qq"></a>
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
	(function browserRedirect() {
		var sUserAgent = navigator.userAgent.toLowerCase();
		var bIsIpad = sUserAgent.match(/ipad/i) == 'ipad';
		var bIsIphone = sUserAgent.match(/iphone os/i) == 'iphone os';
		var bIsMidp = sUserAgent.match(/midp/i) == 'midp';
		var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == 'rv:1.2.3.4';
		var bIsUc = sUserAgent.match(/ucweb/i) == 'web';
		var bIsCE = sUserAgent.match(/windows ce/i) == 'windows ce';
		var bIsWM = sUserAgent.match(/windows mobile/i) == 'windows mobile';
		var bIsAndroid = sUserAgent.match(/android/i) == 'android';

		if (bIsIpad || bIsIphone || bIsMidp || bIsUc7 || bIsUc || bIsCE
				|| bIsWM || bIsAndroid) {
			window.location.href = '${domain}/jsp/mobile/index.jsp';
		}
	})();

	//使移动端a:active伪类生效
	document.body.addEventListener('touchstart', function() {
	}, false);
	$(document).ready(function() {
		$(".top_fixed_wrap .close").click(function() {
			$(this).parents(".top_fixed_wrap").slideUp();
		});
	});

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
					var scoredetailCls = '';
					var bbsCls = '';
					var dhzxCls='';
					switch (cateid) {
						case null:
							cls = 'on';
							break;
						case 'scoredetail':
							scoredetailCls = 'on';
							break;
						case 'bbs':
							bbsCls = 'on';
							break;
						default:
							dhzxCls='on';
							break;
					}
					var innerHtml = '<li class="nav-item '+cls+'"><a href="${domain}/jsp/user/index.jsp" class="per">首页<span class="line"><i></i></span></a></li>';
					innerHtml += '<li class="nav-item '+dhzxCls+'"  id="dhzx"><a href="javascript:;" class="per">兑换中心<span class="line"><i></i></span></a><ul id="subdhzx" style="background-color:#2e2e30;display:none;">';
					for ( var i in res) {
						var item = res[i];
						var itemCls = '';
						if (cateid == item.cateid) {
							itemCls = 'on';
						}
						innerHtml += '<li class="sub-nav-item"><a href="'
								+ '${domain}/jsp/user/product.jsp?cateid='
								+ item.cateid + '" class="subper">'
								+ item.catename
								+ '<span class="line"><i></i></span></a></li>';
					}
					innerHtml +='</ul></li>'
					innerHtml += '<li class="nav-item '+scoredetailCls+'"><a href="${domain}/jsp/user/scoredetail.jsp?cateid=scoredetail" class="per">积分规则<span class="line"><i></i></span></a></li>';
					innerHtml += '<li class="nav-item '+bbsCls+'"><a href="${domain}/jsp/user/bbs.jsp?cateid=bbs" class="per">留言专区<span class="line"><i></i></span></a></li>';
					innerHtml += '<li class="nav-item"><a href="http://www.baidu.com" class="per" target="_blank">官网首页<span class="line"><i></i></span></a></li>';
					innerHtml += '<li class="nav-item"><a href="http://www.baidu.com" class="per" target="_blank">联系我们<span class="line"><i></i></span></a></li>';
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

	function refreshCart() {
		$.ajax({
			url : "${domain}/cart/getCart",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
				cid : '${custom.customid}'
			}),
			success : function(res) {
				if (parseInt(res.total) > 0) {
					$('#hcart').html(
							'<i class="num" id="hcartnumber">' + res.total
									+ '</i>');
				}
			}
		});
	}

	refreshCart();

	function addCart(pid) {
		var customid = '${custom.customid}';
		console.log(customid);

		if (customid != '') {
			$.ajax({
				url : "${domain}/cart/addCart",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					pid : pid,
					cid : '${custom.customid}',
					num : 1
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

<script type="text/javascript">
	var flag = false;
	var menu = $('#menu');
	var cur = {
		x : 0,
		y : 0
	}
	var nx, ny, dx, dy, x, y;
	function down() {
		flag = true;
		var touch;
		if (event.touches) {
			touch = event.touches[0];
		} else {
			touch = event;
		}
		cur.x = touch.clientX;
		dx = menu.scrollLeft();
	}
	function move() {
		if (flag) {
			var touch;
			if (event.touches) {
				touch = event.touches[0];
			} else {
				touch = event;
			}
			nx = touch.clientX - cur.x;
			x = menu.scrollLeft(dx - nx);
		}
	}
	//鼠标释放时候的函数
	function end() {
		flag = false;
	}

	menu.on("mousedown", function() {
		down();
	});
	menu.on("touchstart", function() {
		down();
	})
	menu.on("mousemove", function() {
		move();
	});
	menu.on("touchmove", function() {
		move();
	})
	$('body').on("mouseup", function() {
		end();
	});
	$('body').on("touchend", function() {
		end();
	});
	
	$('body').on('mouseover','#dhzx',function(){
		console.log(1);
		$('#subdhzx').show();
	})
	
	$('body').on('mouseout','#dhzx',function(){
		$('#subdhzx').hide();
	})
</script>

<!--/Header-->