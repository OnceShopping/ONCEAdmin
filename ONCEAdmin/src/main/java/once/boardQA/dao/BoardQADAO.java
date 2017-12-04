package once.boardQA.dao;

import java.util.List;
import java.util.Map;

import once.boardQA.vo.BoardQAVO;

public interface BoardQADAO {
	List<BoardQAVO> selectAll(String storeName);
	BoardQAVO selectOne(int boardNo);
	void insert(BoardQAVO board);
	void modify(BoardQAVO board);
	void delete(BoardQAVO boardQAVO);
	List<BoardQAVO> selectPage(List page);
	List<BoardQAVO> selectConfirmBoard(List<String> list);
	List<BoardQAVO> selectSearch(Map<String, Object> boardQAMap);
	void addCountBoardQA(int boardNo);
}
