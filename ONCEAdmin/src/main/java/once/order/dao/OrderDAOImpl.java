package once.order.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import once.order.vo.OrderDetailVO;

import once.order.vo.OrderVO;

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
	public List<OrderDetailVO> getStoreDetailList(int orderNo) {
		List<OrderDetailVO> orderNoDetailList = sqlSession.selectList("once.order.dao.OrderDAO.orderNoDetailList", orderNo);
		return orderNoDetailList;
	}
		

}
