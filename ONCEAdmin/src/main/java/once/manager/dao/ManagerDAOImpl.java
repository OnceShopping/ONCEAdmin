package once.manager.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import once.manager.vo.ManagerVO;
import once.store.vo.StoreVO;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * manger 로그인
	 * @param manager
	 * @return managerVO
	 */
	@Override
	public ManagerVO login(ManagerVO manager) {
		ManagerVO managerVO = sqlSession.selectOne("once.manager.dao.ManagerDAO.login", manager);
		System.out.println("loginDao 성공");
		System.out.println(managerVO);
		return managerVO;
	}
	
	@Override
	public boolean checkPassword(String managerId, String password) {
		boolean result = false;
		
        Map<String, String> map = new HashMap<String, String>();
        map.put("managerId", managerId);
        map.put("password", password);
        
        int count = sqlSession.selectOne("once.manager.dao.ManagerDAO.checkPassword", map);
        if(count == 1) {
        	result= true;
        }
        
        return result;
	}

	@Override
	public ManagerVO selectById(String managerId) {
		return sqlSession.selectOne("once.manager.dao.ManagerDAO.selectOneManager", managerId);
	}

	@Override
	public StoreVO selectByNo(String storeNo) {
		return sqlSession.selectOne("once.manager.dao.ManagerDAO.selectByNo", storeNo);
	}

	@Override
	public void modifyManager(String managerId, String password, String telephone) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("managerId", managerId);
		map.put("password", password);
		map.put("telephone", telephone);
		
		sqlSession.update("once.manager.dao.ManagerDAO.modifyManager", map);
	}
	
	//매니저 관리 전체 조회
	@Override
	public List<ManagerVO> selectAll() {
		
		List<ManagerVO> list = sqlSession.selectList("once.manager.dao.ManagerDAO.selectAll");
		
		return list;
	}
	
	//매니저 삭제
	@Override
	public void delete(int staffNo) {
		sqlSession.delete("once.manager.dao.ManagerDAO.delete", staffNo);
	}
}
