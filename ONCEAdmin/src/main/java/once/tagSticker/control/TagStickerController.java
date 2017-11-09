package once.tagSticker.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.tagSticker.service.TagStickerService;

@Controller
public class TagStickerController {
	
	@Autowired
	private TagStickerService service;
}
