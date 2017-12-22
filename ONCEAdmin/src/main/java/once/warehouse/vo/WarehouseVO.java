package once.warehouse.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@NoArgsConstructor
@RequiredArgsConstructor
@Data
public class WarehouseVO {

	private int wareNo;
	@NonNull
	private int count;
	@NonNull
	private String floor;
	@NonNull
	private int memNo;
	@NonNull
	private int floorWareNo;
}
