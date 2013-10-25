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
	<script type="text/javascript" src="js/handlebars.js"></script>
	<script type="text/javascript" src="rqlconnector/Rqlconnector.js"></script>
	<script id="page-template" type="text/x-handlebars-template">
		<div class="alert">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>{{guid}}</strong> 
			{{#if id}}
				<span class="label label-success">{{id}}</span> <a href="javascript:GotoTreeSegment('{{guid}}');">{{headline}}</a>
			{{else}}
				<span class="label label-important">PAGE NOT FOUND</span>
			{{/if}}
		</div>
	</script>
	<script type="text/javascript">
		var LoginGuid = '<%= session("loginguid") %>';
		var SessionKey = '<%= session("sessionkey") %>';
		var RqlConnectorObj = new RqlConnector(LoginGuid, SessionKey);
	
		$( document ).ready(function() {
			$('#find-page').on('click', function(){
				var PageGuid = $('#page-guid').val();
				FindPage(PageGuid);
			});
		});
	
		function FindPage(PageGuid)
		{
			PageGuid = $.trim(PageGuid);
			if(PageGuid == '')
			{
				return;
			}
		
			//load simple page info
			var strRQLXML = '<PAGE action="load" guid="' + PageGuid + '"/>';
			
			RqlConnectorObj.SendRql(strRQLXML, false, function(data){
				AppendResult(PageGuid, $(data).find('PAGE').attr('id'), $(data).find('PAGE').attr('headline'));
			});
		}
		
		function AppendResult(PageGuid, PageId, PageHeadline)
		{
			var PageObject = new Object();
			PageObject.guid = PageGuid;
			PageObject.id = PageId;
			PageObject.headline = PageHeadline;
			
			var source = $("#page-template").html();
			var template = Handlebars.compile(source);
			var html = template(PageObject);
			
			$('#search-results').append(html);
		}
		
		function GotoTreeSegment(sGuid, sType)
		{
			top.opener.parent.frames.ioTreeData.location = '../../ioRDLevel1.asp?Action=GotoTreeSegment&Guid=' + sGuid + '&Type=' + sType + '&CalledFromRedDot=0';
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
	<div class="container">
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<span class="brand">Find Page By Guid 2</span>
			</div>
		</div>
		<div class="well">
			<div class="form-horizontal">
				<div class="control-group">
					<label class="control-label" for="inputEmail">Page Guid</label>
					<div class="controls">
						<input class="input-block-level" id="page-guid" type="text" placeholder="Page Guid">
					</div>
				</div>
				<div class="controls">
					<button class="btn btn-success" id="find-page" type="button">Find</button>
				</div>
			</div>
		</div>
		<div id="search-results"></div>
	</div>
</body>
</html>