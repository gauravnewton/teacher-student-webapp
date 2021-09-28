<%@include file="../includes/header.jsp"%>

<%@ page import="com.techreloded.dto.Student" %>
<style>
	body{
		height: unset !important;
	}
</style>

<br/>
<div class="container-fluid">

		
		<% 
		 	long studentId = 0;
			Student studentContext = (Student) session.getAttribute("studentContext"); 
			if( studentContext == null){
				response.sendRedirect("/");
			}else{
				studentId = studentContext.getId();
				%>
				<div class="row bg-dark text-white p-3">
				
					<div class="col-sm-6">
						<a href="<c:url value="../student/dashboard" />" class="text-white">  DashBoard </a> &nbsp; |  &nbsp;
						<a href="<c:url value="../student/myCourses" />" class="text-white"> My Courses </a> &nbsp; |  &nbsp;
						<a href="<c:url value="../student/profile" />" class="text-white"> My Profile </a> &nbsp; | &nbsp;
						<a href="<c:url value="../course/availableCourses" />" class="text-white">  Available Courses </a> 
						
					</div>
					
					
					<div class="col-sm-6 text-right">
						Welcome <span class="text-white"> <%= studentContext.getFirstName() %> <%= studentContext.getLastName() %></span>
						<a href="/teacher/logout" class="text-white">(Logout)</a>
					</div>
				
				</div>
				
				<div class="row statusCards">
					<div class="col-sm-4">
						<div class="card bg-primary text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="enrolledCourses">0</h1>
								Courses Enrolled
							</div>
							<div class="card-footer">
								<a href="../student/myCourses" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
							</div>   
				        </div>				       
					</div>
										
					<div class="col-sm-4">						 
				        <div class="card bg-success text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="avaiableCourses">0</h1>
								Courses Available for Enrolling 
							</div>
							<div class="card-footer">
								<a href="../course/availableCourses" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
							</div>  
				        </div>
					</div>
					
					<div class="col-sm-4">						 
				        <div class="card bg-dark text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="allCourses">0</h1>
								All Courses
							</div>
							<div class="card-footer">
								<a href="../course/availableCourses" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
							</div>   
				        </div>
					</div>
				</div>
				<%
			}
		%>
		
</div>


<%@include file="../includes/footer.jsp"%>

<script>

var allCourses = 0;
var enrolledCourses = 0;

var loadEnrolledCourses = function(){
	var options = {
		     theme:"sk-rect",
		     message:'Fetching Enrolled count...',
		     textColor:"white"
	};
	
	openLoader(options);
	var studentId = <%= studentId %>;
	$.ajax({
		url: "../course/getEnrolledCourses/"+studentId,
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				$('#enrolledCourses').html(response.data.length);	
				enrolledCourses = response.data.length;
				$('#avaiableCourses').html(allCourses - enrolledCourses);
			}else{				
				closeLoader();
				jNotify.error('Error','Something went wrong !',{
					delay: 2500,
					fadeDelay: 1000,
					closeButton: false,
					titleBold: true,
					offset: 40
				});
			}
		},
		error: function(data, textStatus, errorMessage) {
			closeLoader();
			jNotify.error('Error','Something went wrong',{
				delay: 2500,
				fadeDelay: 1000,
				closeButton: false,
				titleBold: true,
				offset: 40
			});

		}
	});
}


var initCountRendring = function(){
	var options = {
		     theme:"sk-rect",
		     message:'Fetching All courses count...',
		     textColor:"white"
	};
	
	openLoader(options);
	$.ajax({
		url: "../course/getAllCourses",
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();		
				$('#allCourses').html(response.data.length);
				allCourses = response.data.length;
				loadEnrolledCourses();
			}else{				
				closeLoader();
				jNotify.error('Error','Something went wrong !',{
					delay: 2500,
					fadeDelay: 1000,
					closeButton: false,
					titleBold: true,
					offset: 40
				});
			}
		},
		error: function(data, textStatus, errorMessage) {
			closeLoader();
			jNotify.error('Error','Something went wrong',{
				delay: 2500,
				fadeDelay: 1000,
				closeButton: false,
				titleBold: true,
				offset: 40
			});

		}
	});
}

$(document).ready(function() {
	initCountRendring();
});
</script>