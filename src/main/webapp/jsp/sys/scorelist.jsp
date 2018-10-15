<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp"%>
<title>积分列表</title>
<%@ include file="../common/table.jsp"%>
<div id="toolbar">
	<div class="btn-group">
		<button class="btn btn-default" id="export">
			<i class="glyphicon glyphicon-export">导入积分</i>
		</button>
	</div>
	
</div>
<input type="file" name="myfile" id="myfile" style="display: none;" />

<script>
	//Demo
	var form;
	var isAdd = true;
	var dataid = '';
	layui.use('form', function() {
		form = layui.form;

	});

	var $objectTable = getTable($('#tableCommon'), [{
		field : 'customno',
		title : '会员编号'
	}, {
		field : 'customname',
		title : '会员名'
	}, {
		field : 'score',
		title : '积分'
	}, {
		align : 'center',
		field : 'customid',
		title : '修改',
		formatter : function(value) {
			return "<button class='btn btn-info item-edit' data-id='"
					+ value + "'> 修改 </button>";
		}
	}], '${domain}/custom/getCustom', {});

	initListener();

	function deleteUser(ids) {
		var msg = "您真的确定要删除吗？";
		if (confirm(msg) == true) {
			$.ajax({
				url : "${domain}/custom/deletecustombyids",
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
			url : '${domain}/custom/importScore',
			secureuri : false,
			cache : false,
			fileElementId : 'myfile',
			dataType : 'json',
			success : function(data, status) {
				
				alert("导入成功");
				$('#myfile').val('');
				$objectTable.bootstrapTable('refresh');

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

		$('input[type="file"]').on('change', function() {
			ajaxFileUpload();
		});

		$('#delall').on('click', function() {
			$.ajax({
				url : "${domain}/custom/deleteallcustom",
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

		$('body').on('click','.item-edit',function() {
			dataid = $(this).attr('data-id');
			$('#myModal').modal('toggle');
			$('#myModalLabel').html('修改');
			isAdd = false;
			
			$('#customname').val('');
			$('#score').val('');
		
			
			
			$.ajax({
				url : '${domain}/custom/getCustombyid',
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					customid : dataid
				}),
				success : function(data) {
					$('#customname').val(data.customname);
					$('#score').val(data.score)
				}
			})

		});

		$('body').on('click', '.item-del', function() {
			dataid = $(this).attr('data-id');
			deleteUser(dataid);
		});

		$('body').on('click', '#submitBtn', function() {
			editCustom('${domain}/custom/updateScore',JSON.stringify({
				customid:dataid,
				score:$('#score').val()
			}));
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
						<label class="layui-form-label">会员名称:</label>
						<div class="layui-input-block">
							<input disabled="disabled" type="text" name="customname" id="customname"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">积分:</label>
						<div class="layui-input-block">
							<input type="number" name="score" id="score"
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