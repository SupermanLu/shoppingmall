<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>菜单列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="add">
			<i class="glyphicon glyphicon-plus">新增菜单</i>
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

<script>
	//Demo
	var form;
	var isAdd = true;
	var dataid = '';
	var path='';
	layui.use('form', function() {
		form = layui.form;
		
		
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
						field : 'menuname',
						title : '菜单名称'
					},
					{
						field : 'menubs',
						title : '菜单标识'
					},
					{
						field : 'description',
						title : '菜单地址'
					},
					{
						field : 'parentmenuname',
						title : '父菜单名',
					},
					{
						field : 'ordernum',
						title : '排序'
					},
					{
						align : 'center',
						field : 'menuid',
						title : '修改',
						formatter : function(value) {
							return "<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
						}
					},
					{
						align : 'center',
						field : 'menuid',
						title : '删除',
						formatter : function(value) {
							return "<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/menu/getMenu', {});

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
				url : "${domain}/menu/deleteMenubyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					menuid : id
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

	function ajaxFileUpload() {
		$.ajaxFileUpload({
			url : '${domain}/category/upload',
			secureuri : false,
			cache : false,
			fileElementId : 'myfile',
			dataType : 'json',
			success : function(data, status) {

			console.log(data);
			$('#uploadImg').attr('src','${domain}/'+data.msg);
			path='${domain}/'+data.msg;
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
		
		$('body').on('click','#uploadBtn',function(){
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

		$('body').on('click', '#add', function() {
			$.ajax({
				url : "${domain}/menu/selectOption",
				type : "POST",
				data : JSON.stringify({}),
				contentType : "application/json",
				success : function(res) {
					console.log(res);
					var innerHtml='<option value=""></option>';
					for(var i in res){
						var item=res[i];
						console.log(item);
						var qz='';
						if(item.level>1){
							qz='|';
							for(var i=0;i<(parseInt(item.level)-1);i++){
								qz+='-';
							}
						}
						innerHtml+='<option value="'+item.value+'">'+qz+item.text+'</option>';
					}
					
					$('#parentmenuid').html(innerHtml);
					form.render();
				}
			});
			
			$('#myModal').modal('toggle');
			$('#myModalLabel').html('新增');
			isAdd = true;

			$('#menuname').val('');
			$('#menubs').val('');
			$('#description').val('');
			
			$('#parentmenuid').val('');
			$('#ordernum').val('');
			form.render();

		});

		$('body').on(
				'click',
				'.item-edit',
				function() {
					$.ajax({
						url : "${domain}/menu/selectOption",
						type : "POST",
						data : JSON.stringify({}),
						contentType : "application/json",
						success : function(res) {
							console.log(res);
							var innerHtml='<option value=""></option>';
							for(var i in res){
								var item=res[i];
								console.log(item);
								var qz='';
								if(item.level>1){
									qz='|';
									for(var i=0;i<(parseInt(item.level)-1);i++){
										qz+='-';
									}
								}
								innerHtml+='<option value="'+item.value+'">'+qz+item.text+'</option>';
							}
							
							$('#parentmenuid').html(innerHtml);
							form.render();
						}
					});
					
					dataid = $(this).attr('data-id');
					$('#myModal').modal('toggle');
					$('#myModalLabel').html('修改');
					isAdd = false;

					$('input:radio[name=issy]').prop('checked', 'false');
					form.render('radio');

					$.ajax({
						url : '${domain}/menu/getMenubyid',
						type : "POST",
						contentType : "application/json",
						data : JSON.stringify({
							menuid : dataid
						}),
						success : function(data) {
							$('#menuname').val(data.menuname);
							$('#ordernum').val(data.ordernum);
							$('#menubs').val(data.menubs);
							$('#description').val(data.description);
							$('#parentmenuid').val(data.parentmenuid);
							form.render();
						}
					})

				});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			if (isAdd) {
				editCustom('${domain}/menu/addMenu', JSON.stringify({
					menuname : $('#menuname').val(),
					menubs : $('#menubs').val(),
					description : $('#description').val(),
					ordernum:$('#ordernum').val(),
					parentmenuid : $('#parentmenuid').val()
				}));
			} else {
				editCustom('${domain}/menu/updateMenu', JSON.stringify({
					menuid : dataid,
					menuname : $('#menuname').val(),
					menubs : $('#menubs').val(),
					description : $('#description').val(),
					ordernum:$('#ordernum').val(),
					parentmenuid : $('#parentmenuid').val()
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
						<label class="layui-form-label">菜单名:</label>
						<div class="layui-input-block">
							<input type="text" name="menuname" id="menuname"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">菜单标识:</label>
						<div class="layui-input-block">
							<input type="text" name="menubs" id="menubs"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">菜单地址:</label>
						<div class="layui-input-block">
							<input type="text" name="description" id="description"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">上级菜单:</label>
						<div class="layui-input-block">
							<select name="parentmenuid" lay-filter="parentmenuid" id="parentmenuid">
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
						<label class="layui-form-label">排序:</label>
						<div class="layui-input-block">
							<input type="number" name="ordernum" id="ordernum"
								autocomplete="off" class="layui-input">
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