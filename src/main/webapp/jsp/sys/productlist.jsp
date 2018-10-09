<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>类别列表</title>
<%@ include file="../common/table.jsp"%>
<style>
.modal {
	z-index: 1000;
}
</style>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="add">
			<i class="glyphicon glyphicon-plus">添加商品</i>
		</button>
	</div>
	<!--
	<div class="form-group">
		 <label class="control-label">性别：</label> <label class="radio-inline">
			<input type="radio" name="sex" value="男" /> 男
		</label> <label class="radio-inline"> <input type="radio" name="sex"
			value="女" /> 女
		</label> 
	</div>
	-->
</div>

<input type="file" name="myfile" id="myfile" style="display: none;" />
<!-- 配置文件 -->
<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/ueditor.all.min.js"></script>

<script type="text/javascript" charset="utf-8"
	src="${domain}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
<script>
	//Demo
	var form;
	var isAdd = true;
	var dataid = '';
	var path = '';
	layui.use('form', function() {
		form = layui.form;

	});
	var ue;

	ue = UE.getEditor('edit', {
		initialFrameWidth : "100%", //初始化宽度
		initialFrameHeight : 400, //初始化高度
	});
	ue.ready(function() {
		ue.setContent('');
	});

	var $objectTable = getTable(
			$('#tableCommon'),
			[
					{
						align : 'center',
						title : '序号',
						field : '',
						formatter : function(value, row, index) {
							return index + 1;
						}
					},
					{
						field : 'pname',
						title : '商品名称'
					},
					{
						field : 'originalprice',
						title : '商品价格'
					},
					{
						field : 'stock',
						title : '商品库存'
					},
					{
						field : 'sales',
						title : '商品销量'
					},
					{
						field : 'updatetime',
						title : '更新时间'
					},
					{
						field : 'ordernum',
						title : '排序'
					},
					{
						align : 'center',
						field : 'productid',
						title : '上下架',
						formatter : function(value, row, index) {
							var res = '';
							if (row.issj == '1') {
								res = "<button class='btn btn-info item-xj' data-id='"
									+ value + "'> 下架 </button>";
							} else {
								res = "<button class='btn btn-info item-sj' data-id='"
									+ value + "'> 上架 </button>";
							}
							return res;
						}
					},
					{
						align : 'center',
						field : 'productid',
						title : '修改',
						formatter : function(value) {
							return "<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
						}
					},
					{
						align : 'center',
						field : 'productid',
						title : '删除',
						formatter : function(value) {
							return "<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/product/getProduct', {});

	initListener();

	function deleteUser(ids) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/note/deletecustombyids",
				type : "POST",
				contentType : "application/x-www-form-urlencoded",
				data : {
					ids : ids
				},
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		}

	}

	function deleteObject(id) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/product/deleteProductbyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					productid : id
				}),
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		}
	}

	function editCustom(url, data) {
		$.ajax({
			url : url,
			type : "POST",
			data : data,
			contentType : "application/json",
			success : function(res) {
				console.log(JSON.stringify(res));
				if (res.status == 'success') {
					alert((isAdd ? '新增' : '修改') + '成功');
					$('#myModal').modal('toggle');
					$tableObject.bootstrapTable('refresh');
				} else {
					alert(res.msg);
				}
			}
		});
	}
	
	function editCustom1(url, data) {
		$.ajax({
			url : url,
			type : "POST",
			data : data,
			contentType : "application/json",
			success : function(res) {
				console.log(JSON.stringify(res));
				if (res.status == 'success') {
					alert('修改成功');
					
					$tableObject.bootstrapTable('refresh');
				} else {
					alert(res.msg);
				}
			}
		});
	}

	function ajaxFileUpload() {
		$.ajaxFileUpload({
			url : '${domain}/product/upload',
			secureuri : false,
			cache : false,
			fileElementId : 'myfile',
			dataType : 'json',
			success : function(data, status) {

				console.log(data);
				$('#uploadImg').attr('src', '${domain}/' + data.msg);
				path = '${domain}/' + data.msg;
				$('#myfile').val('');
			},
			error : function(data, status, e) {

				console.log(JSON.stringify(e));
				alert(data.msg);
				$('#myfile').val('');

			}
		});
		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		})
	}

	function initListener() {
		$('#export').on('click', function() {
			$('#myfile').click();
		});

		$('body').on('click', '#uploadBtn', function() {
			console.log(1);
			$('#myfile').click();
		})

		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		});

		$('#delall').on('click', function() {
			$.ajax({
				url : "${domain}/category/deleteallcustom",
				type : "POST",
				data : {},
				success : function(data) {
					alert('删除成功');
					//重新加载记录
					//重新加载数据
					$objectTable.bootstrapTable('refresh');
				}
			});
		});

		$('#delsel').on('click', function() {
			//获取所有被选中的记录
			var rows = $objectTable.bootstrapTable('getSelections');
			if (rows.length == 0) {
				alert("请先选择要删除的记录!");
				return;
			}
			var ids = '';
			for (var i = 0; i < rows.length; i++) {
				ids += rows[i]['customid'] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			deleteUser(ids);
		});

		$('body')
				.on(
						'click',
						'#add',
						function() {
							$('#myModal').modal('toggle');
							$('#myModalLabel').html('新增');
							isAdd = true;
							$
									.ajax({
										url : "${domain}/category/selectOption",
										type : "POST",
										data : JSON.stringify({}),
										contentType : "application/json",
										success : function(res) {
											console.log(res);
											var innerHtml = '<option value=""></option>';
											for ( var i in res) {
												var item = res[i];
												console.log(item);
												var qz = '';
												if (item.level > 1) {
													qz = '|';
													for (var i = 0; i < (parseInt(item.level) - 1); i++) {
														qz += '-';
													}
												}
												innerHtml += '<option value="'+item.value+'">'
														+ qz
														+ item.text
														+ '</option>';
											}

											$('#productname').val('');
											$('#ordernum').val('');
											path='';
											$('#uploadImg').attr('src', '');
											$("input:radio[name='issj']").prop(
													'checked', 'false');
											$("input:radio[name='istj']").prop(
													'checked', 'false');
											$("input:radio[name='isjptj']")
													.prop('checked', 'false');
											$("input:radio[name='isrxjp']")
													.prop('checked', 'false');
											$("input:radio[name='isrm']").prop(
													'checked', 'false');
											$("input:radio[name='isxp']").prop(
													'checked', 'false');
											$("input:radio[name='isqg']").prop(
													'checked', 'false');
											$("input:radio[name='isdlsy']")
													.prop('checked', 'false');
											$("input:radio[name='istg']").prop(
													'checked', 'false');
											$('#parentcateid').val('');
											$('#originalprice').val('');
											$('#discountedprice').val('');
											$('#postage').val('');
											$('#stock').val('');

											ue.ready(function() {
												ue.setContent('');
											});

											$('#parentcateid').html(innerHtml);
											form.render();
										}
									});

							//$('input:radio[name=issy]')
							//		.prop('checked', 'false');
							//form.render();

						});

		$('body').on('click', '.item-sj', function() {
			dataid = $(this).attr('data-id');
			editCustom1('${domain}/product/updateProduct', JSON.stringify({
				productid : dataid,
				issj : '1'
			}));
		});
		
		$('body').on('click', '.item-xj', function() {
			dataid = $(this).attr('data-id');
			editCustom1('${domain}/product/updateProduct', JSON.stringify({
				productid : dataid,
				issj : '0'
			}));
		});

		$('body')
				.on(
						'click',
						'.item-edit',
						function() {
							dataid = $(this).attr('data-id');
							$('#myModal').modal('toggle');
							$('#myModalLabel').html('修改');
							isAdd = false;

							form.render('radio');

							$
									.ajax({
										url : "${domain}/category/selectOption",
										type : "POST",
										data : JSON.stringify({}),
										contentType : "application/json",
										success : function(res) {
											console.log(res);
											var innerHtml = '<option value=""></option>';
											for ( var i in res) {
												var item = res[i];
												console.log(item);
												var qz = '';
												if (item.level > 1) {
													qz = '|';
													for (var i = 0; i < (parseInt(item.level) - 1); i++) {
														qz += '-';
													}
												}
												innerHtml += '<option value="'+item.value+'">'
														+ qz
														+ item.text
														+ '</option>';
											}

											$('#parentcateid').html(innerHtml);
											$
													.ajax({
														url : '${domain}/product/getProductbyid',
														type : "POST",
														contentType : "application/json",
														data : JSON.stringify({
															productid : dataid
														}),
														success : function(data) {
															$('#productname')
																	.val(
																			data.pname);
															$('#ordernum')
																	.val(
																			data.ordernum);
															$('#uploadImg')
																	.attr(
																			'src',
																			data.logourl);
															$(
																	"input:radio[name='issj'][value='"
																			+ data.issj
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='istj'][value='"
																			+ data.istj
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isjptj'][value='"
																			+ data.isjptj
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isrxjp'][value='"
																			+ data.isrxjp
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isrm'][value='"
																			+ data.isrm
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isxp'][value='"
																			+ data.isxp
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isqg'][value='"
																			+ data.isqg
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='isdlsy'][value='"
																			+ data.isdlsy
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$(
																	"input:radio[name='istg'][value='"
																			+ data.istg
																			+ "']")
																	.prop(
																			'checked',
																			'true');
															$('#parentcateid')
																	.val(
																			data.cid);
															$('#originalprice')
																	.val(
																			data.originalprice);
															$(
																	'#discountedprice')
																	.val(
																			data.discountedprice);
															$('#postage')
																	.val(
																			data.postage);
															$('#stock').val(
																	data.stock);

															ue
																	.ready(function() {
																		ue
																				.setContent(unescape(data.descption));
																	});

															form.render();
														}
													});
										}
									});

						});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			if (isAdd) {
				editCustom('${domain}/product/addProduct', JSON.stringify({
					pname : $('#productname').val(),
					cid : $('#parentcateid').val(),
					ordernum : $('#ordernum').val(),
					issj : $("input[name='issj']:checked").val(),
					istj : $("input[name='istj']:checked").val(),
					isjptj : $("input[name='isjptj']:checked").val(),
					isrxjp : $("input[name='isrxjp']:checked").val(),
					isrm : $("input[name='isrm']:checked").val(),
					isxp : $("input[name='isxp']:checked").val(),
					isqg : $("input[name='isqg']:checked").val(),
					isdlsy : $("input[name='isdlsy']:checked").val(),
					istg : $("input[name='istg']:checked").val(),
					originalprice : $('#originalprice').val(),
					discountedprice : $('#discountedprice').val(),
					postage : $('#postage').val(),
					stock : $('#stock').val(),
					descption : escape(ue.getContent()),
					logourl : path
				}));
			} else {
				editCustom('${domain}/product/updateProduct', JSON.stringify({
					productid : dataid,
					pname : $('#productname').val(),
					cid : $('#parentcateid').val(),
					ordernum : $('#ordernum').val(),
					issj : $("input[name='issj']:checked").val(),
					istj : $("input[name='istj']:checked").val(),
					isjptj : $("input[name='isjptj']:checked").val(),
					isrxjp : $("input[name='isrxjp']:checked").val(),
					isrm : $("input[name='isrm']:checked").val(),
					isxp : $("input[name='isxp']:checked").val(),
					isqg : $("input[name='isqg']:checked").val(),
					isdlsy : $("input[name='isdlsy']:checked").val(),
					istg : $("input[name='istg']:checked").val(),
					originalprice : $('#originalprice').val(),
					discountedprice : $('#discountedprice').val(),
					postage : $('#postage').val(),
					stock : $('#stock').val(),
					descption : escape(ue.getContent()),
					logourl : path
				}));
			}
		})

	}
</script>


<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style='z-index: 9999;'>
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">修改</h4>
			</div>
			<div class="modal-body">
				<form class="layui-form" action="" method="post">
					<div class="layui-form-item">
						<label class="layui-form-label">商品名称:</label>
						<div class="layui-input-block">
							<input type="text" name="productname" id="productname"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品类别:</label>
						<div class="layui-input-block">
							<select name="parentcateid" lay-filter="parentcateid"
								id="parentcateid">
								<option value=""></option>
								<option value="0">写作</option>
								<option value="1" selected="">阅读</option>
								<option value="2">游戏</option>
								<option value="3">音乐</option>
								<option value="4">旅行</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否上架:</label>
						<div class="layui-input-block">
							<input type="radio" name="issj" value="1" title="是" checked>
							<input type="radio" name="issj" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否推荐:</label>
						<div class="layui-input-block">
							<input type="radio" name="istj" value="1" title="是" checked>
							<input type="radio" name="istj" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否精品推荐:</label>
						<div class="layui-input-block">
							<input type="radio" name="isjptj" value="1" title="是" checked>
							<input type="radio" name="isjptj" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否热销精品:</label>
						<div class="layui-input-block">
							<input type="radio" name="isrxjp" value="1" title="是" checked>
							<input type="radio" name="isrxjp" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否热卖:</label>
						<div class="layui-input-block">
							<input type="radio" name="isrm" value="1" title="是" checked>
							<input type="radio" name="isrm" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否新品:</label>
						<div class="layui-input-block">
							<input type="radio" name="isxp" value="1" title="是" checked>
							<input type="radio" name="isxp" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否抢购:</label>
						<div class="layui-input-block">
							<input type="radio" name="isqg" value="1" title="是" checked>
							<input type="radio" name="isqg" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否大类首页:</label>
						<div class="layui-input-block">
							<input type="radio" name="isdlsy" value="1" title="是" checked>
							<input type="radio" name="isdlsy" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否团购:</label>
						<div class="layui-input-block">
							<input type="radio" name="istg" value="1" title="是" checked>
							<input type="radio" name="istg" value="0" title="否">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">实际价格:</label>
						<div class="layui-input-block">
							<input type="text" name="originalprice" id="originalprice"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">折扣价格:</label>
						<div class="layui-input-block">
							<input type="text" name="discountedprice" id="discountedprice"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">邮费:</label>
						<div class="layui-input-block">
							<input type="text" name="postage" id="postage" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">库存:</label>
						<div class="layui-input-block">
							<input type="text" name="stock" id="stock" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品Logo:</label>
						<div class="layui-upload">
							<button type="button" class="layui-btn" id="uploadBtn">上传图片</button>
							<div class="layui-upload-list">
								<img class="layui-upload-img" id="uploadImg">
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品图片:</label>
						<div class="layui-upload">
							<button type="button" class="layui-btn" id="uploadBtn">上传图片</button>
							<div class="layui-upload-list" id="img-list">
								<img class="layui-upload-img" id="uploadImg">
							</div>
						</div>

					</div>


					<div class="layui-form-item">
						<label class="layui-form-label">排序:</label>
						<div class="layui-input-block">
							<input type="number" name="ordernum" id="ordernum"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品详情:</label>
						<div class="layui-input-block">
							<!-- 加载编辑器的容器 -->
							<script id="edit" name="content" type="text/plain"> 
   </script>


						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>


