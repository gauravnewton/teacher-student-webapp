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
						<a href="<c:url value="../course" />" class="text-white"> Courses</a>  &nbsp; |  &nbsp;
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
						
						
						<table id="recordList" class="table table-striped table-bordered dt-responsive" style="width:100%">
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
				
				
				
				<%
			}
		%>
		
</div>


<%@include file="../includes/footer.jsp"%>

<script>

var studentTable;


var approveStudentAccount = function(studentId){
	var options = {
	     theme:"sk-rect",
	     message:'Approving student account...',
	     textColor:"white"
	};
	
	openLoader(options);
	
	$.ajax({
		url: "../teacher/approveStudentAccount/"+studentId,
		type: 'POST',
		crossDomain: true,
		dataType: 'json',
		contentType: 'application/json',
		success: function(response) {
			if(response && response.statusCode == "OK"){
				closeLoader();
				loadDataTable();
				jNotify.success('Alert','Student account approved !',{
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
					$('#id').val(response.data[0].firstName);
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
                    var html = `<div>
                    	<i class="fa fa-check-square actionEvent" studentId="`+r.id+`" onClick="approveStudentAccount(`+r.id+`)"></i>
                    	<i class="fa fa-trash actionEvent" studentId="`+r.id+`" onClick="deleteStudentAccount(`+r.id+`)"></i>
                    </div>`;
                    
                    return html;
                }
                
            }
        ]
        
    });



}

	var loadDataTable = function(){
		$.ajax({
			url: "../teacher/getStudentListForApproval",
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