package once.tagSticker.service;

import java.util.List;

import once.tagSticker.vo.TagStickerVO;

public interface TagStickerService {

	TagStickerVO selectOneTag(String tagNo);

	List<TagStickerVO> selectTagByMemNo(int memNo);

	void insertTag(TagStickerVO tagStickerVO);
}
