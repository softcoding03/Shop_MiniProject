package com.model2.mvc.service.product.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.*;
import com.model2.mvc.service.product.ProductDao;

//==> ��ǰ���� DAO CRUD ����
@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.addProduct", product);
	}

	public Product getProduct(int productNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProduct", productNo);
	}
	
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct", product);
	}

	public List<Product> getProductList(Search search) throws Exception {
		System.out.println("   mapper���� search���� ? "+search);
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}
	
	public List<String> getAll0(Search searchKeyword) throws Exception{
		return sqlSession.selectList("ProductMapper.getAll0",searchKeyword);
	}
	public List<String> getAll1(Search searchKeyword) throws Exception{
		return sqlSession.selectList("ProductMapper.getAll1",searchKeyword);
	}
	public List<String> getAll2(Search searchKeyword) throws Exception{
		return sqlSession.selectList("ProductMapper.getAll2",searchKeyword);
	}

	public String getFileName(Product prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getFileName", prodNo);
	}
	
	public int getProdNoLast() throws Exception {
		return sqlSession.selectOne("ProductMapper.getProdNoLast");
	}
	
}
/*
public class ProductDaoImpl {
	
	public ProductDaoImpl(){
	}

	public void insertProduct(Product product) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "insert into Product values (seq_product_prod_no.nextval,?,?,to_char(to_date(?,'yyyy-mm-dd'),'yyyymmdd'),?,?,sysdate)";
		
		PreparedStatement stmt = con.prepareStatement(sql);

		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		
		stmt.executeUpdate();
		
		con.close();
	}

	public Product getProduct(int productNo) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "select * from PRODUCT where PROD_NO=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, productNo);

		ResultSet rs = stmt.executeQuery();

		Product produt = null;
		
		while (rs.next()) {
			
			produt = new Product();
			produt.setProdNo(productNo);
			produt.setProdName(rs.getString("prod_Name"));
			produt.setProdDetail(rs.getString("prod_Detail"));
			produt.setManuDate(rs.getString("manufacture_Day"));
			produt.setPrice(rs.getInt("price"));
			produt.setFileName(rs.getString("image_file")); 
			produt.setRegDate(rs.getDate("reg_Date"));

		}
		
		con.close();

		return produt; //WHERE = productNo �� �̿��� ��ǰ ���� ��������
	}

	public Map<String,Object> getProductList(Search search) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		Connection con = DBUtil.getConnection();
		
		String sql = "select * from PRODUCT ";
	
		
		if (search.getSearchCondition() != null) {
			if ( search.getSearchCondition().equals("0") &&  !search.getSearchKeyword().equals("") ) {
				sql += " WHERE PROD_NO = '" + search.getSearchKeyword()+"'";
			} else if ( search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("")) {// ��ǰ��ȣ�� serchVO�� ��ȣ�� ���õǾ��־����
				sql += " WHERE PROD_NAME LIKE '%" + search.getSearchKeyword()+"%'";
			} else if ( search.getSearchCondition().equals("2") && !search.getSearchKeyword().equals("")) {// ��ǰ���� serchVO�� ��ȣ�� ���õǾ��־����
				sql += " WHERE PRICE ='" + search.getSearchKeyword()+"'";//���� ������
			}
		}
		sql += " order by prod_no";     
		
		System.out.println("ProductDAO :: Original SQL :: " + sql);
		//==> TotalCount GET
		int totalCount = this.getTotalCount(sql); //ProductDao.getTotalCount ���� -> ���ڵ� �� row �� ��ȯ
		System.out.println("ProductDAO :: totalCount :: " + totalCount);
		
		//==> CurrentPage �Խù��� �޵��� Query �ٽñ���(��絥���� ������ �ʿ� ���� ������)
		sql = makeCurrentPageSql(sql, search); //ProductDao.makeCurrentPageSql ����
		
		PreparedStatement stmt = con.prepareStatement(sql);
		//TYPE_SCROLL_INSENSITIVE = rs.next()�� ���� row�� �������� ������ �����ͷ� ���ư��� ���Ѵ�. Ŀ���� ������ �ڸ����� �ٽ� ���ư� �� �ְ� �������.
		//CONCUR_UPDATABLE result�� ������ ���� updateable �� �� �ִ�.
		ResultSet rs = stmt.executeQuery();

		System.out.println(search);
		
		List<Product> list = new ArrayList<Product>();
		
		while(rs.next()){
				Product vo = new Product();
				
				vo.setProdNo(rs.getInt("PROD_NO"));
				vo.setProdName(rs.getString("PROD_NAME"));
				vo.setProdDetail(rs.getString("PROD_DETAIL"));
				vo.setManuDate(rs.getString("MANUFACTURE_DAY"));
				vo.setPrice(rs.getInt("PRICE"));
				vo.setFileName(rs.getString("IMAGE_FILE"));
				vo.setRegDate(rs.getDate("REG_DATE"));
				list.add(vo);  //list��, select�ؿ� �������� ������ vo�� ��´�.
		}
		
	
		//==> totalCount ���� ����
		map.put("totalCount", new Integer(totalCount));
		//==> currentPage �� �Խù� ���� ���� List ����
		map.put("list", list);
		
		rs.close();
		stmt.close();
		con.close();
			
		return map; //totalCount�� 'list'(select�ؿ� vo �������� ���� list) 
	}

	
	public void updateProduct(Product product) throws Exception {
		//browser���� ��ǰ�������� ���� �Է¹��� �� �����س��� productVO�� ���ڷ� ����
		Connection con = DBUtil.getConnection();
		
		String sql = "update PRODUCT set PROD_NAME=?,PROD_DETAIL=?,MANUFACTURE_DAY=to_char(to_date(?,'yyyy-mm-dd'),'yyyymmdd'),price=?,IMAGE_FILE=? where PROD_NO=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, product.getProdName());
		stmt.setString(2, product.getProdDetail());
		stmt.setString(3, product.getManuDate());
		stmt.setInt(4, product.getPrice());
		stmt.setString(5, product.getFileName());
		stmt.setInt(6, product.getProdNo());
		stmt.executeUpdate();
		
		System.out.println("update ���� ������ �Ϸ� !");
		
		con.close();
	}
	
	private int getTotalCount(String sql) throws Exception {
		
		sql = "SELECT COUNT(*) "+
		          "FROM ( " +sql+ ") countTable";
		
		Connection con = DBUtil.getConnection();
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
		
		int totalCount = 0;
		if( rs.next() ){
			totalCount = rs.getInt(1);// ù ���� int ?
		}
		
		pStmt.close();
		con.close();
		rs.close();
		
		return totalCount; //���ڵ� row �� ��ȯ
	}
	
	// �Խ��� currentPage Row ��  return 
	private String makeCurrentPageSql(String sql , Search search){
		sql = 	"SELECT * "+ 
					"FROM (SELECT inner_table. * , ROWNUM AS row_seq" +
							" FROM ("+sql+") inner_table"+
							" WHERE ROWNUM <="+search.getCurrentPage()*search.getPageSize()+" ) " +
					"WHERE row_seq BETWEEN "+((search.getCurrentPage()-1)*search.getPageSize()+1) +" AND "+search.getCurrentPage()*search.getPageSize();
		
		System.out.println("UserDAO :: make SQL :: "+ sql);	
		
		return sql;
	}
}

*/