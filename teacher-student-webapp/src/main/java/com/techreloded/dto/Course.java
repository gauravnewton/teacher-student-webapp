package com.techreloded.dto;

import java.util.Date;

/**
 * The Class Course.
 */
public class Course {
	
	/** The id. */
	private long id;
	
	/** The course name. */
	private String courseName;
	
	/** The course category. */
	private String courseCategory;
	
	/** The author. */
	private String author;
	
	/** The status. */
	private String status;
	
	/** The created on. */
	private Date createdOn;
	
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
	 * Gets the course name.
	 *
	 * @return the course name
	 */
	public String getCourseName() {
		return courseName;
	}

	/**
	 * Sets the course name.
	 *
	 * @param courseName the new course name
	 */
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	/**
	 * Gets the course category.
	 *
	 * @return the course category
	 */
	public String getCourseCategory() {
		return courseCategory;
	}

	/**
	 * Sets the course category.
	 *
	 * @param courseCategory the new course category
	 */
	public void setCourseCategory(String courseCategory) {
		this.courseCategory = courseCategory;
	}

	/**
	 * Gets the author.
	 *
	 * @return the author
	 */
	public String getAuthor() {
		return author;
	}

	/**
	 * Sets the author.
	 *
	 * @param author the new author
	 */
	public void setAuthor(String author) {
		this.author = author;
	}

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
	 * Instantiates a new course.
	 *
	 * @param id the id
	 * @param courseName the course name
	 * @param courseCategory the course category
	 * @param author the author
	 * @param status the status
	 * @param createdOn the created on
	 * @param createdBy the created by
	 * @param updatedOn the updated on
	 * @param updatedBy the updated by
	 */
	public Course(long id, String courseName, String courseCategory, String author, String status, Date createdOn,
			String createdBy, Date updatedOn, String updatedBy) {
		super();
		this.id = id;
		this.courseName = courseName;
		this.courseCategory = courseCategory;
		this.author = author;
		this.status = status;
		this.createdOn = createdOn;
		this.createdBy = createdBy;
		this.updatedOn = updatedOn;
		this.updatedBy = updatedBy;
	}

	/**
	 * Instantiates a new course.
	 */
	public Course() {
		super();
	}

	/**
	 * To string.
	 *
	 * @return the string
	 */
	@Override
	public String toString() {
		return "Course [id=" + id + ", courseName=" + courseName + ", courseCategory=" + courseCategory + ", author="
				+ author + ", status=" + status + ", createdOn=" + createdOn + ", createdBy=" + createdBy
				+ ", updatedOn=" + updatedOn + ", updatedBy=" + updatedBy + "]";
	}

}
