package once.pickupPlace.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import once.pickupPlace.service.PickupPlaceService;

@Controller
public class PickupController {

	@Autowired
	private PickupPlaceService service;
}
