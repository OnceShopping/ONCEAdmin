package once.counter.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import once.counter.dao.CounterDAO;

@Service
public class CounterServiceImpl implements CounterService {
	
	@Autowired
	private CounterDAO dao;
}
