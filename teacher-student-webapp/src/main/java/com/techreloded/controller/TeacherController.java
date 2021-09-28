/*
 * 
 */
package com.techreloded.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.techreloded.constant.AppConstant;
import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Student;
import com.techreloded.dto.Teacher;
import com.techreloded.service.StudentService;
import com.techreloded.service.TeacherService;

/**
 * The Class TeacherController.
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {
	
	/** The teacher service. */
	@Autowired
	TeacherService teacherService;
	
	/** The student service. */
	@Autowired
	private StudentService studentService;
	
	/**
	 * Logout.
	 *
	 * @param request the request
	 * @return the string
	 */
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }
	    return "redirect:/";
	}

	/**
	 * Teacher login.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "")
	public ModelAndView teacherLogin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/login");
		request.setAttribute("pageTitle", "Teacher login");
		return modelAndView;
	}
	
	/**
	 * Teacher login.
	 *
	 * @return the string
	 */
	@GetMapping(value = "/")
	public String teacherLogin() {
		return "redirect: /teacher";
	}
	
	/**
	 * Register teacher.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/register")
	public ModelAndView registerTeacher(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/registration");
		request.setAttribute("pageTitle", "Teacher Registration");
		return modelAndView;
	}
	
	/**
	 * Dash board.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/dashboard")
	public ModelAndView dashBoard(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/dashboard");
		request.setAttribute("pageTitle", "Teacher DashBoard");
		Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
		if( Objects.isNull(teacherContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	
	
	/**
	 * Student requests.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/studentRequests")
	public ModelAndView studentRequests(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/studentRegistrationList");
		request.setAttribute("pageTitle", "Student Approval Request");
		Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
		if( Objects.isNull(teacherContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	
	/**
	 * Student list.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/studentList")
	public ModelAndView studentList(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/studentList");
		request.setAttribute("pageTitle", "Student List");
		Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
		if( Objects.isNull(teacherContext) ) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}
	
	/**
	 * Process teacher registration request.
	 *
	 * @param teacherRequest the teacher request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/submitTeacherRegistrationRequest", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> processTeacherRegistrationRequest( @RequestBody Teacher teacherRequest, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Teacher> existingStudents = teacherService.getTeacherByEmailId(teacherRequest.getEmail());
			if( existingStudents.isEmpty() ) {
				int teacherId = teacherService.registerTeacher(teacherRequest);
				response.put(AppConstant.DATA, teacherId);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Teacher registered successfully !");
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
	@RequestMapping(value = "/loginTeacher", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginTeacger( @RequestBody LoginRequest loginRequest, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Teacher> teacher = teacherService.loginTeacher(loginRequest);
			if( !teacher.isEmpty() ) {
				response.put(AppConstant.DATA, teacher);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Login successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
				
				request.getSession().setAttribute("teacherContext", teacher.get(0));
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
	 * Gets the student list for approval.
	 *
	 * @param request the request
	 * @return the student list for approval
	 */
	@RequestMapping(value = "/getStudentListForApproval", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getStudentListForApproval( HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Student> students = studentService.getStudentListForApproval();			
			response.put(AppConstant.DATA, students);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Data fetched successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);						
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	/**
	 * Gets the all student list.
	 *
	 * @param request the request
	 * @return the all student list
	 */
	@RequestMapping(value = "/getAllStudentList", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getAllStudentList( HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Student> students = studentService.getAllStudentList();			
			response.put(AppConstant.DATA, students);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Data fetched successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);						
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	/**
	 * Approve student account.
	 *
	 * @param studentId the student id
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/approveStudentAccount/{studentId}", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> approveStudentAccount( @PathVariable("studentId") String studentId, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			int id = studentService.approveStudentAccount(studentId);			
			response.put(AppConstant.DATA, id);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Student account approved successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);						
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	
	
	/**
	 * Delete student account.
	 *
	 * @param studentId the student id
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/deleteStudentAccount/{studentId}", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteStudentAccount( @PathVariable("studentId") String studentId, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			int id = studentService.deleteStudentAccount(studentId);			
			response.put(AppConstant.DATA, id);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Student account deleted successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);						
			
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	
	/**
	 * Gets the student by id.
	 *
	 * @param studentId the student id
	 * @param request the request
	 * @return the student by id
	 */
	@RequestMapping(value = "/getStudentById/{studentId}", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getStudentById( @PathVariable("studentId") String studentId, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			List<Student> student = studentService.getStudentById(studentId);			
			if( student.isEmpty() ) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, false);
				response.put(AppConstant.MESSAGE, "Student account not found !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.NOT_FOUND);
			}else {
				response.put(AppConstant.DATA, student);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Student account fetched successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);	
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
	 * Update student account.
	 *
	 * @param studentRequest the student request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/updateStudentAccount", produces = {MediaType.APPLICATION_JSON_VALUE}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateStudentAccount( @RequestBody Student studentRequest, HttpServletRequest request){
		Map<String, Object> response = new HashMap<>();
		try {
			Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
			if( Objects.isNull(teacherContext) ) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Session expired !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_REQUEST);
			}else {
				int studentId = studentService.updateStudentAccount(studentRequest, teacherContext.getFirstName() +" "+ teacherContext.getLastName());
				response.put(AppConstant.DATA, studentId);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Student account updated successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
			}
			
						
		}catch(Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;		
	}
	
	
	
}
