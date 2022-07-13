package edu.fourmen.service;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;


@Service
public class MailServiceImpl implements MailService {


	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int size;
	
	
	@Override
	public String getKey(int size) {
		this.size = size;
        return getAuthCode();
	}

	@Override
	public String getAuthCode() {
		Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        int num = 0;

        while(buffer.length() < size) {
            num = random.nextInt(10);
            buffer.append(num);
        }

        return buffer.toString();
	}

	@Override
	public String sendAuthMail(String user_email) {
		//6�ڸ� ���� ������ȣ ����
        String authKey = getKey(6);

        //�������� ������
        try {
            MailUtils sendMail = new MailUtils(mailSender);
            sendMail.setSubject("ȸ������ �̸��� ����");
            sendMail.setText(new StringBuffer().append("<h1>[�̸��� ����]</h1>")
            .append("<p>����Ʈ�� �Ʒ��� ������ȣ�� �Է��Ͻø� ������ �Ϸ�˴ϴ�.</p>")
            //.append("<a href='http://localhost:9070/newBoard/")
            //.append(email)
            //.append("&authKey=")
            .append(authKey)
            //.append("' target='_blenk'>�̸��� ���� Ȯ��</a>")
            .toString());
            sendMail.setFrom("gjy5247@gmail.com", "������");
            sendMail.setTo(user_email);
            sendMail.send();
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

          return authKey;
	}

}
