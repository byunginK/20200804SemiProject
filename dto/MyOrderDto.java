package dto;

import java.io.Serializable;

public class MyOrderDto implements Serializable {

	private int seq;
	private String id;
	private int item_seq;
	private int qty;
	private String item_size;
	private String color;
	private String p_name;
	private int p_price;
	private String filename;
	
	public MyOrderDto() {
	}

	public MyOrderDto(int seq, String id, int item_seq, int qty, String item_size, String color, String p_name,
			int p_price, String filename) {
		super();
		this.seq = seq;
		this.id = id;
		this.item_seq = item_seq;
		this.qty = qty;
		this.item_size = item_size;
		this.color = color;
		this.p_name = p_name;
		this.p_price = p_price;
		this.filename = filename;
	}

	public MyOrderDto(String id, int item_seq, int qty, String item_size, String color, String p_name, int p_price,
			String filename) {
		super();
		this.id = id;
		this.item_seq = item_seq;
		this.qty = qty;
		this.item_size = item_size;
		this.color = color;
		this.p_name = p_name;
		this.p_price = p_price;
		this.filename = filename;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getItem_seq() {
		return item_seq;
	}

	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getItem_size() {
		return item_size;
	}

	public void setItem_size(String item_size) {
		this.item_size = item_size;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getP_price() {
		return p_price;
	}

	public void setP_price(int p_price) {
		this.p_price = p_price;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public String toString() {
		return "MyOrderDto [seq=" + seq + ", id=" + id + ", item_seq=" + item_seq + ", qty=" + qty + ", item_size="
				+ item_size + ", color=" + color + ", p_name=" + p_name + ", p_price=" + p_price + ", filename="
				+ filename + "]";
	}
	
}
