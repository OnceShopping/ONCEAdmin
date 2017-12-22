package once.order.service;

import java.util.List;

import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;

public interface OrderService {

	List<OrderVO> selectAllOrder(String floor);

	List<OrderVO> memNoOrderList(int memNo);

	void updateStatusFin(int orderNo);

	List<OrderVO> getStoreOrderList(String storeNo);

	List<OrderDetailVO> getStoreDetailList(int orderNo);

}
