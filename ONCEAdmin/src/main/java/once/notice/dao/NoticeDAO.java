package once.notice.dao;

import java.util.List;

import once.notice.vo.NoticeVO;

public interface NoticeDAO {
	List<NoticeVO> selectAll();
	NoticeVO selectOne(int noticeNo);
	void insert(NoticeVO noticeVO);
	void update(NoticeVO noticeVO);
	void delete(int noticeNo);
	List<NoticeVO> selectPage(List page);
	void addCountNotice(int noticeNo);
}
