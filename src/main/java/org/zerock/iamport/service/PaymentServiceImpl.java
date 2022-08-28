package org.zerock.iamport.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.zerock.iamport.dao.PaymentDAO;
import org.zerock.iamport.model.PaymentVO;

@Service("paymentService")
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentDAO dao;
	
	@Override
	public void insertPaymentSuccess(PaymentVO vo) {
		
		dao.insertPaymentSuccess(vo);
	}
}
