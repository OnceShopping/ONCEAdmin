package once.item.vo;

import lombok.Data;

@Data
public class ItemVO {

	private String itemName;
	
	private String itemCategory1;
	private String itemCategory2;
	private String itemCategory3;
	
	private int price;
	private String saleTag;
	private int salePrice;
	private String startDate;
	private String endDate;
	
	private String storeNo;
	private String detail;
	
}
