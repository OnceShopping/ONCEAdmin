package once.customer.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.customer.vo.CustomerVO;

@Repository
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<CustomerVO> selectAll() {
		
		List<CustomerVO> list = sqlSession.selectList("once.customer.dao.CustomerDAO.selectAll");
		
		return list;
	}
	
	@Override
	public void delete(int memNo) {
		
		sqlSession.selectList("once.customer.dao.CustomerDAO.delete", memNo);
	
	}
	
	@Override
	public List<CustomerVO> search(String id) {
		
		List<CustomerVO> list = sqlSession.selectList("once.customer.dao.CustomerDAO.search", id);
		
		return list;
	}
	
}
