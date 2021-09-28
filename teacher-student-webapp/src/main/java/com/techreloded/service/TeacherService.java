package com.techreloded.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techreloded.dao.TeacherDAO;
import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Teacher;

/**
 * The Class TeacherService.
 */
@Service
public class TeacherService {
	
	/** The teacher DAO. */
	@Autowired
	private TeacherDAO teacherDAO;

	/**
	 * Gets the teacher by email id.
	 *
	 * @param email the email
	 * @return the teacher by email id
	 */
	public List<Teacher> getTeacherByEmailId(String email) {
		return teacherDAO.getTeacherByEmailId(email);
	}

	/**
	 * Register teacher.
	 *
	 * @param teacherRequest the teacher request
	 * @return the int
	 */
	public int registerTeacher(Teacher teacherRequest) {
		return teacherDAO.registerTeacher(teacherRequest);
	}
	
	/**
	 * Login teacher.
	 *
	 * @param loginRequest the login request
	 * @return the list
	 */
	public List<Teacher> loginTeacher(LoginRequest loginRequest){
		return teacherDAO.loginTeacher(loginRequest);
	}
	
	
}

