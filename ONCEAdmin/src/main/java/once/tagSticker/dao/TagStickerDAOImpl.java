package once.tagSticker.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TagStickerDAOImpl implements TagStickerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
}
