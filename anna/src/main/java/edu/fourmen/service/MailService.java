package edu.fourmen.service;

public interface MailService {
	String getKey(int size);
	public String getAuthCode();
	String sendAuthMail(String user_email);
}
