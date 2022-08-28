package org.zerock.iamport.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import org.zerock.iamport.model.PaymentVO;

@Repository
public class PaymentDAO {
	
	private static SqlSessionFactory sqlMapper;
	
	private static SqlSessionFactory getInstance() {
		if(sqlMapper == null) {
			String resource = "mybatis-config.xml";
			try {
				Reader reader = Resources.getResourceAsReader(resource);
				sqlMapper = new SqlSessionFactoryBuilder().build(reader);
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return sqlMapper;
	}
	
	public void insertPaymentSuccess(PaymentVO vo) {
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		session.insert("payment.insertPaymentSuccess", vo);
		session.commit();
	}
	
}
