var serializeToJson = function(qs) {
	qs = qs || location.search.slice(1);
	var pairs = qs.split('&');
	var result = {};
	pairs.forEach(function(p) {
		var pair = p.split('=');
		var key = pair[0];
		var value = decodeURIComponent(pair[1] || '');

		if (result[key]) {
			if (Object.prototype.toString.call(result[key]) === '[object Array]') {
				result[key].push(value);
			} else {



				result[key] = [result[key], value];

			}
		} else {
			result[key] = value;
		}
	});
	return JSON.stringify(result);
}

var openLoader = function(options) {
	HoldOn.open(options);
}

var closeLoader = function() {
	HoldOn.close();
}



var confirmDialog = function(options) {
	$.confirm({
		title: options.title,
		content: options.content,
		theme: 'black',
		buttons: {
			confirm: function() {
		options.confirm;
	},
		cancel: function() {
			options.cancle;
		}
		}
	});
}

var notify = function(options) {
	jNotify.push(options.title, options.message, {
		delay: options.delay, //2500
		fadeDelay: options.fadedelay, //1000
		closeButton: options.closeBtn,
		titleBold: options.bold,
		offset: options.offset, //40
	});
}

var courseEditFormValidation = function(){
	
	$('#editCourseeModal').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			courseName: {
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			courseCategory: {
				required: true,
				minlength: 3,
				maxlength: 30,

			},
			author:{
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			status: {
				required : true,
			},

		},
		messages: {
			courseName: {
				required:  "Course Name is required",
				minlength: "Course Name should be greater then 3 character",
				maxlength: "Course Name shouldn't be greater than 100 charater"
			},
			courseCategory: {
				required:  "Course Category is required",
				minlength: "Course Category should be greater then 3 character",
				maxlength: "Course Category shouldn't be greater than 100 charater"
			},
			author:{
				required:  "Author is required",
				minlength: "Author should be greater then 3 character",
				maxlength: "Author shouldn't be greater than 100 charater"
			},
			status: {
				required : 'Status is required',
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}

var addCourseFormValidation = function(){
	
	
	$('#addCourse').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			courseName: {
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			courseCategory: {
				required: true,
				minlength: 3,
				maxlength: 30,

			},
			author:{
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			status: {
				required : true,
			},

		},
		messages: {
			courseName: {
				required:  "Course Name is required",
				minlength: "Course Name should be greater then 3 character",
				maxlength: "Course Name shouldn't be greater than 100 charater"
			},
			courseCategory: {
				required:  "Course Category is required",
				minlength: "Course Category should be greater then 3 character",
				maxlength: "Course Category shouldn't be greater than 100 charater"
			},
			author:{
				required:  "Author is required",
				minlength: "Author should be greater then 3 character",
				maxlength: "Author shouldn't be greater than 100 charater"
			},
			status: {
				required : 'Status is required',
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}



var studentEditFormvalidation = function(){
	
	$('#studentAccountEditForm').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			firstName: {
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			lastName: {
				required: true,
				minlength: 3,
				maxlength: 30,

			},
			email:{
				required: true,
				email : true
			},
			status: {
				required : true,
			},
			phone: {
				required : true,
				number: true				
			},
			gender: {
				required : true
			}

		},
		messages: {
			firstName: {
				required: "First Name is required",
				minlength: "First Name should be greater then 3 character",
				maxlength: "First Name shouldn't be greater than 100 charater"
			},
			lastName: {
				required: "Last Name is required",
				minlength: "Last Name should be greater then 3 character",
				maxlength: "Last Name shouldn't be greater than 100 charater"
			},
			email:{
				required : 'Email is required',
				email : 'Please enter a valid email address'
			},
			status: {
				required : 'Status is required',
			},
			phone: {
				required : 'Phone Number is required',
				number: 'Invalid Phone Number'
			},
			gender: {
				required: 'Gender is required'
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}

var teacherLoginFormValidate = function(){
	$('#teacherLoginForm').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			email: {
				required: true,
			},
			password: {
				required: true,

			}

		},
		messages: {
			email: {
				required: "Email is required",				
			},
			password: {
				required: "Pasword is required",
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}


var studentLoginFormValidate = function(){
	$('#studentLoginForm').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			email: {
				required: true,
			},
			password: {
				required: true,

			}

		},
		messages: {
			email: {
				required: "Email is required",				
			},
			password: {
				required: "Pasword is required",
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}

var teacherRegistrationFormValidate  = function() {

	$('#teacherRegistrationForm').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			firstName: {
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			lastName: {
				required: true,
				minlength: 3,
				maxlength: 30,

			},
			email:{
				required: true,
				email : true
			},
			password: {
				required : true,
				equalTo: "#repeatPassword"
			},
			repeatPassword: {
				required : true,
				equalTo: "#password"
			},
			phone: {
				required : true,
				number: true				
			},
			gender: {
				required : true
			}

		},
		messages: {
			firstName: {
				required: "First Name is required",
				minlength: "First Name should be greater then 3 character",
				maxlength: "First Name shouldn't be greater than 100 charater"
			},
			lastName: {
				required: "Last Name is required",
				minlength: "Last Name should be greater then 3 character",
				maxlength: "Last Name shouldn't be greater than 100 charater"
			},
			email:{
				required : 'Email is required',
				email : 'Please enter a valid email address'
			},
			password: {
				required : 'Password is required',
				equalTo: "Password is not matched with repeat password"
			},
			repeatPassword: {
				required : "repeate Password is required",
				equalTo: "Repeate Password is not matched with Password"
			},
			phone: {
				required : 'Phone Number is required',
				number: 'Invalid Phone Number'
			},
			gender: {
				required: 'Gender is required'
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}

var studentRegistrationFormValidate = function() {

	$('#studentRegistrationForm').validate({
		onfocusout: function(element) {
			$(element).valid()
		},
		errorClass: 'text-danger small',
		highlight: function(element) {
			$(element)
				.closest('.form-control')
				.addClass('is-invalid')
				.removeClass('is-valid');
		},
		unhighlight: function(element) {
			$(element)
				.closest('.form-control')
				.removeClass('is-invalid')
				.addClass('is-valid');
		},
		rules: {
			firstName: {
				required: true,
				minlength: 3,
				maxlength: 30,
			},
			lastName: {
				required: true,
				minlength: 3,
				maxlength: 30,

			},
			email:{
				required: true,
				email : true
			},
			password: {
				required : true,
				equalTo: "#repeatPassword"
			},
			repeatPassword: {
				required : true,
				equalTo: "#password"
			},
			phone: {
				required : true,
				number: true				
			},
			gender: {
				required : true
			}

		},
		messages: {
			firstName: {
				required: "First Name is required",
				minlength: "First Name should be greater then 3 character",
				maxlength: "First Name shouldn't be greater than 100 charater"
			},
			lastName: {
				required: "Last Name is required",
				minlength: "Last Name should be greater then 3 character",
				maxlength: "Last Name shouldn't be greater than 100 charater"
			},
			email:{
				required : 'Email is required',
				email : 'Please enter a valid email address'
			},
			password: {
				required : 'Password is required',
				equalTo: "Password is not matched with repeat password"
			},
			repeatPassword: {
				required : "repeate Password is required",
				equalTo: "Repeate Password is not matched with Password"
			},
			phone: {
				required : 'Phone Number is required',
				number: 'Invalid Phone Number'
			},
			gender: {
				required: 'Gender is required'
			}

		},
		error: function(label) {
			$(this).addClass("error");
		},
	});
}