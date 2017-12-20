package once.customer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.customer.dao.CustomerDAO;
import once.customer.vo.CustomerVO;
import once.manager.vo.ManagerVO;

@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerDAO dao;
	
	//전체 출력
	@Override
	public List<CustomerVO> selectAllBoard() {
		
		List<CustomerVO> list = dao.selectAll();
		
		return list;
	}
	
	//삭제
	@Override
	public void deleteBoard(int memNo) {
		dao.delete(memNo);
	}
	
	//검색
	@Override
	public List<CustomerVO> searchBoard(CustomerVO customer) {
		
		List<CustomerVO> list = dao.search(customer);
		
		return list;
	}
	
	//페이징
	@Override
	public List<CustomerVO> selectPage(List page) {

		List<CustomerVO> list = dao.selectPage(page);
		
		return list;
	}

	// customer 정보 얻기
	@Override
	public CustomerVO getCustomerInfo(int memNo) {
		return dao.getCustomerInfo(memNo);
	}
}
