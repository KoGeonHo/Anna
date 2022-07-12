package edu.fourmen.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

public interface BoardService {

	
	int writeBoard(BoardVO vo);
	List<BoardVO> selectfreeboard(SearchVO svo);

	BoardVO viewBoard(int Bidx);
}
