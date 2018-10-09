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
						field : 'rolename',
						title : '角色名称'
					},
					{
						field : 'description',
						title : '描述'
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
						field : 'roleid',
						title : '修改',
						formatter : function(value) {
							return value=='b8efacbb-7d43-4da5-9f48-9a75d8c68d30'?'':"<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
						}
					},
					{
						align : 'center',
						field : 'roleid',
						title : '删除',
						formatter : function(value) {
							return value=='b8efacbb-7d43-4da5-9f48-9a75d8c68d30'?'':"<button class='btn btn-warning item-del' data-id='"
					+ value + "'> 删除 </button>";
						}
					} ], '${domain}/role/getRole', {});

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
				url : "${domain}/role/deleteRolebyid",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					roleid : id
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
	
	function renderMenuList(callback){
		$.ajax({
			url : "${domain}/menu/selectOption",
			type : "POST",
			data : JSON.stringify({}),
			contentType : "application/json",
			success : function(res) {
				console.log(res);
				var innerHtml='';
				for(var i in res){
					var item=res[i];
					innerHtml+='<input type="checkbox" name="menu" title="'+item.text+'" value="'+item.value+'">'
				}
				
				$('#menulist').html(innerHtml);
				form.render();
				
				callback();
			}
		});
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
			$('#menuname').val('');
			$('#description').val('');
			

			$('input:radio[name=status]').prop('checked', 'false');
			renderMenuList(function(){
				
				
				$('input[name="menu"]').each(function(){
					$(this).remove("checked");
				})
			
				form.render();
			});
			
			

		});

		$('body').on(
				'click',
				'.item-edit',
				function() {
					dataid = $(this).attr('data-id');
					$('#myModal').modal('toggle');
					$('#myModalLabel').html('修改');
					$('input:radio[name=status]').prop('checked', 'false');
					isAdd = false;
					renderMenuList(function(){
						
						
						$('input[name="menu"]').each(function(){
							$(this).remove("checked");
						})

						
						form.render();

						$.ajax({
							url : '${domain}/role/getRolebyid',
							type : "POST",
							contentType : "application/json",
							data : JSON.stringify({
								roleid : dataid
							}),
							success : function(data) {
								$('#rolename').val(data.rolename);
								$('#description').val(data.description);
								$(
										"input:radio[name='status'][value='"
												+ data.status + "']").prop(
										'checked', 'true');
								
								var menuid=data.menuid;
								$('input[name="menu"]').each(function(){
									if(menuid.indexOf($(this).attr('value'))>=0){
										$(this).attr("checked", "checked");
									}
								})
								
								form.render();
							}
						})
					});
					
					

				});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteObject(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			var menuid='';

			$("input:checkbox[name='menu']:checked").each(function() { // 遍历name=test的多选框
				menuid+=$(this).val()+','; // 每一个被选中项的值
			});
			if(menuid.length>0){
				menuid=menuid.substring(0,menuid.length-1)
			}
			if (isAdd) {
				editCustom('${domain}/role/addRole', JSON.stringify({
					rolename : $('#rolename').val(),
					description : $('#description').val(),
					status : $("input[name='status']:checked").val(),
					menuid:menuid
				}));
			} else {
				editCustom('${domain}/role/updateRole', JSON.stringify({
					roleid : dataid,
					rolename : $('#rolename').val(),
					description : $('#description').val(),
					status : $("input[name='status']:checked").val(),
					menuid:menuid
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
						<label class="layui-form-label">角色名:</label>
						<div class="layui-input-block">
							<input type="text" name="rolename" id="rolename"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">描述:</label>
						<div class="layui-input-block">
							<input type="text" name="description" id="description"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">是否有效:</label>
						<div class="layui-input-block">
							<input type="radio" name=status value="1" title="有效" checked>
							<input type="radio" name="status" value="0" title="无效">
						</div>

					</div>

					<div class="layui-form-item">
						<label class="layui-form-label">角色权限:</label>
						<div class="layui-input-block" id="menulist">
							<input type="checkbox" name="like[write]" title="写作">
      						<input type="checkbox" name="like[read]" title="阅读" checked="">
      						<input type="checkbox" name="like[game]" title="游戏">
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