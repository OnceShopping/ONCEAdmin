package once.order.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;
import once.store.vo.StoreVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<OrderVO> selectAllOrder(String floor) {
		List<OrderVO> orderList = sqlSession.selectList("once.order.dao.OrderDAO.selectAllOrder", floor);
		return orderList;
	}

	@Override
	public List<OrderVO> memNoOrderList(int memNo) {
		List<OrderVO> memNoOrderList = sqlSession.selectList("once.order.dao.OrderDAO.memNoOrderList", memNo);
		return memNoOrderList;
	}

	@Override
	public void updateStatusFin(int orderNo) {
		sqlSession.update("once.order.dao.OrderDAO.updateStatusFin", orderNo);
	}

	@Override
	public List<OrderVO> getStoreOrderList(String storeNo) {
		
		List<OrderVO> storeNoOrderList = sqlSession.selectList("once.order.dao.OrderDAO.storeNoOrderList", storeNo);
		
		return storeNoOrderList;
	}

	@Override
	public List<OrderDetailVO> getOrderDetailList(int orderNo) {
		List<OrderDetailVO> orderNoDetailList = sqlSession.selectList("once.order.dao.OrderDAO.orderNoDetailList", orderNo);
		return orderNoDetailList;
	}

	@Override
	public void updateStatusDelivery(int memNo) {
		sqlSession.update("once.order.dao.OrderDAO.updateStatusDeliveryMemNo", memNo);
	}
  
  @Override
	public List<OrderVO> getOptionOrderList(OrderVO options) {
		List<OrderVO> storeOptionOrderList = sqlSession.selectList("once.order.dao.OrderDAO.optionOrderList", options);
		return storeOptionOrderList;
	}

	@Override
	public List<OrderVO> getSortOrderList(StoreVO store) {
		List<OrderVO> sortOptionOrderList = sqlSession.selectList("once.order.dao.OrderDAO.sortOrderList", store);
		return sortOptionOrderList;
	}

	@Override
	public OrderVO getOrderVO(int orderNo) {
		OrderVO orderInfo= sqlSession.selectOne("once.order.dao.OrderDAO.getOrderInfo", orderNo);
		return orderInfo;
	}

	@Override
	public OrderDetailVO getOrderDetail(int no) {
		OrderDetailVO detail = sqlSession.selectOne("once.order.dao.OrderDAO.getDetailInfo", no);
		return detail;
	}

	@Override
	public void updateStatusAccpet(int orderNo) {
		sqlSession.update("once.order.dao.OrderDAO.updateStatusAccpet", orderNo);
	}

	@Override
	public void updateStatusDelivery(List<OrderVO> deliveryOrderList) {
		
		for(int i=0; i<deliveryOrderList.size(); i++) {
			sqlSession.update("once.order.dao.OrderDAO.updateStatusDelivery", deliveryOrderList.get(i).getOrderNo());
		}
		
	}

			

}
