package com.techreloded.dto;

import java.util.Date;

/**
 * The Class Student.
 */
public class Student {
	
	/** The id. */
	private long id;

	/** The first name. */
	private String firstName;

	/** The last name. */
	private String lastName;

	/** The email. */
	private String email;

	/** The password. */
	private String password;

	/** The gender. */
	private String gender;

	/** The phone. */
	private String phone;
	
	/** The created on. */
	private Date createdOn;
	
	/** The created by. */
	private String createdBy;
	
	/** The updated on. */
	private Date updatedOn;
	
	/** The updated by. */
	private String updatedBy;
	
	/** The role code. */
	private String roleCode;
	
	/** The status. */
	private String status;
	
	
	/**
	 * Gets the status.
	 *
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Sets the status.
	 *
	 * @param status the new status
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * Gets the role.
	 *
	 * @return the role code
	 */
	public String getRoleCode() {
		return roleCode;
	}

	/**
	 * Sets the role.
	 *
	 * @param role the new role code
	 */
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	/**
	 * Gets the created on.
	 *
	 * @return the created on
	 */
	public Date getCreatedOn() {
		return createdOn;
	}

	/**
	 * Sets the created on.
	 *
	 * @param createdOn the new created on
	 */
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	/**
	 * Gets the created by.
	 *
	 * @return the created by
	 */
	public String getCreatedBy() {
		return createdBy;
	}

	/**
	 * Sets the created by.
	 *
	 * @param createdBy the new created by
	 */
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	/**
	 * Gets the updated on.
	 *
	 * @return the updated on
	 */
	public Date getUpdatedOn() {
		return updatedOn;
	}

	/**
	 * Sets the updated on.
	 *
	 * @param updatedOn the new updated on
	 */
	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	/**
	 * Gets the updated by.
	 *
	 * @return the updated by
	 */
	public String getUpdatedBy() {
		return updatedBy;
	}

	/**
	 * Sets the updated by.
	 *
	 * @param updatedBy the new updated by
	 */
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	/**
	 * Gets the id.
	 *
	 * @return the id
	 */
	public long getId() {
		return id;
	}

	/**
	 * Sets the id.
	 *
	 * @param id the new id
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * Gets the first name.
	 *
	 * @return the first name
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Sets the first name.
	 *
	 * @param firstName the new first name
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * Gets the last name.
	 *
	 * @return the last name
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Sets the last name.
	 *
	 * @param lastName the new last name
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * Gets the email.
	 *
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Sets the email.
	 *
	 * @param email the new email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Gets the password.
	 *
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Sets the password.
	 *
	 * @param password the new password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * Gets the gender.
	 *
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * Sets the gender.
	 *
	 * @param gender the new gender
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * Gets the phone.
	 *
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * Sets the phone.
	 *
	 * @param phone the new phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * Instantiates a new student.
	 */
	public Student() {
		super();
	}

	/**
	 * Instantiates a new student.
	 *
	 * @param id the id
	 * @param firstName the first name
	 * @param lastName the last name
	 * @param email the email
	 * @param password the password
	 * @param gender the gender
	 * @param phone the phone
	 * @param createdOn the created on
	 * @param createdBy the created by
	 * @param updatedOn the updated on
	 * @param updatedBy the updated by
	 * @param role the role code
	 * @param role the status
	 */
	public Student(long id, String firstName, String lastName, String email, String password, String gender,
			String phone, Date createdOn, String createdBy, Date updatedOn, String updatedBy, String roleCode, String status) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.phone = phone;
		this.createdOn = createdOn;
		this.createdBy = createdBy;
		this.updatedOn = updatedOn;
		this.updatedBy = updatedBy;
		this.roleCode = roleCode;
		this.status = status;
	}

	/**
	 * To string.
	 *
	 * @return the string
	 */
	@Override
	public String toString() {
		return "Student [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", password=" + password + ", gender=" + gender + ", phone=" + phone + ", createdOn=" + createdOn
				+ ", createdBy=" + createdBy + ", updatedOn=" + updatedOn + ", updatedBy=" + updatedBy + ", roleCode="
				+ roleCode + ", status=" + status + "]";
	}

	

	
	

	

}
