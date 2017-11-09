package once.boardQA.service;

import java.util.List;

import once.boardQA.vo.BoardQAVO;

public interface BoardQAService {
	List<BoardQAVO> selectAllBoard();
	BoardQAVO selectOneBoard(int boardNo);
	void insertBoard(BoardQAVO board);
	void modifyBoard(BoardQAVO board);
	void deleteBoard(int boardNo);
}
