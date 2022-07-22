package com.aza.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.domain.User;
import com.aza.service.user.UserDao;

@Component
@PropertySource("classpath:/application.properties")
@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {
	
	///Field
	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public UserDaoImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}
	
	@Override
	public void addUserbyParent(User user) throws Exception {
		sqlSession.insert("UserMapper.addUserbyParent", user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}

	@Override
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		sqlSession.delete("UserMapper.deleteUser", user);
	}

	@Override
	public int checkDuplication(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.checkDuplication", userId);
	}
	
	@Override
	public int checkStudent(String firstStudentId) throws Exception {
		return sqlSession.selectOne("UserMapper.checkStudent", firstStudentId);
	}

	@Override
	public void updateAlertState(User user) throws Exception {	
		sqlSession.update("UserMapper.updateAlertState", user);	
	}

	@Override
	public void updateStopAlertStartTime(User user) throws Exception {
		sqlSession.update("UserMapper.updateStopAlertStartTime", user);
	}

	@Override
	public void updateStopAlertEndTime(User user) throws Exception {
		sqlSession.update("UserMapper.updateStopAlertEndTime", user);
	}

	@Override
	public void addRelation(User user) throws Exception {
		sqlSession.insert("RelationMapper.addRelation", user);	
	}

	@Override
	public void deleteRelation(int relationCode) throws Exception {
		sqlSession.delete("RelationMapper.deleteRelation", relationCode);	
	}
	
//	@Override
//	public void deleteRelation(String userId) throws Exception {
//		sqlSession.delete("RelationMapper.deleteRelation", userId);	
//	}

//	@Override
//	public User getRelation(String firstStudentId, String parentId) throws Exception {
//		User user = new User();
//		user.setFirstStudentId(firstStudentId);
//		user.setUserId(parentId);
//		return sqlSession.selectOne("RelationMapper.getRelation", user);
//	}
	
	@Override
	public User getRelation(int relationCode) throws Exception {

		return sqlSession.selectOne("RelationMapper.getRelation", relationCode);
	}

	@Override
	public void updateRelation(User user) throws Exception {
		sqlSession.update("RelationMapper.updateRelation", user);
	}
	
	@Override
	public List<User> listRelationByStudent(Search search, String studentId) throws Exception {
		search.setSearchId(studentId);
		
		return sqlSession.selectList("RelationMapper.listRelationByStudent", search);
	}
	
	@Override
	public List<User> listRelationByParent(Search search, String parentId) throws Exception {
		search.setSearchId(parentId);		
		return sqlSession.selectList("RelationMapper.listRelationByParent", search);
	}
	
	@Override
	public List<User> listStudentRelationByParent(Search search, String parentId) throws Exception {
		search.setSearchId(parentId);
		return sqlSession.selectList("RelationMapper.listStudentRelationByParent", search);
	}
	
	@Override
	public int getListRelationByStudentTotalCount(Search search, String studentId) throws Exception {
		search.setSearchId(studentId);
		return  sqlSession.selectOne("RelationMapper.getListRelationByStudentTotalCount", search);
	}
	
	@Override
	public int getListRelationByParentTotalCount(Search search, String parentId) throws Exception {
		search.setSearchId(parentId);
		return  sqlSession.selectOne("RelationMapper.getListRelationByParentTotalCount", search);

	}
	
	public int getRelationTotalCount(Search search, String searchKeyword) throws Exception{
		search.setSearchKeyword(searchKeyword);
		return sqlSession.selectOne("RelationMapper.getRelationTotalCount",search);
	}
	
	@Override
	public List<User> listRelation(Search search, String parentId) throws Exception {
		search.setSearchId(parentId);		
		return sqlSession.selectList("RelationMapper.listRelation", search);
	}
	
	@Override
	public int getListRelationTotalCount(Search search, String parentId) throws Exception {
		search.setSearchId(parentId);
		return  sqlSession.selectOne("RelationMapper.getListRelationTotalCount", search);
	}
	
	

	@Override
	public void updateCheck(User user) throws Exception {
		sqlSession.update("UserMapper.updateCheck", user);
	}

	@Override
	public User findId(User user) throws Exception {
		return sqlSession.selectOne("UserMapper.findId", user);
	}

	@Override
	public User findPassword(User user) throws Exception {
		return sqlSession.selectOne("UserMapper.findPassword", user);
	}

	@Override
	public void updatePassword(User user) throws Exception {
		sqlSession.update("UserMapper.updatePassword", user);
	}

	@Override
	public User checkPhone(User user) throws Exception {
		return sqlSession.selectOne("UserMapper.checkPhone", user);
	}
	
	@Override
	public User firstStudentIdByParent(String parentId) throws Exception {
		return sqlSession.selectOne("RelationMapper.firstStudentIdByParent", parentId);
	}

}
