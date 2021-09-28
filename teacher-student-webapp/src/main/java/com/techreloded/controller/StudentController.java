package com.techreloded.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.techreloded.constant.AppConstant;
import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Student;
import com.techreloded.service.StudentService;

/**
 * The Class StudentController.
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController {
	
	/** The student service. */
	@Autowired
	StudentService studentService;
	

	/**
	 * Student login.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "")
	public ModelAndView studentLogin(HttpServletRequest request)  {
		ModelAndView modelAndView = new ModelAndView("student/login");
		request.setAttribute("pageTitle", "Student login");
		return modelAndView;
	}
	
	/**
	 * Student login.
	 *
	 * @return the string
	 */
	@GetMapping(value = "/")
	public String studentLogin() {
		return "redirect: /student";
	}
	
	/**
	 * Register student.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/register")
	public ModelAndView registerStudent(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("student/registration");
		request.setAttribute("pageTitle", "Student Registration");
		return modelAndView;
	}
	
	/**
	 * Process student registration request.
	 *
	 * @param studentRequest the student request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/submitStudentRegistrationRequest", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> processStudentRegistrationRequest( @RequestBody Student studentRequest, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Student> existingStudents = studentService.getStudentByEmailId(studentRequest.getEmail());
			if( existingStudents.isEmpty() ) {
				int studentId = studentService.registerStudent(studentRequest);
				response.put(AppConstant.DATA, studentId);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Student registered successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
			}else {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, false);
				response.put(AppConstant.MESSAGE, "Email Id already exists in our system !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.CONFLICT);
			}
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	
	/**
	 * Login teacger.
	 *
	 * @param loginRequest the login request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/loginStudent", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginTeacger( @RequestBody LoginRequest loginRequest, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Student> student = studentService.loginStudent(loginRequest);
			if( !student.isEmpty() && !student.get(0).getStatus().equals("PENDING_APPROVAL") && !student.get(0).getStatus().equals("DELETED")) {
				response.put(AppConstant.DATA, student);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Login successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
				
				request.getSession().setAttribute("studentContext", student.get(0));
			}else if( !student.isEmpty() && student.get(0).getStatus().equals("DELETED") ) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Account deleted !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.NOT_ACCEPTABLE);
				
				request.getSession().setAttribute("studentContext", student.get(0));
			}else if( !student.isEmpty() && student.get(0).getStatus().equals("PENDING_APPROVAL") ){
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Account not approved yet !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.LOCKED);
			}else {
			
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Invalid Credentials !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.NOT_FOUND);
			}
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	/**
	 * Dash board.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/dashboard")
	public ModelAndView dashBoard(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("student/dashboard");
		request.setAttribute("pageTitle", "Student DashBoard");
		Student studentContext = (Student) request.getSession().getAttribute("studentContext");
		if( Objects.isNull(studentContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	
	
	/**
	 * Profile.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/profile")
	public ModelAndView profile(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("student/profile");
		request.setAttribute("pageTitle", "Student Profile");
		Student studentContext = (Student) request.getSession().getAttribute("studentContext");
		if( Objects.isNull(studentContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	

	/**
	 * My courses.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/myCourses")
	public ModelAndView myCourses(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("student/myCourse");
		request.setAttribute("pageTitle", "My Course");
		Student studentContext = (Student) request.getSession().getAttribute("studentContext");
		if( Objects.isNull(studentContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	
	
	
}
