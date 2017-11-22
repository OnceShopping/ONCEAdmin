package once.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.notice.dao.NoticeDAO;
import once.notice.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO dao;

	@Override
	public List<NoticeVO> selectAllNotice() {
		List<NoticeVO> list = dao.selectAll();
		return list;
	}

	@Override
	public NoticeVO selectOneNotice(int noticeNo) {
		return dao.selectOne(noticeNo);
	}

	@Override
	public void insertNotice(NoticeVO noticeVO) {
		dao.insert(noticeVO);
	}

	@Override
	public void updateNotice(NoticeVO noticeVO) {
		dao.update(noticeVO);		
	}

	@Override
	public void deleteNotice(int noticeNo) {
		dao.delete(noticeNo);
		
	}

	@Override
	public List<NoticeVO> selectPage(List page) {
		List<NoticeVO> list = dao.selectPage(page);
		return list;
	}

	@Override
	public void addCountNotice(int noticeNo) {
		dao.addCountNotice(noticeNo);
	}

}
