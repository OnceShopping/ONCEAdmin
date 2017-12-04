package once.store.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.store.vo.StoreVO;

@Repository
public class StoreDAOImpl implements StoreDAO {

	@Autowired
	private SqlSessionTemplate sqlSesssion;

	@Override
	public StoreVO checkStore(String storeNo) {
		return sqlSesssion.selectOne("once.store.dao.StoreDAO.checkStore",storeNo);
	}
}
