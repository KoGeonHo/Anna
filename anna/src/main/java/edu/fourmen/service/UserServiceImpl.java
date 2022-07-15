package edu.fourmen.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import edu.fourmen.dao.UserDAO;
import edu.fourmen.vo.UserVO;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDAO userDAO;
	
	private final String client_id = "32245dd905f9d9b6d898ebe61795735c";
	
	private final String redirect_uri = "http://localhost:8070/anna/user/kakaoLogin.do";
	
	@Override
	public String getClient_id() {
		return this.client_id;
	}
	
	@Override
	public String getRedirect_uri() {
		return this.redirect_uri;
	}

	
	@Override
	public int emailChk(String user_email) {

		int result = userDAO.emailChk(user_email);
		
		return result;
	}

	@Override
	public int join(UserVO vo) {

		int result = userDAO.join(vo);
		
		return result;
	}

	@Override
	public UserVO login(UserVO vo) {
		
		return userDAO.login(vo);
		
	}
	
	//토큰발급
	public HashMap<String,Object> getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        HashMap<String, Object> kakaoInfo = new HashMap<String, Object>();

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id="+client_id);  //본인이 발급받은 key
            sb.append("&redirect_uri="+redirect_uri);     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            //System.out.println("tokens : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            kakaoInfo.put("access_Token", access_Token);
            kakaoInfo.put("responseCode", responseCode);
            

            //System.out.println("access_token : " + access_Token);
            //System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return kakaoInfo;
    }

		@Override
		public HashMap<String, Object> getUserInfo(String access_Token) {
			String line = "";
	        String result = "";
	    	
	        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
	        HashMap<String, Object> userInfo = new HashMap<String, Object>();
	        String reqURL = "https://kapi.kakao.com/v2/user/me";
	        try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");

	            //요청에 필요한 Header에 포함될 내용
	            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	            int responseCode = conn.getResponseCode();
	            //System.out.println("responseCode : " + responseCode);

	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	           
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            //System.out.println("response body : " + result);

	            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	            
	            JsonElement kakaoId = element.getAsJsonObject().get("id");
	            JsonElement nickname = properties.getAsJsonObject().get("nickname");
	            JsonElement thumbnail_image = properties.getAsJsonObject().get("thumbnail_image");
	            JsonElement kakao_email = kakao_account.getAsJsonObject().get("email");
	            
	           
	            //System.out.println(kakao_account);
	            
	            userInfo.put("accessToken",access_Token);
	            userInfo.put("kakaoId",kakaoId);
	            userInfo.put("nickName",nickname);
	            userInfo.put("thumbnail_image",thumbnail_image);
	            userInfo.put("kakao_email",kakao_email);
	           
	           
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }

	        return userInfo;
		}

}
