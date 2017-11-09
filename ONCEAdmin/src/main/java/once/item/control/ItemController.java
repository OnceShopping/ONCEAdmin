package once.item.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.item.service.ItemService;

@Controller
public class ItemController {

	@Autowired
	private ItemService service;
}
