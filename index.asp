<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="expires" content="-1"/>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="copyright" content="2013, Web Site Management" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
	<title>Find Page By Guid 2</title>
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<script type="text/javascript">
		function GotoTreeSegment(sGuid, sType)
		{
			top.opener.parent.frames.ioTreeData.location='../../ioRDLevel1.asp?Action=GotoTreeSegment&Guid=' + sGuid + '&Type=' + sType + '&CalledFromRedDot=0';
		}
	</script>
	<style type="text/css">
		body
		{
			padding: 10px;
		}
		#search-result-template
		{
			display: none;
		}
	</style>
	<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="Rqlconnector.js"></script>
	<script type="text/javascript">
		var LoginGuid = '<%= session("loginguid") %>';
		var SessionKey = '<%= session("sessionkey") %>';
		var RqlConnectorObj = new RqlConnector(LoginGuid, SessionKey);
	
		function FindPage(PageGuid)
		{
			//load simple page info
			var strRQLXML = '<PAGE action="load" guid="' + PageGuid + '"/>';
			
			RqlConnectorObj.SendRql(strRQLXML, false, function(data){
				AppendResult(PageGuid, $(data).find('PAGE').attr('id'), $(data).find('PAGE').attr('headline'));
			});
		}
		
		function AppendResult(PageGuid, PageId, PageHeadline)
		{
			var ResultDom = $('#search-result-template>div').clone();
			$(ResultDom).find('strong').text(PageGuid);
			
			if(PageId != null)
			{
				$(ResultDom).find('span').html('<a href="javascript:GotoTreeSegment(\'' + PageGuid + '\', \'page\');\">[' + PageId + ']' + PageHeadline + '</a>');
			}else{
				$(ResultDom).find('span').text('Page not found');
			}
			
			$('#search-results').append(ResultDom);
		}
	</script>
</head>
<body>
	<div id="processing" class="modal hide fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<h3 id="myModalLabel">Processing</h3>
		</div>
		<div class="modal-body">
			<p>Please wait...</p>
		</div>
	</div>
	<div class="form-horizontal">
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<span class="brand">Find Page By Guid 2</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="txtSearchField">Page Guid</label>
			<div class="controls">
				<input id="txtSearchField" type="text" maxlength="32" size="100%" />
			</div>
		</div>
		<div id="search-results"></div>
		<div id="search-result-template">
			<div class="alert">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong></strong> <span></span>
			</div>
		</div>
		<div class="form-actions">
			<button class="btn btn-success pull-right" onclick="FindPage($('#txtSearchField').val());">Find</button>
		</div>
	</div>
</body>
</html>