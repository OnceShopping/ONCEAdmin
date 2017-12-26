package once.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.order.dao.OrderDAO;

import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;
import once.store.vo.StoreVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO dao;

	@Override
	public List<OrderVO> selectAllOrder(String floor) {
		List<OrderVO> orderList = dao.selectAllOrder(floor);
		return orderList;
	}

	@Override
	public List<OrderVO> memNoOrderList(int memNo) {
		List<OrderVO> memNoOrderList = dao.memNoOrderList(memNo);
		return memNoOrderList;
	}

	@Override
	public void updateStatusFin(int orderNo) {
		dao.updateStatusFin(orderNo);
	}

	@Override
	public List<OrderVO> getStoreOrderList(String storeNo) {
		List<OrderVO> storeNoOrderList = dao.getStoreOrderList(storeNo);
		return storeNoOrderList;
	}

	@Override
	public List<OrderDetailVO> getOrderDetailList(int orderNo) {
		List<OrderDetailVO> orderNoDetailList = dao.getOrderDetailList(orderNo);
		return orderNoDetailList;
	}

	@Override
	public void updateStatusDelivery(int memNo) {
		dao.updateStatusDelivery(memNo);
		
	}

  @Override
	public List<OrderVO> getOptionOrderList(OrderVO options) {
		List<OrderVO> storeOptionOrderList = dao.getOptionOrderList(options);
		return storeOptionOrderList;
	}

	@Override
	public List<OrderVO> getSortOrderList(StoreVO store) {
		List<OrderVO> sortOptionOrderList = dao.getSortOrderList(store);
		return sortOptionOrderList;
	}

	@Override
	public OrderVO getOrderVO(int orderNo) {
		OrderVO orderInfo = dao.getOrderVO(orderNo);
		return orderInfo;
	}

	@Override
	public OrderDetailVO getOrderDetail(int no) {
		OrderDetailVO detail = dao.getOrderDetail(no);
		return detail;
	}

	@Override
	public void updateStatusAccpet(int orderNo) {
		dao.updateStatusAccpet(orderNo);
	}

	@Override
	public void updateStatusDelivery(List<OrderVO> deliveryOrderList) {
		dao.updateStatusDelivery(deliveryOrderList);		
	}

}

