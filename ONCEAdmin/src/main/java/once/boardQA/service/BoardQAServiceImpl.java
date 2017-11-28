package once.boardQA.service;

import java.util.List;
import java.util.Map;

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
		return list;
	}

	@Override
	public BoardQAVO selectOneBoard(int boardNo) {
		return dao.selectOne(boardNo);
	}

	@Override
	public void insertBoard(BoardQAVO board) {
		dao.insert(board);
		
	}

	@Override
	public void modifyBoard(BoardQAVO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardQAVO> selectPage(List page) {
		List<BoardQAVO> list = dao.selectPage(page);
		return list;
	}

	@Override
	public List<BoardQAVO> selectConfirmBoard(List<String> list) {
		List<BoardQAVO> BoardList = dao.selectConfirmBoard(list);
		return BoardList;
	}

	@Override
	public List<BoardQAVO> selectSearch(Map<String, Object> boardQAMap) {
		List<BoardQAVO> Boardlist = dao.selectSearch(boardQAMap);
		return Boardlist;
	}

	@Override
	public void addCountBoardQA(int boardNo) {
		dao.addCountBoardQA(boardNo);
	}
}
