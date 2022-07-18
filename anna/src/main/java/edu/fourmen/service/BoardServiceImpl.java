package edu.fourmen.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import edu.fourmen.dao.BoardDAO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.SearchVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDao;
	
	
	@Override
	public int writeBoard(BoardVO vo) {
		
		return boardDao.writeBoard(vo);
	}


	@Override
	public List<BoardVO> selectfreeboard(SearchVO svo) {
		
		return boardDao.selectfreeboard(svo);
	}

	


	@Override
	public BoardVO viewBoard(int Bidx) {
		
		return boardDao.viewBoard(Bidx);
	}

}
