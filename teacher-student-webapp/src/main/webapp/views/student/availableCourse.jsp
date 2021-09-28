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
					<div class="col-sm-12">
						
						
						<table id="recordList" class="table table-striped table-bordered dt-responsive" style="width:100%">
					        <thead>
					        	<tr><td></td></tr>
					        </thead>
					    </table>
						    
					</div>
				</div>
				<%
			}
		%>
		
</div>


<%@include file="../includes/footer.jsp"%>

<script>


var courseTable;

var enrollInCourse = function(courseId, studentId){
	$.ajax({
		url: "../course/enroll/"+courseId+"/"+studentId,
		type: 'POST',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				jNotify.success('Success','Course enrolled Successfully !',{
					delay: 2500,
					fadeDelay: 1000,
					closeButton: false,
					titleBold: true,
					offset: 40
				});
			} else{				
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

var checkEligibililty = function( courseId ){
	var studentId = <%=studentId %>;	
	
	var options = {
		     theme:"sk-rect",
		     message:'Analysing eligibility...',
		     textColor:"white"
	};
	
	openLoader(options);
	$.ajax({
		url: "../course/analyseEnrollmentEligilibity/"+courseId+"/"+studentId,
		type: 'GET',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "NOT_FOUND"){
				closeLoader();
					$.confirm({
						title: 'Alert',
						content: 'Are you wanna enroll into this course ?',
						theme: 'black',
						buttons: {
							confirm: function() {
								enrollInCourse(courseId, studentId);
						},
							cancel: function() {
								jNotify.error('Error','user discarded the action !',{
									delay: 2500,
									fadeDelay: 1000,
									closeButton: false,
									titleBold: true,
									offset: 40
								});
							}
						}
					});
				
														
			}else if(response && response.statusCode == "CONFLICT"){
				closeLoader();
				jNotify.error('Error','You have already enrolled for this course !',{
					delay: 2500,
					fadeDelay: 1000,
					closeButton: false,
					titleBold: true,
					offset: 40
				});
			} else{				
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

var renderDataTable = function(response){
	
	if( courseTable ){
		courseTable.fnClearTable();
		courseTable.fnDestroy();
	}
	  
	courseTable = $("#recordList").dataTable({
        "aaData" : response,
        "autoWidth": false,        
        "scrollX": true,
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": false,        
        "info": true,
        "oLanguage" : {
            "sInfoEmpty" : "No keyword to show"
        },
        "sortable": true,
        "aoColumns" : [
            
            {
                mData: null,
                sClass: 'text-center vertically-align'
            }

        ],
        "aoColumnDefs" : [
        	
            {
                "aTargets" : [ 0 ],
                "mRender" : function(d,t,r){
                    var html = `
                    <div class="row mar-right-0">
                    	<div class="col-sm-2">
                    		<img src ="../assets/images/no-preview.png" alt="" class="img img-responsive img-thumbnail " />
                    	</div>
                    	
                    	<div class="col-sm-10 text-left">
                    		<h1>`+r.courseName+` </h1><br/>
                    		<small>By: `+r.author+` <br/>
                    		Listed under category: `+r.courseCategory+` <br/>
                    		Puiblished on: `+new Date(r.createdOn)+` <br/>
                    		Status: `+r.status+` <br/> 
                    		<a href="#" onClick="checkEligibililty(`+r.id+`)" > Enroll in this course  </a> </small>
                    	</div>
                    </div>`;

                    return html;
                }
                
            }
        ]
        
    });



}

	var loadDataTable = function(){
		$.ajax({
			url: "../course/getAllCourses",
			type: 'GET',
			crossDomain: true,
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
				if(response && response.statusCode == "OK"){
					closeLoader();
					renderDataTable(response.data);
											
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
		loadDataTable();
	});
</script>