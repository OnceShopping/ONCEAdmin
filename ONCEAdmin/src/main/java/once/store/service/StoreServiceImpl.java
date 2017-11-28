package once.store.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.store.dao.StoreDAO;
import once.store.vo.StoreVO;

@Service
public class StoreServiceImpl implements StoreService {
	
	@Autowired
	private StoreDAO dao;

	@Override
	public List<StoreVO> selectFirst() {
		List<StoreVO> list = dao.selectFirst();
		return list;
	}

	@Override
	public List<StoreVO> selectSecond() {
		List<StoreVO> list = dao.selectSecond();
		return list;
	}

	@Override
	public List<StoreVO> selectThird() {
		List<StoreVO> list = dao.selectThird();
		return list;
	}

	@Override
	public void addStore(@Valid StoreVO store) {
		dao.addStore(store);
	}

	@Override
	public boolean checkStore(String storeNo) {
		return dao.checkStore(storeNo);
	}

	@Override
	public StoreVO selectByStoreNo(String storeNo) {
		return dao.selectByStoreNo(storeNo);
	}

	@Override
	public void modifyStore(@Valid StoreVO store) {
		dao.modifyStore(store);
	}

	@Override
	public void deleteStore(String storeNo) {
		dao.deleteStore(storeNo);
	}
	
}
