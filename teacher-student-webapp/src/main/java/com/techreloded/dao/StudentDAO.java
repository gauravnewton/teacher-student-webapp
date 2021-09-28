package com.techreloded.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Student;

@Repository
public class StudentDAO {
	
	/** The named parameter jdbc template. */
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public int registerStudent(Student student) {
		student.setCreatedBy("SELF");
		student.setRoleCode("STUDENT_ROLE");
		student.setStatus("PENDING_APPROVAL");
		return namedParameterJdbcTemplate.update(
                "insert into students (firstName, lastName, email, password, phone, gender, createdOn, createdBy, updatedBy, roleCode, status) "
                + "  values(:firstName, :lastName , :email, :password, :phone, :gender, NOW(), :createdBy, :updatedBy, :roleCode, :status)",
                new BeanPropertySqlParameterSource(student));
	}

	/**
	 * Gets the student by email id.
	 *
	 * @param emailId the email id
	 * @return the student by email id
	 */
	public List<Student> getStudentByEmailId(String emailId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("emailId", emailId);
        return namedParameterJdbcTemplate.query(
                "select * from students where email = :emailId",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Student(
                        		rs.getInt("id"),
                        		rs.getString("firstname"),
                        		rs.getString("lastname"),
                        		rs.getString("email"),
                        		rs.getString("password"),
                        		rs.getString("gender"),
                        		rs.getString("phone"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby"),
                        		rs.getString("rolecode"),
                        		rs.getString("status")
                        )
        );
        
	}

	/**
	 * Login student.
	 *
	 * @param loginRequest the login request
	 * @return the list
	 */
	public List<Student> loginStudent(LoginRequest loginRequest) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("emailId", loginRequest.getEmail());
        mapSqlParameterSource.addValue("password", loginRequest.getPassword());
        return namedParameterJdbcTemplate.query(
                "select * from students where email = :emailId and password = :password",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Student(
                        		rs.getInt("id"),
                        		rs.getString("firstname"),
                        		rs.getString("lastname"),
                        		rs.getString("email"),
                        		rs.getString("password"),
                        		rs.getString("gender"),
                        		rs.getString("phone"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby"),
                        		rs.getString("rolecode"),
                        		rs.getString("status")
                        )
        );
	}

	/**
	 * Gets the student list for approval.
	 *
	 * @return the student list for approval
	 */
	public List<Student> getStudentListForApproval() {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("status", "PENDING_APPROVAL");
        return namedParameterJdbcTemplate.query(
                "select * from students where status = :status order by id desc",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Student(
                        		rs.getInt("id"),
                        		rs.getString("firstname"),
                        		rs.getString("lastname"),
                        		rs.getString("email"),
                        		rs.getString("password"),
                        		rs.getString("gender"),
                        		rs.getString("phone"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby"),
                        		rs.getString("rolecode"),
                        		rs.getString("status")
                        )
        );
	}

	/**
	 * Approve student account.
	 *
	 * @param studentId the student id
	 * @return the int
	 */
	public int approveStudentAccount(String studentId) {		
		Student student = new Student();
		student.setId(Long.valueOf(studentId));
		student.setStatus("ACTIVE");
		return namedParameterJdbcTemplate.update(
                "update students set status = :status where id = :Id",
                new BeanPropertySqlParameterSource(student));
	
	}

	/**
	 * Delete student account.
	 *
	 * @param studentId the student id
	 * @return the int
	 */
	public int deleteStudentAccount(String studentId) {
		Student student = new Student();
		student.setId(Long.valueOf(studentId));
		student.setStatus("DELETED");
		return namedParameterJdbcTemplate.update(
                "update students set status = :status where id = :Id",
                new BeanPropertySqlParameterSource(student));
	}

	/**
	 * Gets the all student list.
	 *
	 * @return the all student list
	 */
	public List<Student> getAllStudentList() {
        return namedParameterJdbcTemplate.query(
                "select * from students order by id desc",
                (rs, rowNum) ->
                        new Student(
                        		rs.getInt("id"),
                        		rs.getString("firstname"),
                        		rs.getString("lastname"),
                        		rs.getString("email"),
                        		rs.getString("password"),
                        		rs.getString("gender"),
                        		rs.getString("phone"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby"),
                        		rs.getString("rolecode"),
                        		rs.getString("status")
                        )
        );
	}

	/**
	 * Gets the student by id.
	 *
	 * @param studentId the student id
	 * @return the student by id
	 */
	public List<Student> getStudentById(String studentId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("id", studentId);
        return namedParameterJdbcTemplate.query(
                "select * from students where id = :id",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Student(
                        		rs.getInt("id"),
                        		rs.getString("firstname"),
                        		rs.getString("lastname"),
                        		rs.getString("email"),
                        		rs.getString("password"),
                        		rs.getString("gender"),
                        		rs.getString("phone"),
                        		rs.getDate("createdon"),
                        		rs.getString("createdby"),
                        		rs.getDate("updatedon"),
                        		rs.getString("updatedby"),
                        		rs.getString("rolecode"),
                        		rs.getString("status")
                        )
        );
	}

	/**
	 * Update student account.
	 *
	 * @param studentRequest the student request
	 * @param updatedBy the updated by
	 * @return the int
	 */
	public int updateStudentAccount(Student studentRequest, String updatedBy) {		
		studentRequest.setUpdatedBy(updatedBy);
		studentRequest.setUpdatedOn(new Date());
		return namedParameterJdbcTemplate.update(
                "update students set firstName = :firstName, lastName = :lastName, phone = :phone, gender = :gender,"
                + " status = :status, updatedBy = :updatedBy, updatedOn = :updatedOn where id = :Id",
                new BeanPropertySqlParameterSource(studentRequest));
	}
}
