package once.order.vo;

import lombok.Data;

@Data
public class OrderVO {

	private String id;
	
	private int orderNo;
	private String date;
	
	private String floor;
	
	private String status;
	
	private int count;
	private int totalPrice;

	private String site;
	
	private String managerId;
}