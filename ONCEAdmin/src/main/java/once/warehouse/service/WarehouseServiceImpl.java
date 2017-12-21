package once.warehouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.warehouse.dao.WarehouseDAO;
import once.warehouse.vo.WarehouseVO;

@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	@Autowired
	private WarehouseDAO dao;

	@Override
	public List<WarehouseVO> selectAllWarehouse(String storeNo) {
		List<WarehouseVO> warehouseList = dao.selectAllWarehouse(storeNo);
		return warehouseList;
	}

	@Override
	public void insertWarehouse(WarehouseVO warehouseVO) {
		dao.insertWarehouse(warehouseVO);
		
	}

	@Override
	public WarehouseVO selectOneWarehouse(int memNo) {
		return dao.selectOneWarehouse(memNo);
	}

	@Override
	public void updateWarehouse(int memNo) {
		dao.updateWarehouse(memNo);
	}
}
