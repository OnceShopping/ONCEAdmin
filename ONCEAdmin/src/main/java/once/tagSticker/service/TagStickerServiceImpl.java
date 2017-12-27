package once.tagSticker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.tagSticker.dao.TagStickerDAO;
import once.tagSticker.vo.TagStickerVO;

@Service
public class TagStickerServiceImpl implements TagStickerService {
	
	@Autowired
	private TagStickerDAO dao;

	@Override
	public TagStickerVO selectOneTag(String tagNo) {
		return dao.selectOneTag(tagNo);
	}

	@Override
	public List<TagStickerVO> selectTagByMemNo(int memNo) {
		List<TagStickerVO> tagList = dao.selectTagByMemNo(memNo);
		return tagList;
	}

	@Override
	public void insertTag(TagStickerVO tagStickerVO) {
		dao.insertTag(tagStickerVO);
	}

}
