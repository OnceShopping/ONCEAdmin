package once.order.control;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import once.customer.service.CustomerService;
import once.customer.vo.CustomerVO;
import once.item.service.ItemService;
import once.item.vo.ItemContentsVO;
import once.item.vo.ItemDetailVO;
import once.manager.service.ManagerService;
import once.manager.vo.ManagerVO;
import once.order.service.OrderService;
import once.order.vo.OrderDetailVO;
import once.order.vo.OrderVO;
import once.store.service.StoreService;
import once.store.vo.StoreVO;
import once.warehouse.service.WarehouseService;
import once.warehouse.vo.WarehouseVO;
import once.tagSticker.service.TagStickerService;
import once.tagSticker.vo.TagStickerVO;


@Controller
public class OrderController {

	@Autowired
	private OrderService service;

	@Autowired
	private ItemService itemService;

	@Autowired
	private CustomerService cusService;

	@Autowired
	private ManagerService mngService;
	
	@Autowired
	private WarehouseService wService;
	
	@Autowired
	private StoreService storeService;
	
	private List<OrderVO> deliveryOrderList;
	
	@Autowired
	private TagStickerService tService;
	
	public List<OrderVO> getOrderDetailList(StoreVO store, List<OrderVO> orderVOList) {

		for (int i = 0; i < orderVOList.size(); i++) {
			List<OrderDetailVO> orderDetailList = service.getOrderDetailList(orderVOList.get(i).getOrderNo());
			for (int j = 0; j < orderDetailList.size(); j++) {

				ItemContentsVO info = itemService.getItemInfo(orderDetailList.get(j).getDetailNo());
				orderDetailList.get(j).setOrderNo(orderVOList.get(i).getOrderNo());
				orderDetailList.get(j).setStoreNo(store.getStoreNo());
				orderDetailList.get(j).setStoreName(store.getStoreName());
				orderDetailList.get(j).setItemName(info.getItemName());
				orderDetailList.get(j).setSize(info.getSize());
				orderDetailList.get(j).setColor(info.getColor());
			}

			orderVOList.get(i).setOrderDetails(orderDetailList);

			CustomerVO cus = cusService.getCustomerInfo(orderVOList.get(i).getMemNo());
			orderVOList.get(i).setId(cus.getId());
			orderVOList.get(i).setTelephone(cus.getTelephone());
			orderVOList.get(i).setStoreName(store.getStoreName());
		}
		return orderVOList;
	}

	public int getOrderCount(List<OrderVO> orderVOList) {
		int orderCount = 0; // 전체 주문 개수
		for (int i = 0; i < orderVOList.size(); i++) {
			orderCount += orderVOList.get(i).getOrderDetails().size();
		}
		return orderCount;
	}

	@RequestMapping(value = "/orderList/alertModal")
	public @ResponseBody ModelAndView alertModal(@RequestParam("str") String str) {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("storeManager/orderList/alertModal");
		mav.addObject("str", str);

		return mav;
	}

	@RequestMapping(value = "/orderList/orderList")
	public ModelAndView orderList(HttpSession session) {
		ManagerVO loginVO = (ManagerVO) session.getAttribute("loginVO");

		StoreVO store = storeService.selectByStoreNo(loginVO.getStoreNo());
		List<OrderVO> storeNoOrderList = service.getStoreOrderList(store.getStoreNo());
		storeNoOrderList = getOrderDetailList(store, storeNoOrderList);
		int orderCount = getOrderCount(storeNoOrderList); // 전체 주문 개수

		System.out.println("orderList: "+storeNoOrderList);
		
		ModelAndView mav = new ModelAndView("storeManager/orderList/orderList");

		mav.addObject("orderCount", orderCount);
		mav.addObject("orderList", storeNoOrderList);

		return mav;
	}

	@RequestMapping(value = "/orderList/serchOption")
	public @ResponseBody ModelAndView serchOption(@RequestParam(value = "choice") String choice,
			@RequestParam(value = "option", required = false) String option, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		ManagerVO loginVO = (ManagerVO) session.getAttribute("loginVO");
		StoreVO store = storeService.selectByStoreNo(loginVO.getStoreNo());
		OrderVO options = new OrderVO();

		options.setStoreNo(store.getStoreNo());

		List<OrderVO> storeOptionOrderList = null;

		if (choice.equals("all")) {

			storeOptionOrderList = service.getStoreOrderList(store.getStoreNo());

		} else if (choice.equals("status") || choice.equals("floor")) {

			switch (choice) {
			case "status":
				options.setStatus(option);
				break;

			case "floor":
				options.setFloor(option);
				break;

			default:
				mav.setViewName("storeManager/orderList/optionError");
				mav.addObject("msg", "이상한 옵션 선택");
				return mav;
			}

			storeOptionOrderList = service.getOptionOrderList(options);

		} else if (choice.equals("orderNo")) {

			if (option.equals("내림차순")) {
				store.setSortChoice(0);
			} else if (option.equals("오름차순")) {
				store.setSortChoice(1);
			} else {
				mav.setViewName("storeManager/orderList/optionError");
				mav.addObject("msg", "이상한 옵션 선택");
				return mav;
			}

			storeOptionOrderList = service.getSortOrderList(store);
		}

		storeOptionOrderList = getOrderDetailList(store, storeOptionOrderList);
		int orderCount = getOrderCount(storeOptionOrderList);

		mav.setViewName("storeManager/orderList/changeTable");
		mav.addObject("orderList", storeOptionOrderList);
		mav.addObject("orderCount", orderCount);
		mav.addObject("choice", choice);
		mav.addObject("option", option);

		return mav;
	}

	@RequestMapping(value = "/orderList/preAcceptOrder")
	public @ResponseBody ModelAndView preAcceptOrder(@RequestParam("orderNo") int orderNo,
			@RequestParam("noList") int[] noList) {

		List<OrderDetailVO> preAcceptOrderList = new ArrayList<>();
		ModelAndView mav = new ModelAndView();
		
		for (int i = 0; i < noList.length; i++) {
			System.out.println(noList[i]);
			preAcceptOrderList.add(service.getOrderDetail(noList[i]));
			ItemContentsVO detail = itemService.getItemInfo(preAcceptOrderList.get(i).getDetailNo());
			preAcceptOrderList.get(i).setItemName(detail.getItemName());
			preAcceptOrderList.get(i).setColor(detail.getColor());
			preAcceptOrderList.get(i).setSize(detail.getSize());
		}

		OrderVO orderInfo = service.getOrderVO(orderNo);

		if (orderInfo.getCount() > noList.length) {
			mav.setViewName("storeManager/orderList/alertModal");
			mav.addObject("str", "같은 주문 번호의 상품(들)은 한번에 승인 하셔야 합니다.");
			mav.addObject("more", "선택 상품 개수: " + noList.length + " | 주문상품개수: " + orderInfo.getCount());
		} else {
			// tagNo: 층 + 고객 + 매장 + 주문
			orderInfo.setTagNo(
					orderInfo.getFloor() + "-" + orderInfo.getMemNo() + "-" + orderInfo.getStoreNo() + "-" + orderNo);
			orderInfo.setId(cusService.getCustomerInfo(orderInfo.getMemNo()).getId());
			orderInfo.setStoreName(storeService.selectByStoreNo(orderInfo.getStoreNo()).getStoreName());

			mav.setViewName("storeManager/orderList/acceptModal");
			mav.addObject("preAcceptOrderList", preAcceptOrderList);
			mav.addObject("orderInfo", orderInfo);
			mav.addObject("count", noList.length);
		}

		return mav;
	}

	@RequestMapping(value = "/orderList/preDelivery")
	public @ResponseBody ModelAndView preDelivery(@RequestParam("uniqOrderNoList") int[] uniqOrderNoList,
			@RequestParam("noList") int[] noList, @RequestParam("floor") String floor) {

		deliveryOrderList = new ArrayList<>();

		ModelAndView mav = new ModelAndView();
		boolean possible = false;		
		
		for (int i = 0; i < uniqOrderNoList.length; i++) {
			
			List<OrderDetailVO> preDetailList = new ArrayList<>();

			OrderVO orderInfo = service.getOrderVO(uniqOrderNoList[i]);			
						
			orderInfo.setId(cusService.getCustomerInfo(orderInfo.getMemNo()).getId());
			orderInfo.setStoreName(storeService.selectByStoreNo(orderInfo.getStoreNo()).getStoreName());
			
			deliveryOrderList.add(orderInfo);
			
			for (int j = 0; j < noList.length; j++) {
				
				OrderDetailVO orderDetail = service.getOrderDetail(noList[j]);
				
				if (orderInfo.getOrderNo() == orderDetail.getOrderNo()) {
					ItemContentsVO detail = itemService.getItemInfo(orderDetail.getDetailNo());
					orderDetail.setItemName(detail.getItemName());
					orderDetail.setColor(detail.getColor());
					orderDetail.setSize(detail.getSize());					
					
					preDetailList.add(orderDetail);
					
					deliveryOrderList.get(i).setOrderDetails(preDetailList);
				}
			}

			if (deliveryOrderList.get(i).getCount() != deliveryOrderList.get(i).getOrderDetails().size()) {
				possible = false;
				break;
			}else {
				possible = true;
			}
		}
		
		if(possible==false) {
			mav.setViewName("storeManager/orderList/alertModal");
			mav.addObject("str", "같은 주문 번호의 상품(들)은 한번에 전달 하셔야 합니다.");
		}else {
			mav.setViewName("storeManager/orderList/deliveryModal");
			mav.addObject("deliveryOrderList", deliveryOrderList);
			mav.addObject("floor", floor);
			mav.addObject("count", uniqOrderNoList.length);	// 해당 info에 가는 총 주문 개수
		}
		
		return mav;
	}

	@RequestMapping(value = "/orderList/acceptOrder/{orderNo}/{tagNo}", method = RequestMethod.GET)
	public ModelAndView acceptOrder(@PathVariable("orderNo") int orderNo, HttpSession session, @PathVariable("tagNo")String tagNo) {
		ModelAndView mav = new ModelAndView();
		ManagerVO loginVO = (ManagerVO) session.getAttribute("loginVO");
		String[] words = tagNo.split("-");
		 
		service.updateStatusAccpet(orderNo);

		StoreVO store = storeService.selectByStoreNo(loginVO.getStoreNo());
		List<OrderVO> resultOrderList = service.getStoreOrderList(store.getStoreNo());
			
		resultOrderList = getOrderDetailList(store, resultOrderList);
		int orderCount = getOrderCount(resultOrderList); // 전체 주문 개수
		
		TagStickerVO tagStickerVO = new TagStickerVO(tagNo, Integer.parseInt(words[1]), orderNo, loginVO.getStaffNo());
		tService.insertTag(tagStickerVO);
		
		mav.setViewName("storeManager/orderList/orderList");
		mav.addObject("orderList", resultOrderList);
		mav.addObject("orderCount", orderCount);

		return mav;
	}
	
	@RequestMapping(value = "/orderList/deliveryOrder/{floor}", method = RequestMethod.GET)
	public ModelAndView deliveryOrder(@PathVariable("floor") String floor, HttpSession session) {
		
		ManagerVO loginVO = (ManagerVO) session.getAttribute("loginVO");
			
		ModelAndView mav = new ModelAndView();
		
		for(int i=0; i<deliveryOrderList.size(); i++) {
			if(!deliveryOrderList.get(i).getFloor().equals(floor)) {
				mav.setViewName("storeManager/orderList/alertModal");
				mav.addObject("str", "같은 주문 번호의 상품(들)은 한번에 전달 하셔야 합니다.");
				return mav;
			}
		}
		
		service.updateStatusDelivery(deliveryOrderList);
		
		StoreVO store = storeService.selectByStoreNo(loginVO.getStoreNo());
		List<OrderVO> resultOrderList = service.getStoreOrderList(store.getStoreNo());
		
		resultOrderList = getOrderDetailList(store, resultOrderList);
		int orderCount = getOrderCount(resultOrderList);
		
		mav.setViewName("storeManager/orderList/orderList");
		mav.addObject("orderList", resultOrderList);
		mav.addObject("orderCount", orderCount);
		
		return mav;
	}
	
	@RequestMapping("/info/searchCustomer")
	public @ResponseBody Map<String, Object> customerOrderList(@RequestParam String inputID, @RequestParam int inputOrderPassword) {
		Map<String, Object> map = new HashMap<>();
		CustomerVO customerVO = cusService.selectById(inputID);
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
				orderList.get(i).setStoreName(storeService.checkStoreName(orderList.get(i).getStoreNo()).getStoreName());
				if( !orderList.get(i).getStatus().equals("수령완료") ) {
					totalCount++;
					floor = orderList.get(i).getFloor();
					warehouseVO =  wService.selectOneWarehouse(customerVO.getMemNo());
					
				}
			}
			
			map.put("floor", floor);
			if(floor == null) {
				map.put("msg", "물품이 존재하지 않습니다");
			}
			
			if(warehouseVO == null) {
				map.put("wareCount", 0);
				map.put("totalCount", totalCount);
			} else {
				map.put("wareCount", warehouseVO.getCount());
				map.put("totalCount", totalCount);
			}
			
		}
		return map;
	}
	
	@RequestMapping("/info/handOver")
	public ModelAndView customerDelivery(ModelAndView mav, @RequestParam("post") String[] orderNo, @RequestParam String Counts, 
			@RequestParam("customerId")String id) {
		
		String[] words = Counts.split("/");
		int wareCount = Integer.parseInt(words[0]);
		int totalCount = Integer.parseInt(words[1]);
		// total에서 warecount 만큼 제거 0이 되면 지움
		// 상품상태 변경 ->상품준비완료에서 수령완료
		CustomerVO customerVO = cusService.selectById(id);
		service.updateStatusDelivery(customerVO.getMemNo());
		
		Map<String, Object> map = new HashMap<>();
		map.put("memNo", customerVO.getMemNo());
		
		if(totalCount - wareCount == 0) {
			wService.deleteWarehouse(customerVO.getMemNo());
		} else {
			map.put("count", wareCount);
			wService.subtractWarehouse(map);
		}
		
		mav.setViewName("redirect:/info/itemDelivery");
		return mav;	
	}
	
	
}
