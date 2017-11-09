package once.store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.store.dao.StoreDAO;

@Service
public class StoreServiceImpl implements StoreService {
	
	@Autowired
	private StoreDAO dao;
}
