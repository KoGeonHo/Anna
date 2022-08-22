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
		//6자리 난수 인증번호 생성
        String authKey = getKey(6);

        //인증메일 보내기
        try {
            MailUtils sendMail = new MailUtils(mailSender);
            sendMail.setSubject("안녕? 나야! 이메일 인증");
            sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
            .append("<p>아래의 인증번호를 입력하시면 인증이 완료됩니다.</p>")
            //.append("<a href='http://localhost:9070/newBoard/")
            //.append(email)
            //.append("&authKey=")
            .append(authKey)
            //.append("' target='_blenk'>이메일 인증 확인</a>")
            .toString());
            sendMail.setFrom("gjy5247@gmail.com", "관리자");
            sendMail.setTo(user_email);
            sendMail.send();
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return authKey;
	}

	
	@Override
	public String getRandomPwd() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
        int idx = 0;
        
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        
        return str;
	}
	
	@Override
	public String sendPwdMail(String user_email) {
		//6자리 난수 인증번호 생성
        String randomPwd = getRandomPwd();

        //인증메일 보내기
		
		try { 
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("안녕? 나야! 임시 비밀번호 입니다."); 
			sendMail.setText(new StringBuffer().append("<h1>[임시비밀번호]</h1>")
			.append("<p>다음 임시 비밀번호를 이용하여 로그인 하신 후 반드시 비밀번호를 변경해주세요.</p>")
			//.append("<a href='http://localhost:9070/newBoard/") 
			//.append(email)
			//.append("&authKey=") 
			.append(randomPwd)
			//.append("' target='_blenk'>이메일 인증 확인</a>") 
			.toString());
			sendMail.setFrom("gjy5247@gmail.com", "관리자"); sendMail.setTo(user_email);
			sendMail.send(); } catch (MessagingException e) { e.printStackTrace(); 
			}
			catch (UnsupportedEncodingException e) { e.printStackTrace(); 
			}
		

        return randomPwd;
	}
	
}