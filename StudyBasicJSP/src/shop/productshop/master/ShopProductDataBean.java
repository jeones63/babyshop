package shop.productshop.master;

import java.sql.Timestamp;

public class ShopProductDataBean {
	private int product_id;
	private String product_kind;
	private String product_title;
	private int product_price;
	private short product_count;
	private String brand;
	private String product_image;
	private String product_content;
	private byte discount_rate;
	private Timestamp reg_date;

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getProduct_kind() {
		return product_kind;
	}

	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public short getProduct_count() {
		return product_count;
	}

	public void setProduct_count(short product_count) {
		this.product_count = product_count;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public byte getDiscount_rate() {
		return discount_rate;
	}

	public void setDiscount_rate(byte discount_rate) {
		this.discount_rate = discount_rate;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

}
