package shop.productshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BankDBBean {
	private static BankDBBean instance = new BankDBBean();
	
	public static BankDBBean getInstance() {
		return instance;
	}
	
	private BankDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp2");
		return ds.getConnection();
	}
	
	// bank 테이블에 계좌 등록
	public void insertAccount(BankDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "insert into bank values(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getAccount());
			pstmt.setString(3, member.getBank());
			pstmt.setTimestamp(4, member.getReg_date());
			
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException ex) {
					
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
	
	// 하나의 계정에 대해서 전체 계좌목록을 불러오는 메소드
	public List<String> getAccount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<String> accountList = null;
		String sql = "";
		try {
			conn = getConnection();
			
			sql = "select account, bank, name from "
					+ "member m inner join bank b on m.id = b.id "
					+ "where m.id = ? order by b.reg_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			accountList = new ArrayList<String>();
			
			while(rs.next()) {
				String account = new String(rs.getString("account") + " " 
			+ rs.getString("bank") + " " + rs.getString("name"));
				accountList.add(account);
			}
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
		return accountList;
	}
	
	public void insertBuy(List<CartDataBean> lists,
			String id, String account, String deliveryName, String deliveryTel,
			String deliveryAddress) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Timestamp reg_date = null;
		String sql = "";
		String maxDate = " ";
		String number = "";
		String todayDate = "";
		String compareDate = "";
		long buyId = 0;
		short nowCount;
		
		try {
			conn = getConnection();
			reg_date = new Timestamp(System.currentTimeMillis());
			todayDate = reg_date.toString();
			compareDate = todayDate.substring(0, 4) + todayDate.substring(5, 7) + 
					todayDate.substring(8, 10);
			
			sql = "select max(buy_id) from buy";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getLong(1) > 0) {
				Long val = new Long(rs.getLong(1));
				maxDate = val.toString().substring(0, 8);
				number = val.toString().substring(8);
				if(compareDate.equals(maxDate)) {
					if(Integer.parseInt(number)+1 < 10000) {
						buyId = Long.parseLong(maxDate + (Integer.parseInt(number) + 10000));
					} else {
						buyId = Long.parseLong(maxDate + (Integer.parseInt(number) + 1));
					}
				} else {
					compareDate += "00001";
					buyId = Long.parseLong(compareDate);
				}
			} else {
				compareDate += "00001";
				buyId = Long.parseLong(compareDate);
			}
			
			
			// 하나의 트랜잭션으로 처리
			conn.setAutoCommit(false);
			for(int i=0; i<lists.size(); i++) {
				//해당 아이디에 대한 cart테이블 레코드를 가져온후 buy테이블에 추가
				CartDataBean cart = lists.get(i);
				
				sql = "insert into buy(buy_id, buyer, product_id, product_title, buy_price,"
						+ "buy_count, product_image, buy_date, account, deliveryName,"
						+ "deliveryTel, deliveryAddress) values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, buyId);
				pstmt.setString(2, id);
				pstmt.setInt(3, cart.getProduct_id());
				pstmt.setString(4, cart.getProduct_title());
				pstmt.setInt(5, cart.getBuy_price());
				pstmt.setByte(6, cart.getBuy_count());
				pstmt.setString(7, cart.getProduct_image());
				pstmt.setTimestamp(8, reg_date);
				pstmt.setString(9, account);
				pstmt.setString(10, deliveryName);
				pstmt.setString(11, deliveryTel);
				pstmt.setString(12, deliveryAddress);
				pstmt.executeUpdate();
				
				sql = "select product_count from product where product_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cart.getProduct_id());
				rs = pstmt.executeQuery();
				rs.next();
				
				nowCount = (short)(rs.getShort(1) - cart.getBuy_count());
				
				sql = "update product set product_count=? where product_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setShort(1, nowCount);
				pstmt.setInt(2, cart.getProduct_id());
				pstmt.executeUpdate();
			}
			
			sql = "delete from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			conn.commit();
			conn.setAutoCommit(true);
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
			
			sql = "select count(*) from buy where buyer=?";
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
	
	public int getListCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int x = 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from buy";
			pstmt = conn.prepareStatement(sql);
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
	
	public List<BuyDataBean> getBuyList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BuyDataBean buy = null;
		String sql = "";
		List<BuyDataBean> lists = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from buy where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			lists = new ArrayList<BuyDataBean>();
			
			while(rs.next()) {
				buy = new BuyDataBean();
				
				buy.setBuy_id(rs.getLong("buy_id"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_title(rs.getString("product_title"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getByte("buy_count"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setSanction(rs.getString("sanction"));
				
				lists.add(buy);
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
	
	public List<BuyDataBean> getBuyList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BuyDataBean buy = null;
		String sql = "";
		List<BuyDataBean> lists = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from buy";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			lists = new ArrayList<BuyDataBean>();
			
			while(rs.next()) {
				buy = new BuyDataBean();
				
				buy.setBuy_id(rs.getLong("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_title(rs.getString("product_title"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getByte("buy_count"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setAccount(rs.getString("account"));
				buy.setDeliveryName(rs.getString("deliveryName"));
				buy.setDeliveryTel(rs.getString("deliveryTel"));
				buy.setDeliveryAddress(rs.getString("deliveryAddress"));
				buy.setSanction(rs.getString("sanction"));
				
				lists.add(buy);
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
	
	public void updateAccount(BankDataBean member, String account) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql="update bank set account=?, bank=?, reg_date=? "
					+ "where id=? and account=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getAccount());
			pstmt.setString(2, member.getBank());
			pstmt.setTimestamp(3, member.getReg_date());
			pstmt.setString(4, member.getId());
			pstmt.setString(5, account);
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
			if(conn != pstmt) {
				try {
					conn.close();
				} catch(SQLException ex) {
					
				}
			}
		}
	}
	
	public void deleteAccount(String id, String account) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "delete from bank where id=? and account=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, account);
			pstmt.executeUpdate();
			
//			sql = "select * from bank where id =?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				String rid = rs.getString("id");
//				if(rid.equals(id)) {
//					sql = "delete from bank where account=?";
//					pstmt = conn.prepareStatement(sql);
//					pstmt.setString(1, rs.getString("account"));
//					pstmt.executeUpdate();
//				}
//			}
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
