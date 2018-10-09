<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>商城后台管理系统</title>
<%@ include file="../common/style.jsp"%>
<script type="text/javascript" src="${domain}/js/index.js"></script>
</head>
<body>
	<div class="layui-layout layui-layout-admin" id="layui_layout">
		<!-- 顶部区域 -->
		<div class="layui-header header header-demo">
			<div class="layui-main">
				<!-- logo区域 -->
				<div class="admin-logo-box">
					<a class="logo" href="/" title="logo">商城后台管理系统</a>
					<div class="larry-side-menu">
						<i class="fa fa-bars" aria-hidden="true"></i>
					</div>
				</div>

				<!-- 右侧导航 -->
				<ul class="layui-nav larry-header-item">
					<li class="layui-nav-item" id="username">用户名：${account.username}</li>

					<li class="layui-nav-item" id="loginout"><a
						href="javascript:;"> <i class="iconfont icon-exit"></i> 退出
					</a></li>
				</ul>
			</div>
		</div>
		<!-- 左侧侧边导航开始 -->
		<div class="layui-side layui-side-bg layui-larry-side" id="larry-side">
			<div class="layui-side-scroll" id="larry-nav-side" lay-filter="side">

				<!-- 左侧菜单 -->
				<ul class="layui-nav layui-nav-tree" id="left-menu">
					<li class="layui-nav-item layui-this"><a href="javascript:;"
						data-url="main.jsp"> <i class="iconfont icon-home1"
							data-icon='icon-home1'></i> <span>管理中心</span>
					</a></li>

					<!-- 系统管理 -->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli2"></i> <span>系统管理</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="menulist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>菜单管理</span>
								</a>
							</dd>
							<dd>
								<a href="javascript:;" data-url="tenderkaibiao.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>后台用户管理</span>
								</a>
							</dd>
							<dd>
								<a href="javascript:;" data-url="tenderkaibiao.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>角色管理</span>
								</a>
							</dd>
							<!-- <dd>
								<a href="javascript:;" data-url="tenderlist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>系统参数设置</span>
								</a>
							</dd> -->


						</dl></li>

					<!-- 商品管理 -->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli2"></i> <span>商品管理</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="categorylist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>商品分类管理</span>
								</a>
							</dd>
							<dd>
								<a href="javascript:;" data-url="tenderkaibiao.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>商品管理</span>
								</a>
							</dd>
							<dd>
								<a href="javascript:;" data-url="tenderkaibiao.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>用户商品评论列表</span>
								</a>
							</dd>


						</dl></li>

					<!-- 订单管理 -->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli" data-icon="icon-jiaoseguanli"></i>
							<span>订单管理</span>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="tendershenhe.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>商品订单管理</span>
								</a>
							</dd>



						</dl></li>
					<!-- 地区管理 -->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>地区管理</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="locationlist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>地区管理</span>
								</a>
							</dd>

						</dl></li>


					<!-- 首页轮播图-->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>首页轮播图</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="swiplist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>轮播图列表</span>
								</a>
							</dd>

						</dl></li>

					<!-- 帮助中心-->
					<!-- <li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>帮助中心</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="providerlist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>帮助列表</span>
								</a>
							</dd>

						</dl></li> -->

					<!-- 网站快报-->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>网站快报</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="notelist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>快报列表</span>
								</a>
							</dd>

						</dl></li>


					<!-- 友情链接管理-->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>友情链接管理</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="friendlinklist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>友情链接列表</span>
								</a>
							</dd>

						</dl></li>



					<!-- 会员管理-->
					<li class="layui-nav-item"><a href="javascript:;"> <i
							class="iconfont icon-jiaoseguanli"></i> <span>会员管理</span> <em
							class="layui-nav-more"></em>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="customlist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>会员列表</span>
								</a>
							</dd>
							<dd>
								<a href="javascript:;" data-url="scorelist.jsp"> <i
									class="iconfont icon-m-members" data-icon='icon-geren1'></i> <span>会员积分列表</span>
								</a>
							</dd>

						</dl></li>

				</ul>
			</div>
		</div>

		<!-- 左侧侧边导航结束 -->
		<!-- 右侧主体内容 -->
		<div class="layui-body" id="larry-body"
			style="bottom: 0; border-left: solid 2px #2299ee;">
			<div class="layui-tab layui-tab-card larry-tab-box" id="larry-tab"
				lay-filter="demo" lay-allowclose="true">
				<div class="go-left key-press pressKey" id="titleLeft"
					title="滚动至最右侧">
					<i class="larry-icon larry-weibiaoti6-copy"></i>
				</div>
				<ul class="layui-tab-title">
					<li class="layui-this" id="admin-home"><i
						class="iconfont icon-diannao1"></i><em>管理中心</em></li>
				</ul>
				<div class="go-right key-press pressKey" id="titleRight"
					title="滚动至最左侧">
					<i class="larry-icon larry-right"></i>
				</div>

				<div class="layui-tab-content" style="min-height: 150px;">
					<div class="layui-tab-item layui-show">
						<iframe class="larry-iframe" data-id='0' src="main.jsp"></iframe>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script>
	var element;
	layui.define(['element'], function(exports){
		    element = layui.element();
			$.ajax({
				url : "${domain}/menu/selectOptionList",
				type : "POST",
				data : JSON.stringify({
					roleid : '${account.roleid}'
					//roleid:'c1da0cc6-f6af-419e-905c-738169ca0a99'
				}),
				contentType : "application/json",
				success : function(res) {

					console.log(res);
					var innerHtml = '<li class="layui-nav-item layui-this">'
							+ '<a href="javascript:;" data-url="main.jsp">'
							+ '<i class="iconfont icon-home1" data-icon="icon-home1"></i>'
							+ '<span>管理中心</span>' + '</a></li>';
					for ( var i in res) {
						var item = res[i];
						console.log(item);
						innerHtml += '<li class="layui-nav-item">'
								+ '<a href="javascript:;"> <i class="iconfont icon-jiaoseguanli2"></i> <span>'
								+ item.text + '</span>'
								+ '<em class="layui-nav-more"></em></a>'
								+ '<dl class="layui-nav-child">';
						for ( var j in item.list) {
							var subItem = item.list[j];
							innerHtml += '<dd>'
									+ '<a href="javascript:;" data-url="'+subItem.url+'">'
									+ '<i class="iconfont icon-m-members" data-icon="icon-geren1"></i> <span>'
									+ subItem.text + '</span>' + '</a>'
									+ '</dd>'
						}

						innerHtml += '</dl></li>';
					}

					$('#left-menu').html(innerHtml);
					
					element.init();

				}

			});
		 
		});
		
	</script>
</body>
</html>



