package com.techreloded.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.techreloded.dto.LoginRequest;
import com.techreloded.dto.Teacher;

@Repository
public class TeacherDAO {

	/** The named parameter jdbc template. */
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	/**
	 * Register teacher.
	 *
	 * @param teacher the teacher
	 * @return the int
	 */
	public int registerTeacher(Teacher teacher) {
		teacher.setCreatedBy("SELF");
		teacher.setRoleCode("TEACHER_ROLE");
		teacher.setStatus("ACTIVE");
		return namedParameterJdbcTemplate.update(
                "insert into teachers (firstName, lastName, email, password, phone, gender, createdOn, createdBy, updatedBy, roleCode, status) "
                + "  values(:firstName, :lastName , :email, :password, :phone, :gender, NOW(), :createdBy, :updatedBy, :roleCode, :status)",
                new BeanPropertySqlParameterSource(teacher));
	}

	/**
	 * Gets the teacher by email id.
	 *
	 * @param emailId the email id
	 * @return the teacher by email id
	 */
	public List<Teacher> getTeacherByEmailId(String emailId) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("emailId", emailId);
        return namedParameterJdbcTemplate.query(
                "select * from teachers where email = :emailId",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Teacher(
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
	 * Login teacher.
	 *
	 * @param loginRequest the login request
	 * @return the list
	 */
	public List<Teacher> loginTeacher(LoginRequest loginRequest) {
		MapSqlParameterSource mapSqlParameterSource = new MapSqlParameterSource();
        mapSqlParameterSource.addValue("emailId", loginRequest.getEmail());
        mapSqlParameterSource.addValue("password", loginRequest.getPassword());
        return namedParameterJdbcTemplate.query(
                "select * from teachers where email = :emailId and password = :password",
                mapSqlParameterSource,
                (rs, rowNum) ->
                        new Teacher(
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

}

