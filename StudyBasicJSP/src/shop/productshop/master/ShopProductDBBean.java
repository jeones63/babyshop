package shop.productshop.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ShopProductDBBean {
	
	private static ShopProductDBBean instance = new ShopProductDBBean();
	
	public static ShopProductDBBean getInstance() {
		return instance;
	}
	
	private ShopProductDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp2");
		return ds.getConnection();
	}
	
	
	//	관리자 인증 메소드
	public int managerCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			/*sql = "select managerPasswd from manager where managerId=?";*/
			sql = "select managerPasswd from manager where managerId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("managerPasswd");
				if(dbpasswd.equals(passwd)) {
					x = 1;
				} else {
					x = 0;
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException ex) {
					
				}
			}
		}
		
		return x;
	}
	
	// 상품 등록 메소드
	public void insertProduct(ShopProductDataBean product) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "insert into product values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product.getProduct_id());
			pstmt.setString(2, product.getProduct_kind());
			pstmt.setString(3, product.getProduct_title());
			pstmt.setInt(4, product.getProduct_price());
			pstmt.setShort(5, product.getProduct_count());
			pstmt.setString(6, product.getBrand());
			pstmt.setString(7, product.getProduct_image());
			pstmt.setNString(8, product.getProduct_content());
			pstmt.setByte(9, product.getDiscount_rate());
			pstmt.setTimestamp(10, product.getReg_date());
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException ex) {
					
				}
			}
		}
	}
	
	//	전체등록된 상품의 수를 얻어내는 메소드
	public int getProductCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int x= 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}  catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
		
		return x;
	}
	
	//	분류별 또는 전체 등록된 상품의 정보를 얻어내는 메소드
	public List<ShopProductDataBean> getProducts(String product_kind) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ShopProductDataBean> productList =null;
		
		try {
			conn = getConnection();
			
			String sql1 = "select * from product order by reg_date desc";
			String sql2 = "select * from product "
					+ "where product_kind=? order by reg_date desc";
			
			if(product_kind.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_kind);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				productList = new ArrayList<ShopProductDataBean>();
				do {
					ShopProductDataBean product = new ShopProductDataBean();
					
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_kind(rs.getString("product_kind"));
					product.setProduct_title(rs.getString("product_title"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_count(rs.getShort("product_count"));
					product.setBrand(rs.getString("brand"));
					product.setProduct_image(rs.getString("product_image"));
					product.setDiscount_rate(rs.getByte("discount_rate"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					
					productList.add(product);
				} while(rs.next());
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
		
		return productList;
	}
	
	public ShopProductDataBean[] getProducts(String product_kind, int count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ShopProductDataBean[] productList = null;
		int i = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select * from product where product_kind=?"
					+ "order by reg_date desc limit ?,?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, count);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				productList = new ShopProductDataBean[count];
				do {
					ShopProductDataBean product = new ShopProductDataBean();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_kind(rs.getString("product_kind"));
					product.setProduct_title(rs.getString("product_title"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_count(rs.getShort("product_count"));
					product.setBrand(rs.getString("brand"));
					product.setProduct_image(rs.getString("product_image"));
					product.setDiscount_rate(rs.getByte("discount_rate"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					
					productList[i] = product;
					
					i++;
				} while(rs.next());
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
		
		return productList;
	}
	
	public ShopProductDataBean getProduct(int productId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ShopProductDataBean product = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select * from product where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ShopProductDataBean();
				
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getShort("product_count"));
				product.setBrand(rs.getString("brand"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_content(rs.getString("product_content"));
				product.setDiscount_rate(rs.getByte("discount_rate"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
		
		return product;
	}
	
	public void updateProduct(ShopProductDataBean product, int productId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn = getConnection();
			
			sql = "update product set product_kind=?, product_title=?, product_price=?, "
					+ "product_count=?, brand=?, product_image=?, product_content=?, "
					+ "discount_rate=? where product_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_title());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setShort(4, product.getProduct_count());
			pstmt.setString(5, product.getBrand());
			pstmt.setString(6, product.getProduct_image());
			pstmt.setString(7, product.getProduct_content());
			pstmt.setByte(8, product.getDiscount_rate());
			pstmt.setInt(9, productId);
			
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
	}
	
	public void deleteProduct(int productId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "delete from product where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException ex) {
					
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch(SQLException es) {
					
				}
			}
		}
	}
	
}
