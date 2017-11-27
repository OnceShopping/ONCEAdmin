package once.customer.service;

import java.util.List;

import once.customer.vo.CustomerVO;

public interface CustomerService {

	List<CustomerVO> selectAllBoard();
	void deleteBoard(int memNo);
	List<CustomerVO> searchBoard(String customerId);
	List<CustomerVO> selectPage(List page);
}
