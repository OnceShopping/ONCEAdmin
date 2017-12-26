package once.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.order.dao.OrderDAO;

import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;

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
	public List<OrderDetailVO> getStoreDetailList(int orderNo) {
		List<OrderDetailVO> orderNoDetailList = dao.getStoreDetailList(orderNo);
		return orderNoDetailList;
	}

	@Override
	public void updateStatusDelivery(int memNo) {
		dao.updateStatusDelivery(memNo);
		
	}

}

