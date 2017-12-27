package once.tagSticker.dao;

import java.util.List;

import once.tagSticker.vo.TagStickerVO;

public interface TagStickerDAO {

	TagStickerVO selectOneTag(String tagNo);

	List<TagStickerVO> selectTagByMemNo(int memNo);

	void insertTag(TagStickerVO tagStickerVO);
}
