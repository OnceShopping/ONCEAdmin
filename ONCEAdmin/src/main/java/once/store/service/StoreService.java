package once.store.service;

import java.util.List;
import javax.validation.Valid;
import once.store.vo.StoreVO;

public interface StoreService {

	StoreVO checkStoreName(String storeNo);
  
	List<StoreVO> selectFirst();

	List<StoreVO> selectSecond();

	List<StoreVO> selectThird();

	void addStore(@Valid StoreVO store);

	boolean checkStore(String storeNo);

	StoreVO selectByStoreNo(String storeNo);

	void modifyStore(@Valid StoreVO store);

	void deleteStore(String storeNo);
  
}
