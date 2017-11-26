package once.manager.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.manager.dao.ManagerDAO;
import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

@Service
public class ManagerServiceImpl implements ManagerService{

	@Autowired
	private ManagerDAO dao;

	@Override
	public ManagerVO login(ManagerVO manager) {
			System.out.println("service 실행");
			return dao.login(manager);
	}
	
	@Override
	public boolean checkPassword(String managerId, String password) {
		return dao.checkPassword(managerId, password);
	}

	@Override
	public ManagerVO selectById(String managerId) {
		return dao.selectById(managerId);
	}

	@Override
	public StoreVO selectByNo(String storeNo) {
		return dao.selectByNo(storeNo);
	}

	@Override
	public void modifyManager(String managerId, String password, String telephone) {
		dao.modifyManager(managerId, password, telephone);
	}
	
	//매니저 전체 조회
	@Override
	public List<ManagerVO> selectAll() {
		
		List<ManagerVO> list = dao.selectAll();
		
		return list;
	}
	
	//매니저 삭제
	@Override
	public void delete(String managerId) {	
		dao.delete(managerId);
	}
	
	//매니저 수정
	@Override
	public void update(String managerId, String telephone) {	
		dao.update(managerId, telephone);
	}
	
	//매니저 추가
	@Override
	public void add(ManagerVO manager) {		
		dao.insert(manager);
	}
	
	//매니저 검색
	@Override
	public List<ManagerVO> search(ManagerVO manager) {
		
		List<ManagerVO> list = dao.search(manager);
		
		return list;
	}
	
	//ID 중복 체크
	public boolean checkId(String managerId) {
		return dao.checkId(managerId);
	}
	
	//페이징
	@Override
	public List<ManagerVO> selectPage(List page) {
		
		List<ManagerVO> list = dao.selectPage(page);
		
		return list;
	}
}
 