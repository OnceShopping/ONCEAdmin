package once.notice.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.notice.vo.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<NoticeVO> selectAll() {
		List<NoticeVO> list = sqlSession.selectList("once.notice.dao.NoticeDAO.selectAllNotice");	
		return list;
	}

	@Override
	public NoticeVO selectOne(int noticeNo) {
		return sqlSession.selectOne("once.notice.dao.NoticeDAO.selectOneNotice", noticeNo);
	}

	@Override
	public void insert(NoticeVO noticeVO) {
		sqlSession.insert("once.notice.dao.NoticeDAO.insertNotice", noticeVO);
	}

	@Override
	public void update(NoticeVO noticeVO) {
		sqlSession.update("once.notice.dao.NoticeDAO.updateNotice", noticeVO);
		
	}

	@Override
	public void delete(int noticeNo) {
		sqlSession.delete("once.notice.dao.NoticeDAO.deleteNotice", noticeNo);
	}
}
