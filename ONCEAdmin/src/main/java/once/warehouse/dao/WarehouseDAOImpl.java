package once.warehouse.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WarehouseDAOImpl implements WarehouseDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
