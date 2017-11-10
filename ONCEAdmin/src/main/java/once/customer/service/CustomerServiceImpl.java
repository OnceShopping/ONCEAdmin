package once.customer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.customer.dao.CustomerDAO;
import once.customer.vo.CustomerVO;

@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerDAO dao;
	
	
	@Override
	public List<CustomerVO> selectAllBoard() {
		
		List<CustomerVO> list = dao.selectAll();
		
		return list;
	}
	
}
