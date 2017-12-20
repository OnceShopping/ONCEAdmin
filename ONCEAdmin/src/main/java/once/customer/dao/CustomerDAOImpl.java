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
	public List<CustomerVO> search(CustomerVO customer) {
		
		List<CustomerVO> list = sqlSession.selectList("once.customer.dao.CustomerDAO.search", customer);
		
		return list;
	}
	
	@Override
	public List<CustomerVO> selectPage(List page) {
		
		List<CustomerVO> list = sqlSession.selectList("once.customer.dao.CustomerDAO.selectPage", page);
		return list;
	}

	@Override
	public CustomerVO getCustomerInfo(int memNo) {
		return sqlSession.selectOne("once.customer.dao.CustomerDAO.getInfo", memNo);
	}
}
