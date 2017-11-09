package once.store.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.store.service.StoreService;

@Controller
public class StoreController {

	@Autowired
	private StoreService service;
}
