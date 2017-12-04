 package once.store.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

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
		return sqlSesssion.selectOne("once.store.dao.StoreDAO.checkStoreName",storeNo);
	}

	private SqlSessionTemplate sqlSession;

	@Override
	public List<StoreVO> selectFirst() {
		List<StoreVO> list = sqlSession.selectList("once.store.dao.StoreDAO.selectFirst");
		return list;
	}

	@Override
	public List<StoreVO> selectSecond() {
		List<StoreVO> list = sqlSession.selectList("once.store.dao.StoreDAO.selectSecond");
		return list;
	}

	@Override
	public List<StoreVO> selectThird() {
		List<StoreVO> list = sqlSession.selectList("once.store.dao.StoreDAO.selectThird");
		return list;
	}

	@Override
	public void addStore(@Valid StoreVO store) {
		sqlSession.insert("once.store.dao.StoreDAO.addStore", store);
	}

	@Override
	public boolean checkStore(String storeNo) {
		boolean result = false;
		int count = sqlSession.selectOne("once.store.dao.StoreDAO.checkStore", storeNo);
        
		if(count == 1) {
        	result= true;
        }
		
		return result;
	}

	@Override
	public StoreVO selectByStoreNo(String storeNo) {
		return sqlSession.selectOne("once.store.dao.StoreDAO.selectByStoreNo", storeNo);
	}

	@Override
	public void modifyStore(@Valid StoreVO store) {
		sqlSession.update("once.store.dao.StoreDAO.modifyStore", store);
	}

	@Override
	public void deleteStore(String storeNo) {
		sqlSession.delete("once.store.dao.StoreDAO.deleteStore", storeNo);
	}
}
