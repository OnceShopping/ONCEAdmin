package once.order.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.item.service.ItemService;
import once.item.vo.ItemContentsVO;
import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;
import once.order.service.OrderService;
import once.order.vo.OrderDetailVO;
import once.order.vo.OrderVO;
import once.store.service.StoreService;
import once.store.vo.StoreVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private CustomerService cusService;
	
	@Autowired
	private StoreService StoreService;
	
	@Autowired
	private ManagerService mngService;
	
	@Autowired
	private WarehouseService wService;
	
	
	@RequestMapping(value="/orderList/orderList")
	public ModelAndView orderList(HttpSession session) {
		ManagerVO loginVO = (ManagerVO)session.getAttribute("loginVO");
		
		int orderCount = 0;	// 전체 주문 개수	
		
		StoreVO store = StoreService.selectByStoreNo(loginVO.getStoreNo());
		List<OrderVO> storeNoOrderList = service.getStoreOrderList(store.getStoreNo());	
		
		System.out.println("오류1");
		for(int i=0; i<storeNoOrderList.size(); i++) {
			List<OrderDetailVO> orderNoDetailList = service.getStoreDetailList(storeNoOrderList.get(i).getOrderNo());
			System.out.println("오류2");
			for(int j=0; j<orderNoDetailList.size(); j++) {				
				ItemContentsVO info = itemService.getItemInfo(orderNoDetailList.get(j).getDetailNo());
				System.out.println("오류3");
				orderNoDetailList.get(j).setStoreNo(store.getStoreNo());
				orderNoDetailList.get(j).setStoreName(store.getStoreName());
				orderNoDetailList.get(j).setItemName(info.getItemName());
				orderNoDetailList.get(j).setSize(info.getSize());
				orderNoDetailList.get(j).setColor(info.getColor());
				System.out.println("detail순회_"+j+" : "+orderNoDetailList.get(j));
			}
			storeNoOrderList.get(i).setOrderDetails(orderNoDetailList);
			
			CustomerVO cus = cusService.getCustomerInfo(storeNoOrderList.get(i).getMemNo());
			System.out.println("오류4");
			storeNoOrderList.get(i).setId(cus.getId());
			storeNoOrderList.get(i).setTelephone(cus.getTelephone());
			
			storeNoOrderList.get(i).setStoreName(loginVO.getStoreName());
			
			orderCount += storeNoOrderList.get(i).getOrderDetails().size();
			System.out.println("order순회_"+i+" : "+storeNoOrderList.get(i));
		}
				
		ModelAndView mav = new ModelAndView("storeManager/orderList/orderList");
		
		System.out.println("storeNoOrderList: "+storeNoOrderList);
		System.out.println("orderCount: " + orderCount);
		
		mav.addObject("orderCount", orderCount);	
		mav.addObject("storeNoorderList", storeNoOrderList);
		
		return mav;
	}
	
	@RequestMapping("/info/searchCustomer")
	public @ResponseBody Map<String, Object> customerOrderList(@RequestParam String inputID, @RequestParam int inputOrderPassword) {
		Map<String, Object> map = new HashMap<>();
		System.out.println(inputID);
		System.out.println(inputOrderPassword);
		CustomerVO customerVO = cusService.selectById(inputID);
		System.out.println(customerVO);
		if(customerVO == null) {
			map.put("msg", "아이디가 일치하지 않습니다. <br> 다시 입력 해주세요");
			map.put("id", inputID);
			map.put("orderPassword", "****");
		} else if( customerVO != null && inputOrderPassword != customerVO.getOrderPassword()) {
			map.put("msg", "비밀번호가 일치하지 않습니다. <br> 다시 입력 해주세요");
			map.put("id", inputID);
			map.put("orderPassword", "****");
		} else {
			map.put("id", inputID);
			map.put("orderPassword", "****");
			List<OrderVO> orderList =  service.memNoOrderList(customerVO.getMemNo());
			
			map.put("orderList", orderList);
			
			int totalCount = 0;
			String floor = null;
			WarehouseVO warehouseVO = null;
			for (int i = 0; i <orderList.size(); i++) {
				orderList.get(i).setStoreName(StoreService.checkStoreName(orderList.get(i).getStoreNo()).getStoreName());
				if( !orderList.get(i).getStatus().equals("수령완료") ) {
					totalCount++;
					floor = orderList.get(i).getFloor();
					warehouseVO =  wService.selectOneWarehouse(customerVO.getMemNo());
					map.put("wareCount", warehouseVO.getCount());
				}
			}
			
			map.put("floor", floor);
			
			if(warehouseVO == null) {
				map.put("wareCount", 0);
				map.put("totalCount", totalCount);
			} else {
				map.put("totalCount", totalCount);
			}
			
		}
		return map;
	}
	
	@RequestMapping("/info/handOver")
	public ModelAndView customerDelivery(ModelAndView mav, @RequestParam String[] post, @RequestParam String tableTotalCount) {
		
		for (int i = 0; i < post.length; i++) {
			System.out.println(post[i]);
		}
		System.out.println(tableTotalCount);
		// total에서 warecount 만큼 제거 0이 되면 지움
		// 상품상태 변경 ->상품준비완료에서 수령완료
/*		CustomerVO customerVO = new CustomerVO();
		service.updateStatusDelivery(customerVO.getMemNo());
		
		Map<String, Object> map = new HashMap<>();
		map.put("memNo", customerVO.getMemNo());
		
		int totalCount = 0;
		int count = 0;
		if(totalCount - count == 0) {
			wService.deleteWarehouse(customerVO.getMemNo());
		} else {
			map.put("count", count);
			wService.subtractWarehouse(map);
		}*/
		
		mav.setViewName("redirect:/info/itemDelivery");
		return mav;	
	}
	
	
}
