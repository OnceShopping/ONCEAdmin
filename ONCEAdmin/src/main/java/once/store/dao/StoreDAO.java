package once.store.dao;

import java.util.List;

import javax.validation.Valid;

import once.store.vo.StoreVO;

public interface StoreDAO {

	List<StoreVO> selectFirst();

	List<StoreVO> selectSecond();

	List<StoreVO> selectThird();

	void addStore(@Valid StoreVO store);

	boolean checkStore(String storeNo);

	StoreVO selectByStoreNo(String storeNo);

	void modifyStore(@Valid StoreVO store);

	void deleteStore(String storeNo);

}
