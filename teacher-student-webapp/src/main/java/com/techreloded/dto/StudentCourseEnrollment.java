package com.techreloded.dto;

import java.util.Date;

/**
 * The Class StudentCourseEnrollment.
 */
public class StudentCourseEnrollment {
	
	/** The id. */
	private long id;
	
	/** The course id. */
	private long courseId;
	
	/** The student id. */
	private long studentId;
	
	/** The enrolled on. */
	private Date enrolledOn;
	
	/** The created by. */
	private String createdBy;
	
	/** The updated on. */
	private Date updatedOn;
	
	/** The updated by. */
	private String updatedBy;
	
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
	 * Gets the course id.
	 *
	 * @return the course id
	 */
	public long getCourseId() {
		return courseId;
	}
	
	/**
	 * Sets the course id.
	 *
	 * @param courseId the new course id
	 */
	public void setCourseId(long courseId) {
		this.courseId = courseId;
	}
	
	/**
	 * Gets the student id.
	 *
	 * @return the student id
	 */
	public long getStudentId() {
		return studentId;
	}
	
	/**
	 * Sets the student id.
	 *
	 * @param studentId the new student id
	 */
	public void setStudentId(long studentId) {
		this.studentId = studentId;
	}
	
	/**
	 * Gets the enrolled on.
	 *
	 * @return the enrolled on
	 */
	public Date getEnrolledOn() {
		return enrolledOn;
	}
	
	/**
	 * Sets the enrolled on.
	 *
	 * @param enrolledOn the new enrolled on
	 */
	public void setEnrolledOn(Date enrolledOn) {
		this.enrolledOn = enrolledOn;
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
	 * Instantiates a new student course enrollment.
	 *
	 * @param id the id
	 * @param courseId the course id
	 * @param studentId the student id
	 * @param enrolledOn the enrolled on
	 * @param createdBy the created by
	 * @param updatedOn the updated on
	 * @param updatedBy the updated by
	 */
	public StudentCourseEnrollment(long id, long courseId, long studentId, Date enrolledOn, String createdBy,
			Date updatedOn, String updatedBy) {
		super();
		this.id = id;
		this.courseId = courseId;
		this.studentId = studentId;
		this.enrolledOn = enrolledOn;
		this.createdBy = createdBy;
		this.updatedOn = updatedOn;
		this.updatedBy = updatedBy;
	}
	
	/**
	 * Instantiates a new student course enrollment.
	 */
	public StudentCourseEnrollment() {
		super();
	}
	
	/**
	 * To string.
	 *
	 * @return the string
	 */
	@Override
	public String toString() {
		return "StudentCourseEnrollment [id=" + id + ", courseId=" + courseId + ", studentId=" + studentId
				+ ", enrolledOn=" + enrolledOn + ", createdBy=" + createdBy + ", updatedOn=" + updatedOn
				+ ", updatedBy=" + updatedBy + "]";
	}
	
	
	

}
