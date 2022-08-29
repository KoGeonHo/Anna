package edu.fourmen.service;

import java.util.HashMap;
import java.util.List;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.ReViewVO;
import edu.fourmen.vo.UserVO;

public interface UserService {
	int emailChk(String user_email);
	int join(UserVO vo);
	UserVO login(UserVO vo);
	String getClient_id();
	String getRedirect_uri();
	HashMap<String, Object> getAccessToken(String code);
	HashMap<String, Object> getKakaoUserInfo(String access_Token);
	void updateKakaoAuthKey(UserVO vo);
	UserVO getUserInfo(int uidx);
	int userInfoMod(UserVO vo);
	int updateInterested(UserVO vo);
	void kakaoLogout(String access_Token);
	int updateLocation(UserVO vo);
	String getLocation(int uidx);
	List<BoardItemVO> getInterestedItem(List<String> keyWord,int uidx);
	List<UserVO> neighborList(int uidx);
	List<BoardVO> myTownCommunityList(String location_auth);
	UserVO keepLogin(int uidx);
	List<ChatMessageVO> getChatList(int uidx);
	List<ChatMessageVO> getChatViewList(ChatMessageVO cmvo);
	void chatSetRead(List<Integer> listForSetRead);
	ChatMessageVO getMessageNoRead(ChatMessageVO cmvo);
	List<BoardItemVO> myBoardItemList(int uidx);
	List<BoardItemVO> getWishList(int uidx);
	List<BoardVO> getMyCommunity(int uidx);
	int updatePwd(UserVO vo);
	int updateRandomPwd(UserVO vo);
	List<ChatMessageVO> getSellChatList(int uidx);
	List<ChatMessageVO> getBuyChatList(int uidx);
	void insertReView(ReViewVO vo);
	ReViewVO getMyReview(ReViewVO vo);
	ReViewVO getMyReviewForMe(ReViewVO vo);
	void updateProfile(UserVO vo);
	int chkAlarm(int uidx);
	int chkSellNewMessage(int uidx);
	int chkBuyNewMessage(int uidx);
	void updateReview(ReViewVO vo);
	
}
