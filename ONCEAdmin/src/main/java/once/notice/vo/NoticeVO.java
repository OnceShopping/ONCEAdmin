package once.notice.vo;

import lombok.Data;

@Data
public class NoticeVO {

	private int noticeNo;
	
	private String title;
	private String content;
	
	private int viewCnt;
	
	private String imgOriName;
	private String imgSaveName;
	private int imgSize;
	
	private int regDate;
	
}
