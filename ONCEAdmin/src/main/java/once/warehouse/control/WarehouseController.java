package once.warehouse.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.order.service.OrderService;
import once.order.vo.OrderVO;
import once.tagSticker.service.TagStickerService;
import once.tagSticker.vo.TagStickerVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;

@RequestMapping("warehouse")
@Controller
public class WarehouseController {

	@Autowired
	private WarehouseService service;
	
	@Autowired
	private CustomerService cService;
	
	@Autowired
	private TagStickerService tService;
	
	@Autowired
	private OrderService oService;
	
	@RequestMapping("insert")
	public @ResponseBody Map<String, Object> insertWarehouse(@RequestParam(value="warehouseId")String warehouseId, 
			@RequestParam("TagNo")String tagNo, @RequestParam("memNo")int memNo, @RequestParam("floor")String floor, @RequestParam("floorWareNo")int floorWareNo) {
		Map<String, Object> map = new HashMap<>();
		
		TagStickerVO tagStickerVO = tService.selectOneTag(tagNo);
		
		CustomerVO customerVO = cService.selectOneCustomer(memNo);
		
		WarehouseVO warehouseVO = service.selectOneWarehouse(memNo);
		
		List<OrderVO> orderList = oService.memNoOrderList(memNo);
		
		
		
		int totalCount = orderList.size();
		System.out.println("warehouseVO" +warehouseVO);

				if(warehouseVO != null) {
					System.out.println("업데이트 추가 : "+warehouseId);
					service.updateWarehouse(memNo);
					oService.updateStatusFin(tagStickerVO.getOrderNo());
					map.put("orderNo", tagStickerVO.getOrderNo());
					map.put("id", customerVO.getId());
					map.put("tagNo", tagNo);
					map.put("count", warehouseVO.getCount()+1);
					map.put("totalCount", totalCount);
				} else {
					System.out.println("새로 추가 : "+warehouseId);
					WarehouseVO newWarehouseVO = new WarehouseVO(1, floor, memNo, floorWareNo);
					service.insertWarehouse(newWarehouseVO);
					oService.updateStatusFin(tagStickerVO.getOrderNo());
					map.put("orderNo", tagStickerVO.getOrderNo());
					map.put("id", customerVO.getId());
					map.put("tagNo", tagNo);
					map.put("count", 1);
					map.put("totalCount", totalCount);
				}
		
		System.out.println(customerVO);

		return map;
	}
}
