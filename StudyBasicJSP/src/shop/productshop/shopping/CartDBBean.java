package shop.productshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance() {
		return instance;
	}
	
	private CartDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp2");
		return ds.getConnection();
	}
	
	public void insertCart(CartDataBean cart) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "insert into cart(product_id, buyer,"
					+ "product_title, buy_price, buy_count, product_image) "
					+ "values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getProduct_id());
			pstmt.setString(2, cart.getBuyer());
			pstmt.setString(3, cart.getProduct_title());
			pstmt.setInt(4,	cart.getBuy_price());
			pstmt.setByte(5, cart.getBuy_count());
			pstmt.setString(6, cart.getProduct_image());
			
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
	
	public int getListCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
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
	
	public List<CartDataBean> getCart(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDataBean cart = null;
		String sql = "";
		List<CartDataBean> lists = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			lists = new ArrayList<CartDataBean>();
			
			while(rs.next()) {
				cart = new CartDataBean();
				
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setProduct_id(rs.getInt("product_id"));
				cart.setProduct_title(rs.getString("product_title"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getByte("buy_count"));
				cart.setProduct_image(rs.getString("product_image"));
				
				lists.add(cart);
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
		
		return lists;
	}
	
	public void updateCount(int cart_id, byte count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "update cart set buy_count=? where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setByte(1, count);
			pstmt.setInt(2, cart_id);
			
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
	
	public void deleteList(int cart_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "delete from cart where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			
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
	
	public void deleteAll(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "delete from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
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

}
