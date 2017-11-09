package once.boardQA.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.boardQA.dao.BoardQADAO;
import once.boardQA.vo.BoardQAVO;

@Service
public class BoardQAServiceImpl implements BoardQAService {
	
	@Autowired
	private BoardQADAO dao;

	@Override
	public List<BoardQAVO> selectAllBoard() {
		List<BoardQAVO> list = dao.selectAll();
		return null;
	}

	@Override
	public BoardQAVO selectOneBoard(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertBoard(BoardQAVO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void modifyBoard(BoardQAVO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		
	}
}
