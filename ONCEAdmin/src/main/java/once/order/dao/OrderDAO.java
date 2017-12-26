package once.order.dao;

import java.util.List;

import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;
import once.store.vo.StoreVO;

public interface OrderDAO {

	List<OrderVO> selectAllOrder(String floor);

	List<OrderVO> memNoOrderList(int memNo);

	void updateStatusFin(int orderNo);

	List<OrderVO> getStoreOrderList(String storeNo);

	List<OrderDetailVO> getOrderDetailList(int orderNo);

	List<OrderVO> getOptionOrderList(OrderVO options);

	List<OrderVO> getSortOrderList(StoreVO store);

	OrderVO getOrderVO(int orderNo);

	OrderDetailVO getOrderDetail(int no);

	void updateStatusAccpet(int orderNo);

	void updateStatusDelivery(List<OrderVO> deliveryOrderList);

}
