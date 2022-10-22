package com.aza.service.alert.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.alert.AlertDao;
import com.aza.service.domain.Alert;


@Component
@PropertySource("classpath:/application.properties")
@Repository("alertDaoImpl")
public class AlertDaoImpl implements AlertDao {

	// field
	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSessionTemplate;

	
	// ctor
	public AlertDaoImpl() {
		System.out.println("[ "+this.getClass()+" ] :: start");
	}
	

	// method
	public void setSqlSessionTemplate(SqlSession sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	@Override
	public void addAlert(Alert alert) throws Exception {
		sqlSessionTemplate.insert("AlertMapper.addAlert", alert);
	}
	
	@Override
	public void addAlertAttendance(Alert alert) throws Exception {
		sqlSessionTemplate.insert("AlertMapper.addAlertAttendance", alert);
	}
	
	@Override
	public void addAlertPayment() throws Exception {
		sqlSessionTemplate.insert("AlertMapper.addAlertPayment");		
	}

	@Override
	public Alert getAlert(int alertCode) throws Exception {
		return sqlSessionTemplate.selectOne("AlertMapper.getAlert", alertCode);
	}

	@Override
	public void readAlert(int alertCode) throws Exception {
		sqlSessionTemplate.update("AlertMapper.readAlert", alertCode);
	}

	@Override
	public void deleteAlert(int alertCode) throws Exception {
		sqlSessionTemplate.delete("AlertMapper.deleteAlert", alertCode);
	}

	@Override
	public List<Alert> listAlert(Search search, String receiverId) throws Exception {
		search.setSearchId(receiverId);
		return sqlSessionTemplate.selectList("AlertMapper.listAlert", search);
	}

	@Override
	public int getAlertTotalCount(Search search, String receiverId) throws Exception {
		search.setSearchId(receiverId);
		return sqlSessionTemplate.selectOne("AlertMapper.getAlertTotalCount", search);
	}
	
	
	@Override
	public List<Alert> getAlertPayment(Search search,String receiverId)throws Exception {
		search.setSearchId(receiverId);
		return sqlSessionTemplate.selectList("AlertMapper.getAlertPayment", search);
	}
	
	
	@Override
	public List<Alert> getAlertByDate(Search search)throws Exception{
		return sqlSessionTemplate.selectList("AlertMapper.getAlertByDate");
		
	}


	@Override
	public int alertCreateList(int alertCode) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
