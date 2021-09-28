package com.techreloded.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techreloded.dao.CourseDAO;
import com.techreloded.dto.Course;
import com.techreloded.dto.StudentCourseEnrollment;

/**
 * The Class CourseService.
 */
@Service
public class CourseService {
	
	/** The course DAO. */
	@Autowired
	CourseDAO courseDAO;

	/**
	 * Adds the course.
	 *
	 * @param courseRequest the course request
	 * @return the int
	 */
	public int addCourse(Course courseRequest) {
		return courseDAO.addCourse(courseRequest);
	}

	/**
	 * Gets the all courses.
	 *
	 * @return the all courses
	 */
	public List<Course> getAllCourses() {
		return courseDAO.getAllCourses();
	}

	/**
	 * Gets the course by id.
	 *
	 * @param courseId the course id
	 * @return the course by id
	 */
	public List<Course> getCourseById(String courseId) {
		return courseDAO.getCourseById(courseId);
	}

	/**
	 * Update course.
	 *
	 * @param courseRequest the course request
	 * @param updatedBy the updated by
	 * @return the int
	 */
	public int updateCourse(Course courseRequest, String updatedBy) {
		return courseDAO.updateCourse(courseRequest, updatedBy);

	}
	
	/**
	 * Gets the enrollment by course id and student id.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @return the enrollment by course id and student id
	 */
	public List<StudentCourseEnrollment> getEnrollmentByCourseIdAndStudentId(String courseId, String studentId){
		return courseDAO.getEnrollmentByCourseIdAndStudentId(courseId, studentId);
	}

	/**
	 * Enroll.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @return the int
	 */
	public int enroll(String courseId, String studentId) {
		return courseDAO.enroll(courseId, studentId);
	}

	/**
	 * Gets the enrolled courses.
	 *
	 * @param studentId the student id
	 * @return the enrolled courses
	 */
	public List<StudentCourseEnrollment> getEnrolledCourses(String studentId) {
		return courseDAO.getEnrolledCourses(studentId);
	}

	
}
