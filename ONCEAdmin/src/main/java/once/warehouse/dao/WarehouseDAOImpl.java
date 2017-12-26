package once.warehouse.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.warehouse.vo.WarehouseVO;

@Repository
public class WarehouseDAOImpl implements WarehouseDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<WarehouseVO> selectAllWarehouse(String storeNo) {
		List<WarehouseVO> warehouseList = sqlSession.selectList("once.warehouse.dao.WarehouseDAO.selectAllWarehouse", storeNo);
		return warehouseList;
	}

	@Override
	public void insertWarehouse(WarehouseVO warehouseVO) {
		sqlSession.insert("once.warehouse.dao.WarehouseDAO.insertWarehouse", warehouseVO);
	}

	@Override
	public WarehouseVO selectOneWarehouse(int memNo) {
		return sqlSession.selectOne("once.warehouse.dao.WarehouseDAO.selectOneWarehouse", memNo);
	}

	@Override
	public void updateWarehouse(int memNo) {
		sqlSession.update("once.warehouse.dao.WarehouseDAO.updateWarehouse", memNo);
	}

	@Override
	public void subtractWarehouse(Map<String, Object> map) {
		sqlSession.update("once.warehouse.dao.WarehouseDAO.subtractWarehouse", map);
	}

	@Override
	public void deleteWarehouse(int memNo) {
		sqlSession.delete("once.warehouse.dao.WarehouseDAO.deleteWarehouse", memNo);
	}
}
