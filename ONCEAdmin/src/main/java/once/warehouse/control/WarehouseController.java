package once.warehouse.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.warehouse.service.WarehouseService;

@Controller
public class WarehouseController {

	@Autowired
	private WarehouseService service;
}
