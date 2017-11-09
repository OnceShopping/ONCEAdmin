package once.manager.vo;

import lombok.Data;

@Data
public class ManagerVO {

	private int staffNo;
	
	private String managerId;	// primary key
	private String password;
	private String type;
	
	private String storeNo;
	
	private String name;
	private String telephone;
	
	private String date;
	
}