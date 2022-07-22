package com.aza.service.payment.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.domain.Payment;
import com.aza.service.payment.PaymentDao;

@Component
@PropertySource("classpath:/application.properties")
@Repository("paymentDaoImpl")
public class PaymentDaoImpl implements PaymentDao {
	
	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	 public void setSqlSession(SqlSession sqlSession) {
		    this.sqlSession = sqlSession;
	}
	
	public void PaymentDaoImpl() {
		System.out.println(this.getClass());
	}
	 
	@Override
	public Payment getPayment(int payCode) throws Exception {

		return sqlSession.selectOne("PaymentMapper.getPayment", payCode);
	}

	@Override
	public void updatePayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PaymentMapper.updatePayment", payment);
		
	}

	@Override
	public void addPayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("PaymentMapper.addPayment", payment);
		
	}

	@Override
	public List<Payment> listPayment(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PaymentMapper.listPayment", search);
	}

	
	//test
	//=============================================================================
	@Override
	public void addPaymentProcedure() throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("PaymentMapper.addPaymentProcedure");	
	}

	@Override
	public int totalPaymentCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PaymentMapper.totalPaymentCount", search);
		
	}

	@Override
	public void deletePayment(int paycode) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("PaymentMapper.deletePayment", paycode);
		
	}

	@Override
	public List<Payment> listPaymentBystudent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PaymentMapper.listPaymentBystudent",search);
	}

	@Override
	public int totalPaymentCountBystudent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PaymentMapper.totalPaymentCountBystudent",search);
	}

	@Override
	public List<Payment> listPaymentByParent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PaymentMapper.listPaymentByParent",search);
	}

	@Override
	public int totalPaymentCountByParent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PaymentMapper.totalPaymentCountByParent",search);
	}

}
