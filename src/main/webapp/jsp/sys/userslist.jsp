<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>类别列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="add">
			<i class="glyphicon glyphicon-plus">新增类别</i>
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
						field : 'username',
						title : '用户名'
					},
					{
						field : 'rolename',
						title : '角色名'
					},
					{
						field : 'status',
						title : '状态',
						formatter : function(value) {
							return value == '1' ? '有效' : '无效';
						}

					},
					{
						align : 'center',
						field : 'userid',
						title : '修改',
						formatter : function(value) {
							return value=='45f0c5f9-cad2-49e6-887d-b38dfcbc23de'?'':"<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
						}
					},
					{
						align : 'center',
						field : 'userid',
						title : '删除',
						formatter : function(value) {
							return  value=='45f0c5f9-cad2-49e6-887d-b38dfcbc23de'?'':"<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/users/getUsers', {});

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
				url : "${domain}/users/deleteUsersbyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					userid : id
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
			
			$('#myModal').modal('toggle');
			$('#myModalLabel').html('新增');
			isAdd = true;

			$('#username').val('');
			$('#password').val('');

			
			
			$.ajax({
				url : "${domain}/role/getRoleOption",
				type : "POST",
				data : JSON.stringify({}),
				contentType : "application/json",
				success : function(res) {
					console.log(res);
					var innerHtml='<option value=""></option>';
					for(var i in res){
						var item=res[i];
						
						innerHtml+='<option value="'+item.roleid+'">'+item.rolename+'</option>';
					}
					
					$('#roleid').html(innerHtml);
					$('input:radio[name=status]').prop('checked', 'false');
					form.render();
				}
			});
			
			

		});

		$('body').on(
				'click',
				'.item-edit',
				function() {
					dataid = $(this).attr('data-id');
					$('#myModal').modal('toggle');
					$('#myModalLabel').html('修改');
					isAdd = false;

					$('input:radio[name=status]').prop('checked', 'false');
					form.render('radio');

					$.ajax({
						url : "${domain}/role/getRoleOption",
						type : "POST",
						data : JSON.stringify({}),
						contentType : "application/json",
						success : function(res) {
							console.log(res);
							var innerHtml='<option value=""></option>';
							for(var i in res){
								var item=res[i];
						
								innerHtml+='<option value="'+item.roleid+'">'+item.rolename+'</option>';
							}
							
							$('#roleid').html(innerHtml);
							form.render();
							
							$.ajax({
								url : '${domain}/users/getUsersbyid',
								type : "POST",
								contentType : "application/json",
								data : JSON.stringify({
									userid : dataid
								}),
								success : function(data) {
									$('#username').val(data.username);
									$('#password').val('');
									
									$(
											"input:radio[name='status'][value='"
													+ data.status + "']").prop(
											'checked', 'true');
									$('#roleid').val(data.roleid);
									form.render();
								}
							})
						}
					});
					
					
					

				});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			if (isAdd) {
				editCustom('${domain}/users/addUsers', JSON.stringify({
					username : $('#username').val(),
					password : $('#password').val(),
					roleid:$('#roleid').val(),
					status : $("input[name='status']:checked").val()
				}));
			} else {
				editCustom('${domain}/users/updateUsers', JSON.stringify({
					userid : dataid,
					username : $('#username').val(),
					password : $('#password').val(),
					roleid:$('#roleid').val(),
					status : $("input[name='status']:checked").val()
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
						<label class="layui-form-label">用户名:</label>
						<div class="layui-input-block">
							<input type="text" name="username" id="username"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">密码:</label>
						<div class="layui-input-block">
							<input type="password" name="password" id="password"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否有效:</label>
						<div class="layui-input-block">
							<input type="radio" name="status" value="1" title="有效" checked>
							<input type="radio" name="status" value="0" title="无效">
						</div>

					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">角色:</label>
						<div class="layui-input-block">
							<select name=""roleid"" lay-filter="roleid" id="roleid">
								<option value=""></option>
								<option value="0">写作</option>
								<option value="1" selected="">阅读</option>
								<option value="2">游戏</option>
								<option value="3">音乐</option>
								<option value="4">旅行</option>
							</select>
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