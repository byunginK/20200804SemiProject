package dto;

import java.io.Serializable;

public class cartDto implements Serializable {
	private int seq;
	private String id;
	private int item_seq;
	private String item_name;
	private int item_price;
	private int qty;
	private String filename;
	private String color;
	private String size;
	
	public cartDto() {
	}

	public cartDto(int seq, String id, int item_seq, String item_name, int item_price, int qty,String filename, String color, String size) {
		this.seq = seq;
		this.id = id;
		this.item_seq = item_seq;
		this.item_name = item_name;
		this.item_price = item_price;
		this.qty = qty;
		this.filename = filename;
		this.color = color;
		this.size = size;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
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

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getItem_price() {
		return item_price;
	}

	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	@Override
	public String toString() {
		return "cartDto [seq=" + seq + ", id=" + id + ", item_seq=" + item_seq + ", item_name=" + item_name
				+ ", item_price=" + item_price + ", qty=" + qty + "]";
	}
	
}
