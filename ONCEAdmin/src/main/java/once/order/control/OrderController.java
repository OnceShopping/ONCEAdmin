package once.order.control;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
}
