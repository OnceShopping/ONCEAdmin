package once.boardQA.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.boardQA.vo.BoardQAVO;

@Repository
public class BoardQADAOImpl implements BoardQADAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<BoardQAVO> selectAll() {
		List<BoardQAVO> list = sqlSession.selectList("once.boardQA.dao.BoardQADAO.selectAllBoard");
		return list;
	}

	@Override
	public BoardQAVO selectOne(int boardNo) {
		return sqlSession.selectOne("once.boardQA.dao.BoardQADAO.selectOneBoard", boardNo);
	}

	@Override
	public void insert(BoardQAVO board) {
		sqlSession.insert("once.boardQA.dao.BoardQADAO.insertBoard", board);
	}

	@Override
	public void modify(BoardQAVO board) {
		sqlSession.update("once.boardQA.dao.BoardQADAO.modifyBoard", board);
	}

	@Override
	public void delete(int boardNo) {
		sqlSession.delete("once.boardQA.dao.BoardQADAO.deleteBoard", boardNo);		
	}

	@Override
	public List<BoardQAVO> selectPage(List page) {
		List<BoardQAVO> list = sqlSession.selectList("once.boardQA.dao.BoardQADAO.selectPage", page);
		return list;
	}

	@Override
	public List<BoardQAVO> selectConfirmBoard(List<String> list) {
		List<BoardQAVO> Boardlist = sqlSession.selectList("once.boardQA.dao.BoardQADAO.selectConfirmBoard", list);
		return Boardlist;
	}

	@Override
	public List<BoardQAVO> selectSearch(Map<String, Object> boardQAMap) {
				
		List<BoardQAVO> Boardlist = sqlSession.selectList("once.boardQA.dao.BoardQADAO.selectSearch", boardQAMap);
		return Boardlist;
	}

	@Override
	public void addCountBoardQA(int boardNo) {
		sqlSession.update("once.boardQA.dao.BoardQADAO.addCountBoardQA", boardNo);
	}
	
}
