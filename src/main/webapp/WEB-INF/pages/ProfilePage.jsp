<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Profile Page</title>
<meta name="description" content="P Page">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="js/appProfile.js"></script>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/ParticipantSpeaker.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">

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
}
</style>

<!--  <link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap-responsive.css" rel="stylesheet">   -->

</head>
<body>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="navbar-brand"
					style="color: white; font-size: 30px; font-style: italic;" href="#">Organize
					Your Conference</a>
				<p align="right" class="navbar-brand navbar-pull-right">
					Logged in as <a class="navbar-brand navbar-pull-right" href="#">${UserName}</a>
				</p>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<div class="well sidebar-nav" height="90%">
					<ul class="nav nav-list">
						<li><a class="nav-header" href="#">Home</a></li>
						<li class="nav-header">Profile</li>
						<li><a class="nav-list" href="ProfilePage">View/Edit
								Profile</a></li>
						<li class="nav-header">Conference</li>
						<li><a class="nav-list" href="NewConference">Create
								Conference</a></li>
						<li><a class="nav-list" href="ViewAllPreviousConference">Previous
								Conferences</a></li>
						<li><a class="nav-list" href="RegisterParticipant">Register
								for Conferences</a></li>
					</ul>
				</div>
				<!--/.well -->
			</div>
			<!--/span-->


			<form:form method="post" modelAttribute="user" action="/ProfilePage"
				class="form-signin">
				<div class=offset3>
					<div class="span5">

						<table id="profile">
							<tr>
								<td><span class="label">First Name </span></td>
								<td><form:input type="text" id="FName" path="firstName"
										placeholder="Your First Name" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Last Name </span></td>
								<td><form:input type="text" id="LName" path="lastName"
										placeholder="Your Last Name" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Email ID </span></td>
								<td><form:input type="email" id="email" path="emailId"
										placeholder="Your Password" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Password </span></td>
								<td><form:input type="password" id="password" path="password"
										placeholder="Your Password" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Role</span></td>
								<td><form:input type="text" id="role" path="role"
										placeholder="Your Role" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Location</span></td>
								<td><form:input type="text" id="Loc" path="location"
										placeholder="Your Location" disabled="true" /></td>
							</tr>
							<tr>
								<td><span class="label">Position</span></td>
								<td><form:input type="text" id="position" path="position"
										placeholder="Your Position" disabled="true" /></td>
							</tr>
						</table>
						<br> <br>
						<button type="button" id="edit" class="btn btn-primary">Edit</button>
						<button type="submit" id="save" class="btn btn-primary">Save</button>
						<button type="button" id="cancel" class="btn btn-primary">Cancel</button>
					</div>
				</div>
			</form:form>
		</div>
	</div>


</body>
</html>