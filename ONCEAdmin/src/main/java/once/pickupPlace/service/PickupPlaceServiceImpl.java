package once.pickupPlace.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.pickupPlace.dao.PickupPlaceDAO;

@Service
public class PickupPlaceServiceImpl implements PickupPlaceService {

	@Autowired
	private PickupPlaceDAO dao;
	
}
