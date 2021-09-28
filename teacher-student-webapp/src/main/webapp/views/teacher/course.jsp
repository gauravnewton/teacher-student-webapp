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
				
				<div class="row">
					<div class="col-sm-12 text-right">
						<strong class="actionEvent" onClick="addCourse()" data-toggle="modal" data-target="#exampleModal" >Add Course <i class="fa fa-plus" aria-hidden="true"></i> </strong>
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
				
				
				<!-- Modal -->
				<div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">Course Detail</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body registration-form">
				        	<form class="form-horizontal" id="addCourse">
								<div class="form-group">
									<label class="control-label col-sm-2" for="courseName">Course Name:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="courseName"
											placeholder="Enter Course Name" name="courseName" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="courseCategory">Course Category:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="courseCategory"
											placeholder="Enter Course Category" name="courseCategory" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="author">Author:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="author"
											placeholder="Enter Author" name="author" required>
									</div>
								</div>									
				
								<div class="form-group">
									<label class="control-label col-sm-2" for="status">Select Status:</label> 
									<div class="col-sm-12">
										<select class="form-control"
										id="status" name="status" required>
											<option disabled selected>Choose Status</option>
											<option value="ACTIVE">Active</option>
											<option value="IN_ACTIVE">In Active</option>
										</select>
									</div>
								</div>
								
							
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-12 text-right">
										<div class="btn">
											<a href="#" id="save" class="a-btn">Save <span class="fa fa-check"></span></a>
										</div>
										<div class="btn">
											<a href="../teacher/dashboard" class="a-btn"><span class="fa fa-long-arrow-left"></span> Back
											</a>
										</div>
									</div>
								</div>
							</form>
				      </div>
				      
				    </div>
				  </div>
				</div>
				
				
				<!-- Edit Modal -->
				<div class="modal fade " id="editCourseeModal" tabindex="-1" role="dialog" aria-labelledby="editCourseModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="editCourseModalLabel">Course Detail</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body editCourse-form">
				        	<form class="form-horizontal" id="editCourse">
				        	
				        		<input type="hidden" id="editId" name="id" />
								<div class="form-group">
									<label class="control-label col-sm-2" for="courseName">Course Name:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="editCourseName"
											placeholder="Enter Course Name" name="courseName" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="courseCategory">Course Category:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="editCourseCategory"
											placeholder="Enter Course Category" name="courseCategory" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="author">Author:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="editAuthor"
											placeholder="Enter Author" name="author" required>
									</div>
								</div>									
				
								<div class="form-group">
									<label class="control-label col-sm-2" for="status">Select Status:</label> 
									<div class="col-sm-12">
										<select class="form-control"
										id="editStatus" name="status" required>
											<option disabled selected>Choose Status</option>
											<option value="ACTIVE">Active</option>
											<option value="IN_ACTIVE">In Active</option>
										</select>
									</div>
								</div>
								
							
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-12 text-right">
										<div class="btn">
											<a href="#" id="updateCourse" class="a-btn">Save <span class="fa fa-check"></span></a>
										</div>
										<div class="btn">
											<a href="../teacher/dashboard" class="a-btn"><span class="fa fa-long-arrow-left"></span> Back
											</a>
										</div>
									</div>
								</div>
							</form>
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

var courseTable;

var updateCourse = function(dataToSave) {
	$.ajax({
		url: "../course/updateCourse",
		type: 'POST',
		data: dataToSave,
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				var option = {
						title: 'Success',
						delay: 2500,
						fadedelay: 1000,
						closeBtn: false,
						bold: true,
						offset: 40,
						message: 'Course updated successfully !'
				}
				notify(option);
				loadDataTable();
				$('#editCourseeModal').modal("hide");
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


var addNewCourse = function(dataToSave) {
	$.ajax({
		url: "../course/addCourse",
		type: 'POST',
		data: dataToSave,
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				var option = {
						title: 'Success',
						delay: 2500,
						fadedelay: 1000,
						closeBtn: false,
						bold: true,
						offset: 40,
						message: 'Course added successfully !'
				}
				notify(option);
				loadDataTable();
				$('#exampleModal').modal("hide");
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

$('#save').on('click', function(){
	var options = {
	     theme:"sk-rect",
	     message:'Adding new course...',
	     textColor:"white"
	};	
			
			
		var dataToPost = serializeToJson($('#addCourse').serialize());
		if( $('#addCourse').valid() ){
			openLoader(options);
			addNewCourse(dataToPost);	
		}
});

$('#updateCourse').on('click', function(){
	var options = {
	     theme:"sk-rect",
	     message:'Adding new course...',
	     textColor:"white"
	};	
			
			
		var dataToPost = serializeToJson($('#editCourse').serialize());
		if( $('#editCourse').valid() ){
			openLoader(options);
			updateCourse(dataToPost);	
		}
});

var addCourse = function(){
	addCourseFormValidation();
}

var loadCourseDetail = function(courseId){

	courseEditFormValidation();
	
	var options = {
		     theme:"sk-rect",
		     message:'Fetching course detail...',
		     textColor:"white"
		};
		
		openLoader(options);
		
		$.ajax({
			url: "../course/getCourseById/"+courseId,
			type: 'GET',
			crossDomain: true,
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
				if(response && response.statusCode == "OK"){
					closeLoader();
					//rendering course form
					
					$('#editId').val(response.data[0].id);
					$('#editCourseName').val(response.data[0].courseName);
					$('#editCourseCategory').val(response.data[0].courseCategory);
					$('#editAuthor').val(response.data[0].author);
					$('#editStatus').val(response.data[0].status);
					
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
                    		<img src ="assets/images/no-preview.png" alt="" class="img img-responsive img-thumbnail " />
                    	</div>
                    	
                    	<div class="col-sm-10 text-left">
                    		<h1>`+r.courseName+` </h1><br/>
                    		<small>By: `+r.author+` <br/>
                    		Listed under category: `+r.courseCategory+` <br/>
                    		Puiblished on: `+new Date(r.createdOn)+` <br/>
                    		Status: `+r.status+` <br/> 
                    		<a href="#" onClick="loadCourseDetail(`+r.id+`)" data-toggle="modal" data-target="#editCourseeModal" > Edit </a> </small>
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