package once.warehouse.service;

import java.util.List;

import once.warehouse.vo.WarehouseVO;

public interface WarehouseService {

	List<WarehouseVO> selectAllWarehouse(String storeNo);

	void insertWarehouse(WarehouseVO warehouseVO);

	WarehouseVO selectOneWarehouse(int memNo);

	void updateWarehouse(int memNo);

}
