package once.tagSticker.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@NoArgsConstructor
@RequiredArgsConstructor
@Data
public class TagStickerVO {
	@NonNull
	private String tagNo;
	@NonNull	
	private int memNo;
	@NonNull
	private int orderNo;
	@NonNull
	private int staffNo;
	
	private String status;
}
