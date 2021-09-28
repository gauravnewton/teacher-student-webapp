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
				
				<div class="row">
					
					<div class="col-sm-12 text-center">
						<img src="../assets/images/profile.png" alt= "" class="img img-responsive img-thumbnail height-200" /> <br/>
						
						<table class="table table-striped text-left" id="accountDetailtable">
							
						</table>
						
						<div class="btn pull-left">
							<a href="../student/dashboard" class="a-btn"><span class="fa fa-long-arrow-left"></span> Back to dashboard </a>
						</div>
						
					</div>
					
				</div>								
				<%
			}
		%>
		
</div>


<%@include file="../includes/footer.jsp"%>

<script>
var loadProfile = function(){
	var options = {
	     theme:"sk-rect",
	     message:'Fetching Profile Data...',
	     textColor:"white"
	};
	openLoader(options);
	$.ajax({
		url: "../teacher/getStudentById/"+ <%= studentId %>,
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				if( response && response.data ){
					var html =`

						<tr>
							<td>
								First Name: `+response.data[0].firstName+`
							</td>
							<td>
								Last Name:  `+response.data[0].lastName+`
							</td>								
						</tr>
						<tr>
							<td>
								Email Id:  `+response.data[0].email+ `
							</td>
							<td>
								Phone:  `+response.data[0].phone+`
							</td>						
						</tr>
						
						<tr>
							<td>
								Account Status:  `+response.data[0].status+`
							</td>
							<td>
								Account created On:  `+new Date(response.data[0].createdOn)+`
							</td>
						</tr>
					`;
				}
				
				$('#accountDetailtable').html(html);
										
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
	loadProfile();
});
	
</script>