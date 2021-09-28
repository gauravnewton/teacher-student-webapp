package com.techreloded.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.techreloded.constant.AppConstant;
import com.techreloded.dto.Course;
import com.techreloded.dto.Student;
import com.techreloded.dto.StudentCourseEnrollment;
import com.techreloded.dto.Teacher;
import com.techreloded.service.CourseService;


/**
 * The Class CourseController.
 */
@Controller
@RequestMapping(value = "/course")
public class CourseController {

	/** The course service. */
	@Autowired
	CourseService courseService;

	/**
	 * Index.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("teacher/course");
		request.setAttribute("pageTitle", "Courses");
		Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
		if (Objects.isNull(teacherContext)) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}

	/**
	 * Available courses.
	 *
	 * @param request the request
	 * @return the model and view
	 */
	@GetMapping(value = "/availableCourses")
	public ModelAndView availableCourses(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("student/availableCourse");
		request.setAttribute("pageTitle", "Courses");
		Student studentContext = (Student) request.getSession().getAttribute("studentContext");
		if (Objects.isNull(studentContext)) {
			modelAndView = new ModelAndView("/index");
		}
		return modelAndView;
	}

	/**
	 * Adds the course.
	 *
	 * @param courseRequest the course request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/addCourse", produces = { MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addCourse(@RequestBody Course courseRequest, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			int courseId = courseService.addCourse(courseRequest);
			response.put(AppConstant.DATA, courseId);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Course created successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Update course.
	 *
	 * @param courseRequest the course request
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/updateCourse", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCourse(@RequestBody Course courseRequest,
			HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			Teacher teacherContext = (Teacher) request.getSession().getAttribute("teacherContext");
			if (Objects.isNull(teacherContext)) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Session expired !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_REQUEST);
			} else {
				int studentId = courseService.updateCourse(courseRequest,
						teacherContext.getFirstName() + " " + teacherContext.getLastName());
				response.put(AppConstant.DATA, studentId);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Student account updated successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
			}
		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Gets the all courses.
	 *
	 * @param request the request
	 * @return the all courses
	 */
	@RequestMapping(value = "/getAllCourses", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getAllCourses(HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			List<Course> courses = courseService.getAllCourses();
			response.put(AppConstant.DATA, courses);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Data fetched successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);

		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Gets the course by id.
	 *
	 * @param courseId the course id
	 * @param request the request
	 * @return the course by id
	 */
	@RequestMapping(value = "/getCourseById/{courseId}", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getCourseById(@PathVariable("courseId") String courseId,
			HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			List<Course> course = courseService.getCourseById(courseId);
			if (course.isEmpty()) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, false);
				response.put(AppConstant.MESSAGE, "Course not found !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.NOT_FOUND);
			} else {
				response.put(AppConstant.DATA, course);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Course fetched successfully !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.OK);
			}

		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Analyse enrollment eligilibity.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/analyseEnrollmentEligilibity/{courseId}/{studentId}", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> analyseEnrollmentEligilibity(@PathVariable("courseId") String courseId,
			@PathVariable("studentId") String studentId, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			List<StudentCourseEnrollment> course = courseService.getEnrollmentByCourseIdAndStudentId(courseId,
					studentId);
			if (course.isEmpty()) {
				response.put(AppConstant.DATA, null);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Eligible for enrollment!");
				response.put(AppConstant.STATUS_CODE, HttpStatus.NOT_FOUND);
			} else {
				response.put(AppConstant.DATA, course);
				response.put(AppConstant.IS_SUCCESS, true);
				response.put(AppConstant.MESSAGE, "Course already enrolled in past !");
				response.put(AppConstant.STATUS_CODE, HttpStatus.CONFLICT);
			}

		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Gets the enrolled courses.
	 *
	 * @param studentId the student id
	 * @param request the request
	 * @return the enrolled courses
	 */
	@RequestMapping(value = "/getEnrolledCourses/{studentId}", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getEnrolledCourses(@PathVariable("studentId") String studentId,
			HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			List<StudentCourseEnrollment> enrolledCourses = courseService.getEnrolledCourses(studentId);
			List<Course> courses = new ArrayList<>();
			for (StudentCourseEnrollment enrollCourse : enrolledCourses) {
				courses.add(courseService.getCourseById(String.valueOf(enrollCourse.getCourseId())).get(0));
			}
			response.put(AppConstant.DATA, courses);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Course list fetched successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);

		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

	/**
	 * Enroll.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @param request the request
	 * @return the map
	 */
	@RequestMapping(value = "/enroll/{courseId}/{studentId}", produces = {
			MediaType.APPLICATION_JSON_VALUE }, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> enroll(@PathVariable("courseId") String courseId,
			@PathVariable("studentId") String studentId, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		try {
			int course = courseService.enroll(courseId, studentId);
			response.put(AppConstant.DATA, course);
			response.put(AppConstant.IS_SUCCESS, true);
			response.put(AppConstant.MESSAGE, "Course enrolled successfully !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.OK);

		} catch (Exception excp) {
			response.put(AppConstant.DATA, null);
			response.put(AppConstant.IS_SUCCESS, false);
			response.put(AppConstant.MESSAGE, "Something went wrong !");
			response.put(AppConstant.STATUS_CODE, HttpStatus.BAD_GATEWAY);
		}
		return response;
	}

}
