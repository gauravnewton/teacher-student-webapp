<%@include file="../includes/header.jsp"%>

<br />
<div class="container border p-3 radius-15">

	<div class="row">
		<div class="col-sm-2">&nbsp;</div>
		<div class="col-sm-8">
			<h1 class="text-center">
				Student <strong>login</strong>
			</h1>
			<form class="form-horizontal" id="studentLoginForm">
				<div class="form-group">
					<label class="control-label col-sm-2" for="email">Email:</label>
					<div class="col-sm-12">
						<input type="email" class="form-control" id="email"
							placeholder="Enter email" name="email">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="password">Password:</label>
					<div class="col-sm-12">
						<input type="password" class="form-control" id="password"
							placeholder="Enter password" name="password">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-12">
						<div class="checkbox">
							<label><input type="checkbox" name="remember">
								Remember me</label>
						</div>
						<div>
							<small>Don't have a account? <a href="student/register" class="register-link">Register Here.</a></small>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-12 text-right">
						<div class="btn">
							<a href="#" id="loginBtn" class="a-btn">Login <span class="fa fa-sign-in"></span></a>
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
		studentLoginFormValidate();
		
		var loginStudent = function(dataToPost){
			$.ajax({
				url: "../student/loginStudent",
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
								message: 'Student logged in successfully !'
						}
						notify(option);
		                
						setTimeout(function(){ window.location.href = "../student/dashboard"; }, 2000);
						

					}else if(response && response.statusCode == "NOT_ACCEPTABLE"){
						closeLoader();
						jNotify.error('Error','Account deleted by admin!',{
							delay: 2500,
							fadeDelay: 1000,
							closeButton: false,
							titleBold: true,
							offset: 40
						});
					}					
					else if(response && response.statusCode == "LOCKED"){
						closeLoader();
						jNotify.error('Error','Account not approved yet!',{
							delay: 2500,
							fadeDelay: 1000,
							closeButton: false,
							titleBold: true,
							offset: 40
						});
					}
					
					else if(response && response.statusCode == "NOT_FOUND"){
						closeLoader();
						jNotify.error('Error','Invalid creds !',{
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
		
		$("#loginBtn").on('click', function(){	
			
			var options = {
			     theme:"sk-rect",
			     message:'Logging you in...',
			     textColor:"white"
			};
		
			
			
			var dataToPost = serializeToJson($('#studentLoginForm').serialize());
			if( $('#studentLoginForm').valid() ){
				openLoader(options);
				loginStudent(dataToPost);	
			}
		});
		
		
	});
</script>