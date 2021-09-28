package com.techreloded.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.techreloded.dto.Course;
import com.techreloded.dto.StudentCourseEnrollment;

@Repository
public class CourseDAO {
	
	/** The named parameter jdbc template. */
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	/**
	 * Adds the course.
	 *
	 * @param courseRequest the course request
	 * @return the int
	 */
	public int addCourse(Course courseRequest) {
		courseRequest.setCreatedBy("SELF");
		courseRequest.setStatus("ACTIVE");
		courseRequest.setCreatedOn(new Date());
		return namedParameterJdbcTemplate.update(
                "insert into courses (courseName, courseCategory, author, status, createdOn, createdBy) "
                + "  values(:courseName, :courseCategory , :author, :status, :createdOn, :createdBy)",
                new BeanPropertySqlParameterSource(courseRequest));
	}
	
	/**
	 * Gets the all courses.
	 *
	 * @return the all courses
	 */
	public List<Course> getAllCourses() {
		return namedParameterJdbcTemplate.query(
                "select * from courses order by id desc",
                (rs, rowNum) ->
                        new Course(
                        		rs.getInt("id"),
                        		rs.getString("coursename"),
                        		rs.getString("coursecategory"),
                        		rs.getString("author"),
                        		rs.getString("status"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby")
                        )
        );
	}

	/**
	 * Gets the course by id.
	 *
	 * @param courseId the course id
	 * @return the course by id
	 */
	public List<Course> getCourseById(String courseId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("id", courseId);
        return namedParameterJdbcTemplate.query(
                "select * from courses where id = :id",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Course(
                        		rs.getInt("id"),
                        		rs.getString("coursename"),
                        		rs.getString("coursecategory"),
                        		rs.getString("author"),
                        		rs.getString("status"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby")
                        )
        );
        
	}

	/**
	 * Update course.
	 *
	 * @param courseRequest the course request
	 * @param updatedBy the updated by
	 * @return the int
	 */
	public int updateCourse(Course courseRequest, String updatedBy) {
		courseRequest.setUpdatedOn(new Date());
		courseRequest.setUpdatedBy(updatedBy);
		courseRequest.setCreatedOn(new Date());
		return namedParameterJdbcTemplate.update(
                "update courses set courseName = :courseName, courseCategory = :courseCategory,"
                + " author = :author, status = :status, updatedOn = :updatedOn, updatedBy = :updatedBy where id = :id ",
                new BeanPropertySqlParameterSource(courseRequest));
	}
	

	/**
	 * Gets the enrollment by course id and student id.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @return the enrollment by course id and student id
	 */
	public List<StudentCourseEnrollment> getEnrollmentByCourseIdAndStudentId(String courseId, String studentId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("studentId", studentId);
        mapSqlParameterSource.addValue("courseId", courseId);
        return namedParameterJdbcTemplate.query(
                "select * from studentcourseenrollments where studentId = :studentId and courseId  = :courseId",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new StudentCourseEnrollment(
                        		rs.getInt("id"),
                        		rs.getInt("courseid"),
                        		rs.getInt("studentid"),
                        		rs.getDate("enrolledon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby")
                        )
        );
	}

	/**
	 * Enroll.
	 *
	 * @param courseId the course id
	 * @param studentId the student id
	 * @return the int
	 */
	public int enroll(String courseId, String studentId) {
		StudentCourseEnrollment enrollmentRequest = new StudentCourseEnrollment();
		enrollmentRequest.setCreatedBy("SELF");
		enrollmentRequest.setCourseId(Long.valueOf(courseId));
		enrollmentRequest.setStudentId(Long.valueOf(studentId));
		enrollmentRequest.setEnrolledOn(new Date());
		return namedParameterJdbcTemplate.update(
                "insert into studentcourseenrollments (courseId, studentId, enrolledOn, createdBy) "
                + "  values(:courseId, :studentId, :enrolledOn, :createdBy)",
                new BeanPropertySqlParameterSource(enrollmentRequest));
	}

	/**
	 * Gets the enrolled courses.
	 *
	 * @param studentId the student id
	 * @return the enrolled courses
	 */
	public List<StudentCourseEnrollment> getEnrolledCourses(String studentId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("studentId", studentId);
        return namedParameterJdbcTemplate.query(
                "select * from studentcourseenrollments where studentId = :studentId",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new StudentCourseEnrollment(
                        		rs.getInt("id"),
                        		rs.getInt("courseid"),
                        		rs.getInt("studentid"),
                        		rs.getDate("enrolledon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby")
                        )
        );
	}

}







