package once.customer.dao;

import java.util.List;

import once.customer.vo.CustomerVO;

public interface CustomerDAO {
	
	List<CustomerVO> selectAll();
	void delete(int memNo);
	List<CustomerVO> search(CustomerVO customer);
	List<CustomerVO> selectPage(List page);
	CustomerVO selectOneCustomer(int memNo);
	CustomerVO selectById(String id);
	CustomerVO getCustomerInfo(int memNo);
}
