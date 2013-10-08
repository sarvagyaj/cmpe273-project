<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Participant Page</title>
<meta name="description" content="Participant Page">
<link href="css/bootstrap.css" rel="stylesheet">
<script src="jquery-2.0.3.js"></script>
<script>
	$(function() {
		$('#conference').on('click', function(e) {

			alert('Hello!');
		});
	});
</script>
</head>

<body>
	<div class="row">
		<div class="span9">
		<form:form method="post" modelAttribute="participant">
			<p>
				<span class="label">Name </span> <form:input type="text" path="name"  placeholder="Your Name"/>
			</p>
			<p>
				<span class="label">Email ID</span> <input type="text" class="span3"
					placeholder="Your Email ID">
			</p>
			<p>
				<span class="label">Location</span> <input type="text" class="span3"
					placeholder="Your Location">
			</p>
			<div class="btn-group">
		<button class="btn">Register</button>
	</div>
			</form:form>
		</div>
	</div>
	
</body>
</html>