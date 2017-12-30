package once.tagSticker.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.tagSticker.vo.TagStickerVO;

@Repository
public class TagStickerDAOImpl implements TagStickerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public TagStickerVO selectOneTag(String tagNo) {
		return sqlSession.selectOne("once.tagSticker.dao.TagStickerDAO.selectOneTag", tagNo);
	}
	
	@Override
	public List<TagStickerVO> selectTagByMemNo(int memNo) {
		List<TagStickerVO> tagList = sqlSession.selectList("once.tagSticker.dao.TagStickerDAO.selectTagByMemNo", memNo);
		return tagList;
	}

	@Override
	public void insertTag(TagStickerVO tagStickerVO) {
		sqlSession.insert("once.tagSticker.dao.TagStickerDAO.insertTag", tagStickerVO);
	}
	
}
