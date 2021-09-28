<%@include file="../includes/header.jsp"%>

<br />
<div class="container border p-3 radius-15">

	<div class="row">
		<div class="col-sm-2">&nbsp;</div>
		<div class="col-sm-8">
			<h1 class="text-center">
				Teacher <strong>login</strong>
			</h1>
			<form class="form-horizontal" id="teacherLoginForm">
				<div class="form-group">
					<label class="control-label col-sm-2" for="email">Email:</label>
					<div class="col-sm-12">
						<input type="email" class="form-control" id="email"
							placeholder="Enter email" name="email" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="password">Password:</label>
					<div class="col-sm-12">
						<input type="password" class="form-control" id="password"
							placeholder="Enter password" name="password" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-12">
						<div class="checkbox">
							<label><input type="checkbox" name="remember">
								Remember me</label>
						</div>
						<div>
							<small>Don't have a account? <a href="teacher/register" class="register-link">Register Here.</a></small>
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
		teacherLoginFormValidate();
		
		var loginTeacher = function(dataToPost){
			$.ajax({
				url: "../teacher/loginTeacher",
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
								message: 'Teacher logged in successfully !'
						}
						notify(option);
		                
						setTimeout(function(){ window.location.href = "../teacher/dashboard"; }, 2000);
						

					}else if(response && response.statusCode == "NOT_FOUND"){
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
		
			
			
			var dataToPost = serializeToJson($('#teacherLoginForm').serialize());
			if( $('#teacherLoginForm').valid() ){
				openLoader(options);
				loginTeacher(dataToPost);	
			}
		});
		
		
	});
</script>