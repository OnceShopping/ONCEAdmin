package once.warehouse.dao;

import java.util.List;

import once.warehouse.vo.WarehouseVO;

public interface WarehouseDAO {

	List<WarehouseVO> selectAllWarehouse(String storeNo);

	void insertWarehouse(WarehouseVO warehouseVO);

	WarehouseVO selectOneWarehouse(int memNo);

	void updateWarehouse(int memNo);


}
