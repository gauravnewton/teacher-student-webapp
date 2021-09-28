package com.techreloded.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.techreloded.dao.StudentDAO;
import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Student;

/**
 * The Class StudentService.
 */
@Service
public class StudentService {
	
	/** The student DAO. */
	@Autowired
	private StudentDAO studentDAO;
	
	/**
	 * Register student.
	 *
	 * @param student the student
	 * @return the int
	 */
	public int registerStudent(Student student) {		
		return studentDAO.registerStudent(student);
	}
	
	/**
	 * Gets the student by email id.
	 *
	 * @param emailId the email id
	 * @return the student by email id
	 */
	public List<Student> getStudentByEmailId(String emailId) {
		return studentDAO.getStudentByEmailId(emailId);
	}

	/**
	 * Login student.
	 *
	 * @param loginRequest the login request
	 * @return the list
	 */
	public List<Student> loginStudent(LoginRequest loginRequest) {
		return studentDAO.loginStudent(loginRequest);
	}

	/**
	 * Gets the student list for approval.
	 *
	 * @return the student list for approval
	 */
	public List<Student> getStudentListForApproval() {
		return studentDAO.getStudentListForApproval();
	}

	/**
	 * Approve student account.
	 *
	 * @param studentId the student id
	 * @return the int
	 */
	public int approveStudentAccount(String studentId) {
		return studentDAO.approveStudentAccount(studentId);
	}

	/**
	 * Delete student account.
	 *
	 * @param studentId the student id
	 * @return the int
	 */
	public int deleteStudentAccount(String studentId) {
		return studentDAO.deleteStudentAccount(studentId);
	}

	/**
	 * Gets the all student list.
	 *
	 * @return the all student list
	 */
	public List<Student> getAllStudentList() {
		return studentDAO.getAllStudentList();
	}

	/**
	 * Gets the student by id.
	 *
	 * @param studentId the student id
	 * @return the student by id
	 */
	public List<Student> getStudentById(String studentId) {
		return studentDAO.getStudentById(studentId);
	}

	/**
	 * Update student account.
	 *
	 * @param studentRequest the student request
	 * @param updatedBy the updated by
	 * @return the int
	 */
	public int updateStudentAccount(Student studentRequest, String updatedBy) {
		return studentDAO.updateStudentAccount(studentRequest, updatedBy);
	}
}
