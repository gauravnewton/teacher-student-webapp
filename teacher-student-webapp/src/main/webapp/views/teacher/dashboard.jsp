<%@include file="../includes/header.jsp"%>

<%@ page import="com.techreloded.dto.Teacher" %>
<style>
	body{
		height: unset !important;
	}
</style>

<br/>
<div class="container-fluid">

		
		<% 
			Teacher tearcherContext = (Teacher) session.getAttribute("teacherContext"); 
			if( tearcherContext == null){
				response.sendRedirect("/");
			}else{
				%>
				<div class="row bg-dark text-white p-3">
				
					<div class="col-sm-6">
						<a href="<c:url value="../teacher/dashboard" />" class="text-white"> DashBoard </a> &nbsp; |  &nbsp;
						<a href="<c:url value="../course" />" class="text-white"> Courses </a> &nbsp; |  &nbsp;
						<a href="<c:url value="../teacher/studentRequests" />" class="text-white"> Student Registration Request </a> &nbsp; | &nbsp;
						<a href="<c:url value="../teacher/studentList" />" class="text-white">  Student Lists </a>  
						
						
					</div>
					
					
					<div class="col-sm-6 text-right">
						Welcome <span class="text-white"> <%= tearcherContext.getFirstName() %> <%= tearcherContext.getLastName() %></span>
						<a href="/teacher/logout" class="text-white">(Logout)</a>
					</div>
				
				</div>
				
				<div class="row statusCards">
					<div class="col-sm-4">
						<div class="card bg-primary text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="allCourseCount">0</h1>
								Courses
							</div>
							<div class="card-footer">
								<a href="" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
							</div>   
				        </div>				       
					</div>
					
					<div class="col-sm-4">						 
				        <div class="card bg-success text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="studentApprovalCount">0</h1>
								New Student Registrations  
							</div>
							<div class="card-footer">
								<a href="" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
							</div>  
				        </div>
					</div>
					
					<div class="col-sm-4">						 
				        <div class="card bg-dark text-white cardDesign text-center">  
				            <div class="card-body">
								<h1 id="activeStudentCount">0</h1>
								Active Student
							</div>
							<div class="card-footer">
								<a href="" class="text-white">View </a> <i class="fa fa-arrow-right"></i>
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
var studentApprovalCount = 0;
var loadNewStudentRequest = function(){
	var options = {
		     theme:"sk-rect",
		     message:'Fetching new student approval count...',
		     textColor:"white"
	};
	
	openLoader(options);
	$.ajax({
		url: "../teacher/getStudentListForApproval/",
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				$('#studentApprovalCount').html(response.data.length);
				studentApprovalCount = response.data.length;
				loadActiveStudent();
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


var loadActiveStudent = function(){
	var options = {
		     theme:"sk-rect",
		     message:'Fetching active student count...',
		     textColor:"white"
	};
	
	openLoader(options);
	$.ajax({
		url: "../teacher/getAllStudentList",
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();		
				$('#activeStudentCount').html(response.data.length - studentApprovalCount);
				
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
		     message:'Fetching all courses count...',
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
				$('#allCourseCount').html(response.data.length);
				loadNewStudentRequest();
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