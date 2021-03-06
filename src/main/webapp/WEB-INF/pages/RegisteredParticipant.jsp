<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>Conference Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">


<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/ParticipantSpeaker.css" rel="stylesheet">
<link href="../css/bootstrap-responsive.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

.navbar-pull-right {
	float: none;
	padding-left: 10px;
	padding-right: 40px;
}

.viewconference {
	margin-bottom: 16px;
	margin-left: 16px;
	margin-right: 16px;
	margin-top: 16px;
	padding: 10px;
	font-size: 18px;
	font-weight: 200;
	line-height: 30px;
	color: inherit;
	font-style: oblique;
	border: 3px solid black;
	background-color: #E6FCB9;
	-webkit-border-radius: 12px;
	-moz-border-radius: 12px;
	border-radius: 45px;
}

.viewconference h1 {
	margin-bottom: 0;
	font-size: 40px;
	line-height: 1;
	color: inherit;
	letter-spacing: -1px;
}

.viewconference h2 {
	margin-bottom: 0;
	font-size: 30px;
	line-height: 1;
	color: inherit;
	letter-spacing: -1px;
}

.viewconference table {
	margin-bottom: 46px;
	margin-left: 46px;
	margin-right: 16px;
	margin-top: 26px;
	align: center;
	padding: 30px;
}

.viewconference tr {
	valign: top;
	align: left;
}

.viewconference td {
	margin-bottom: 0;
	font-size: 20px;
	line-height: 2;
	color: inherit;
	letter-spacing: 0px;
}
</style>
</head>

<body style="background-color: #E6FCB9;">
	<p style="display: none" id="userrole">${user.role}</p>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="navbar-brand"
					style="color: white; font-size: 30px; font-style: italic;" href="#">Organize
					Your Conference</a>
				<p align="right" class="navbar-brand navbar-pull-right">
					Logged in as <a class="navbar-brand navbar-pull-right" href="#">${user.firstName}
						${user.lastName}</a>

				</p>

			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<div class="well sidebar-nav" height="90%">
					<ul class="nav nav-list">
						<li><a class="nav-header" href="../UserHome">Home</a></li>
						<li class="nav-header">Profile</li>
						<li><a class="nav-list" href="../ProfilePage">View/Edit
								Profile</a></li>
						<li class="nav-header">Conference</li>
						<li><a id="creatconference" class="nav-list"
							href="../NewConference">Create Conference</a></li>
						<li><a id="prevconference" class="nav-list"
							href="../ViewAllPreviousConference">Previous Conferences</a></li>
						<li><a id="registeredconference" class="nav-list"
							href="../RegisteredConference">Registered Conferences</a></li>
						<li><a id="editdeleteconf" class="nav-list"
							href="../UpdateConference">Edit Conference</a></li>
						<li><a id="registerconference" class="nav-list"
							href="../RegisterConference/${confer.id}">Register Conference</a></li>
						<li><a id="unregisterconference" class="nav-list"
							href="../DeRegisterConference/${confer.id}">DeRegister
								Conference</a></li>
						<li><a id="uploaddocuments" class="nav-list"
							href="https://www.dropbox.com/1/oauth2/authorize?response_type=code&client_id=vqtzquh9kh5cph6&state=12345&redirect_uri=http://localhost:8080/organize-your-conference/dropbox">Upload
								Documents</a></li>

						</br>
						</br>
						</br>
						</br>
						</br>
						</br>
						<li class="nav-header"><a class="nav-list"
							style="color: white" id="idlogout" href="../Logout">Logout</a></li>
					</ul>
				</div>
				<!--/.well -->
			</div>
			<!--/span-->
			<form id="ViewConference">
				<div class="span9">
					<div class="viewconference">
						<table border="1">
							<tr>
								<th>S. No.</th>
								<th>Participants Name</th>
								<th>Participant's Email ID</th>
							</tr>
							<%int i=1;%>
							<c:forEach var="obj" items="${participants}">
								<tr>
									<td><%=i %></td>
									<td valign="top">${obj.value}</td>
									<td  valign="top">${obj.key}</td>
									<%i++; %>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<!--/span-->
			</form>
		</div>
		<!--/row-->

		<hr>

		<footer>
			<p>&copy;SJSU Edu</p>
		</footer>

	</div>
	<script src="//code.jquery.com/jquery.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			pageLoad();
			enableLinks();
		});

		function pageLoad() {
		}
		
		//this function to enable and disable links as per the user
		function enableLinks() {

			var str = $("#userrole").html();
			if (str == "Organizer") {
				$("#creatconference").show();
				$("#registeredconference").hide();
				$("#prevconference").show();
				$("#registerconference").hide();
				$("#editdeleteconf").show();
				$("#unregisterconference").hide();
				$("#uploaddocuments").hide();

			} else if (str == "Speaker") {
				$("#creatconference").hide();
				$("#registeredconference").hide();
				$("#prevconference").show();
				$("#registerconference").hide();
				$("#editdeleteconf").hide();
				$("#unregisterconference").hide();
				$("#uploaddocuments").show();

			} else if (str == "Participant") {
				$("#creatconference").hide();
				$("#registeredconference").show();
				$("#prevconference").show();
				$("#registerconference").show();
				$("#editdeleteconf").hide();
				$("#unregisterconference").show();
				$("#uploaddocuments").hide();

			}
		}
	</script>

</body>
</html>
