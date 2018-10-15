function getTable($dom, columns, url, pars) {
	$tableObject = $dom.bootstrapTable({
		columns : columns,
		url : url,
		pagination : true,
		sidePagination : 'server',
		pageList : [ 5, 10, 20, 50 ],
		queryParams : function(params) {
			for ( var prop in pars) {
				params.prop = pars[prop];
			}
			return params;
		}
	});

	return $tableObject;
}





