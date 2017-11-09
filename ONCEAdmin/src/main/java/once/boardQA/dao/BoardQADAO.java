package once.boardQA.dao;

import java.util.List;

import once.boardQA.vo.BoardQAVO;

public interface BoardQADAO {
	List<BoardQAVO> selectAll();
	BoardQAVO selectOne(int boardNo);
	void insert(BoardQAVO board);
	void modify(BoardQAVO board);
	void delete(int boardNo);
}
