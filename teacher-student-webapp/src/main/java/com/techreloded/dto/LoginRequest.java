package com.techreloded.dto;

/**
 * The Class LoginRequest.
 */
public class LoginRequest {

	/** The email. */
	private String email;

	/** The password. */
	private String password;

	/**
	 * Gets the email id.
	 *
	 * @return the email id
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Sets the email.
	 *
	 * @param emailId the new email 
	 */
	public void setEmailId(String email) {
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
	 * Instantiates a new login request.
	 *
	 * @param emailId the email 
	 * @param password the password
	 */
	public LoginRequest(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}

	/**
	 * Instantiates a new login request.
	 */
	public LoginRequest() {
		super();
	}

	/**
	 * To string.
	 *
	 * @return the string
	 */
	@Override
	public String toString() {
		return "LoginRequest [email=" + email + ", password=" + password + "]";
	}

}
