package once.order.vo;

import lombok.Data;

@Data
public class OrderDetailVO {

	private int no;
	
	private int orderNo;
	
	private int detailNo;
	
	private String storeNo;
	private String storeName;
	
	private int count;
		
	private String itemName;
	private int num;
	
	private int price;
	
	private String size;
	private String color;
	
	private String imgOriName;
	private String imgSaveName;
	private int imgSize;
	
}
