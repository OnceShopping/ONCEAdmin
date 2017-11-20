package once.notice.service;

import java.util.List;

import once.notice.vo.NoticeVO;

public interface NoticeService {
	List<NoticeVO> selectAllNotice();
	NoticeVO selectOneNotice(int noticeNo);
	void insertNotice(NoticeVO noticeVO);
	void updateNotice(NoticeVO noticeVO);
	void deleteNotice(int noticeNo);
}
