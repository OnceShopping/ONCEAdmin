package once.customer.dao;

import java.util.List;

import once.customer.vo.CustomerVO;

public interface CustomerDAO {
	
	List<CustomerVO> selectAll();

}
