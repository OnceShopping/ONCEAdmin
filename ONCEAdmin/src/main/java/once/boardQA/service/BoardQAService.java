package once.boardQA.service;

import java.util.List;
import java.util.Map;

import once.boardQA.vo.BoardQAVO;

public interface BoardQAService {
	List<BoardQAVO> selectAllBoard(String storeName);
	BoardQAVO selectOneBoard(int boardNo);
	void insertBoard(BoardQAVO board);
	void modifyBoard(BoardQAVO board);
	void deleteBoard(BoardQAVO boardQAVO);
	List<BoardQAVO> selectPage(List page);
	List<BoardQAVO> selectConfirmBoard(List<String> list);
	List<BoardQAVO> selectSearch(Map<String, Object> boardQAMap);
	void addCountBoardQA(int boardNo);
}
