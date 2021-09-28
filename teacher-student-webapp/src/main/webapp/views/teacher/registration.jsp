<%@include file="../includes/header.jsp"%>

<br />
<div class="container border p-3 radius-15">

	<div class="row">
		<div class="col-sm-2">&nbsp;</div>
		<div class="col-sm-8 registration-form">
			<h1 class="text-center">
				Teacher <strong>Registration</strong>
			</h1>
			<form class="form-horizontal" id="teacherRegistrationForm">
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
					<label class="control-label col-sm-2" for="password">Password:</label>
					<div class="col-sm-12">
						<input type="password" class="form-control" id="password"
							placeholder="Enter Password" name="password" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="repeatPassword">Repeat Password:</label>
					<div class="col-sm-12">
						<input type="password" class="form-control" id="repeatPassword"
							placeholder="Enter Repeat Password" name="repeatPassword" required>
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
					<label class="control-label col-sm-2" for="sel1">Select list:</label> 
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
					<div class="col-sm-offset-2 col-sm-12">
						<div>
							<small>Already have a account ? <a href="../teacher" class="register-link">Login Here.</a></small>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-12 text-right">
						<div class="btn">
							<a href="#" id="register" class="a-btn">Register <span class="fa fa-check"></span></a>
						</div>
						<div class="btn">
							<a href="/" class="a-btn"><span class="fa fa-long-arrow-left"></span> Back
							</a>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="col-sm-2">&nbsp;</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script>
	$(document).ready( function() {
		teacherRegistrationFormValidate();
		
		var registerTeacher = function(dataToPost){
			$.ajax({
				url: "../teacher/submitTeacherRegistrationRequest",
				type: 'POST',
				data: dataToPost,
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
								message: 'Teacher registered successfully !'
						}
						notify(option);
		                
						setTimeout(function(){ window.location.href = "../teacher"; }, 2000);
						

					}else if(response && response.statusCode == "CONFLICT"){
						closeLoader();
						jNotify.error('Error','Email already exists !',{
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
		
		$("#register").on('click', function(){	
			
			var options = {
			     theme:"sk-rect",
			     message:'Hold on',
			     textColor:"white"
			};
		
			
			
			var dataToPost = serializeToJson($('#teacherRegistrationForm').serialize());
			if( $('#teacherRegistrationForm').valid() ){
				openLoader(options);
				registerTeacher(dataToPost);	
			}
		});
		
		
	});
</script>