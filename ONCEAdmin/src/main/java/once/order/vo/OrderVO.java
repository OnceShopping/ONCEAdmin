package once.order.vo;

import java.util.List;
import lombok.Data;

@Data
public class OrderVO {

	private int orderNo;
	
	private List<OrderDetailVO> orderDetails;
	
	private int memNo;
	private String id;
	private String telephone;
	
	private String storeNo;
	private String storeName;
	private int staffNo;
	private String managerId;
	
	private String status;
		
	private String floor;
	
	private int count;
	
	private String date;
	
	private int totalPrice;
	private int oriPrice;
	private int salePrice;

	private String site;
	
}