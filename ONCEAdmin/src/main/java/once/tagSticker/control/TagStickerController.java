package once.tagSticker.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.manager.vo.ManagerVO;
import once.order.service.OrderService;
import once.order.vo.OrderVO;
import once.tagSticker.service.TagStickerService;
import once.tagSticker.vo.TagStickerVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;

@RequestMapping("tag")
@Controller
public class TagStickerController {
	
	@Autowired
	private TagStickerService service;
	
	@Autowired
	private CustomerService cService;
	
	@Autowired
	private OrderService oService;
	
	@Autowired
	private WarehouseService wService;
	
	@RequestMapping("searchTag")
	public @ResponseBody Map<String, Object> searchTag(@RequestParam(value="tagNo", required=false) String tagNo, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		System.out.println(loginVO.getStoreNo().substring(4));
		if(tagNo == "") {
			map.put("msg", "태그 번호를 입력해주세요");
		} else {
			
			TagStickerVO tagStickerVO = service.selectOneTag(Integer.parseInt(tagNo));
			System.out.println(tagStickerVO);

			if(tagStickerVO !=null) {
				List<OrderVO> memNoOrderList = oService.memNoOrderList(tagStickerVO.getMemNo());
				System.out.println(memNoOrderList);
				CustomerVO customerVO = cService.selectOneCustomer(tagStickerVO.getMemNo());
				
				for (int i = 0; i < memNoOrderList.size(); i++) {
					
					if(tagStickerVO.getOrderNo() == memNoOrderList.get(i).getOrderNo() && !memNoOrderList.get(i).getFloor().equals(loginVO.getStoreNo().substring(4))) {
						map.put("msg", "이 물품은 다른층에 있어야합니다 "+memNoOrderList.get(i).getFloor()+"로 보내주세요");
						break;
					} else if(tagStickerVO.getOrderNo() == memNoOrderList.get(i).getOrderNo() && !memNoOrderList.get(i).getStatus().equals("상품준비완료") ) {
						map.put("tagStickerVO", tagStickerVO);
						map.put("customerVO", customerVO);
						map.put("msg", null);
						System.out.println(customerVO);
						break;
					} else if(tagStickerVO.getOrderNo() == memNoOrderList.get(i).getOrderNo() && memNoOrderList.get(i).getStatus().equals("상품준비완료")) {
						map.put("msg", "이미 물품이 존재합니다");
						break;
					}
				}
				
			} else {
				map.put("msg", "없는 태그번호입니다");
			}
		}
		
		return map;
	}
	
	@RequestMapping("oneTotalTag")
	public @ResponseBody Map<String, Object> totalTag(@RequestParam("id")String id) {
		Map<String, Object> map = new HashMap<>();
		
		CustomerVO customerVO = cService.selectById(id);
		
		List<OrderVO> orderList = oService.memNoOrderList(customerVO.getMemNo());
		
		List<TagStickerVO> tagList = service.selectTagByMemNo(customerVO.getMemNo());
		
		WarehouseVO warehouseVO = wService.selectOneWarehouse(customerVO.getMemNo());
		
		for (int i = 0; i < orderList.size(); i++) {
			int orderNo = orderList.get(i).getOrderNo();
			String orderStatus = orderList.get(i).getStatus();
			for (int j = 0; j < tagList.size(); j++) {
				int tagOrderNo = tagList.get(j).getOrderNo();
				if(orderNo == tagOrderNo && orderStatus.equals("상품준비완료")) {
					continue;
				} else if (orderNo == tagOrderNo && !orderStatus.equals("상품준비완료")) {
					tagList.remove(j);
				}
			}
		}
		
		map.put("orderList", orderList);
		map.put("customerVO", customerVO);
		map.put("warehouseVO", warehouseVO);
		map.put("tagList", tagList);
		return map;
	}
}
