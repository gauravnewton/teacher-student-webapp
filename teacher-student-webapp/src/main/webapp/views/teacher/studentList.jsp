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
					<div class="col-sm-12">
						
						<table id="recordList" class="table table-striped table-bordered dt-responsive nowrap" style="width:100%">
					        <thead>
					            <tr>
					            	<th>Id</th>
					                <th>First name</th>
					                <th>Last name</th>
					                <th>Email</th>
					                <th>Phone</th>
					                <th>gender</th>
					                <th>Status</th>
					                <th>Created on</th>
					                <th>Action</th>
					            </tr>
					        </thead>
					        
					    </table>
						    
					</div>
				</div>
				
				<!-- Modal -->
				<div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">Student Account Detail</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body registration-form">
				        	<form class="form-horizontal" id="studentAccountEditForm">
				        		<input type="hidden" id="id" name="id" />
								<div class="form-group">
									<label class="control-label col-sm-2" for="firstName">First Name:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="firstName"
											placeholder="Enter First Name" name="firstName" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="lastName">Last Name:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="lastName"
											placeholder="Enter Last Name" name="lastName" required>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="email">Email:</label>
									<div class="col-sm-12">
										<input type="email" class="form-control" id="email"
											placeholder="Enter Email" name="email" required>
									</div>
								</div>
																
								<div class="form-group">
									<label class="control-label col-sm-2" for="pwd">Phone No:</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="phone"
											placeholder="Enter Phone number" name="phone" required>
									</div>
								</div>
				
								<div class="form-group">
									<label class="control-label col-sm-2" for="gender">Select Gender:</label> 
									<div class="col-sm-12">
										<select class="form-control"
										id="gender" name="gender" required>
											<option disabled selected>Choose Gender</option>
											<option value="Male">Male</option>
											<option value="Female">Female</option>
											<option value="Transgender">TransGender</option>
										</select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-sm-2" for="status">Select Status:</label> 
									<div class="col-sm-12">
										<select class="form-control"
										id="status" name="status" required>
											<option disabled selected>Choose Status</option>
											<option value="ACTIVE">Active</option>
											<option value="DELETED">Delete</option>
											<option value="PENDING_APPROVAL">Pending Approval</option>
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
				<%
			}
		%>
		
</div>


<%@include file="../includes/footer.jsp"%>

<script>

var studentTable;



var saveStudentAccount = function( dataToSave ){
	$.ajax({
		url: "../teacher/updateStudentAccount",
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
						message: 'Student account updated successfully !'
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
	     message:'Updating student account...',
	     textColor:"white"
	};	
		
		
	var dataToPost = serializeToJson($('#studentAccountEditForm').serialize());
	if( $('#studentAccountEditForm').valid() ){
		openLoader(options);
		saveStudentAccount(dataToPost);	
	}
})


var editStudent  = function(studentId){
	var options = {
		     theme:"sk-rect",
		     message:'Fetching student account...',
		     textColor:"white"
		};
		
		openLoader(options);
		
		$.ajax({
			url: "../teacher/getStudentById/"+studentId,
			type: 'GET',
			crossDomain: true,
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
				if(response && response.statusCode == "OK"){
					closeLoader();
					//rendering student form
					$('#id').val(response.data[0].id);
					$('#firstName').val(response.data[0].firstName);
					$('#lastName').val(response.data[0].lastName);
					$('#email').val(response.data[0].email);
					$('#phone').val(response.data[0].phone);
					$('#gender').val(response.data[0].gender);
					$('#status').val(response.data[0].status);
					
					studentEditFormvalidation();
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


var deleteStudentAccount = function(studentId){
	var options = {
		     theme:"sk-rect",
		     message:'Deleting student account...',
		     textColor:"white"
		};
		
		openLoader(options);
		
		$.ajax({
			url: "../teacher/deleteStudentAccount/"+studentId,
			type: 'POST',
			crossDomain: true,
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
				if(response && response.statusCode == "OK"){
					closeLoader();
					loadDataTable();
					jNotify.success('Alert','Student deleted !',{
						delay: 2500,
						fadeDelay: 1000,
						closeButton: false,
						titleBold: true,
						offset: 40
					});
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
	
	if( studentTable ){
		studentTable.fnClearTable();
		studentTable.fnDestroy();
	}
	  
	studentTable = $("#recordList").dataTable({
        "aaData" : response,
        "autoWidth": false,        
        "scrollX": true,
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "order": [[ 1, "desc" ]],
        "info": true,
        "oLanguage" : {
            "sInfoEmpty" : "No keyword to show"
        },
        "sortable": true,
        "aoColumns" : [
            {
                mData : 'id',
                sClass: 'text-center vertically-align'
            },
            {
                mData : 'firstName',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'lastName',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'email',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'phone',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'gender',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'status',
                sClass: 'text-center vertically-align'
            },
            {
                mData: 'createdOn',
                sClass: 'text-center vertically-align'
            },
            {
                mData: null,
                sClass: 'text-center vertically-align'
            }

        ],
        "aoColumnDefs" : [
        	{
                "aTargets" : [ 7 ],
                "mRender" : function(d,t,r){
                    return new Date(d);
                }
                
            },
            {
                "aTargets" : [ 8 ],
                "mRender" : function(d,t,r){
                	var conditionalDelete = `<i class="fa fa-trash actionEvent" studentId="`+r.id+`" onClick="deleteStudentAccount(`+r.id+`)"></i>`;
                	if( r.status == 'DELETED'){
                		conditionalDelete = ``;
                	}
                    var html = `<div>
                    	<i class="fa fa-edit actionEvent" data-toggle="modal" data-target="#exampleModal" studentId="`+r.id+`" onClick="editStudent(`+r.id+`)" ></i>
                    	`+conditionalDelete+`
                    </div>`;
                    
                    return html;
                }
                
            }
        ]
        
    });



}


	var loadDataTable = function(){
		$.ajax({
			url: "../teacher/getAllStudentList",
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