package dto;

import java.io.Serializable;

public class ProductDto implements Serializable {

	private int seq;
	private String p_name;
	private String p_info;
	private String p_material;
	private String p_madeIn;
	private int p_price;
	private String p_category;
	private int p_readcount;
	private int p_kind;
	private String filename;
	
	public ProductDto() {
	}
	
	public ProductDto(int seq, String p_name, String p_category, String filename) {
		this.seq = seq;
		this.p_name = p_name;
		this.p_category = p_category;
		this.filename = filename;
	}
	
	public ProductDto(int seq, String p_name, String p_info, String p_material, String p_madeIn, int p_price,
			String p_category, int p_readcount, int p_kind, String filename) {
		this.seq = seq;
		this.p_name = p_name;
		this.p_info = p_info;
		this.p_material = p_material;
		this.p_madeIn = p_madeIn;
		this.p_price = p_price;
		this.p_category = p_category;
		this.p_readcount = p_readcount;
		this.p_kind = p_kind;
		this.filename = filename;
	}

	public ProductDto(String p_name, String p_info, String p_material, String p_madeIn, int p_price, String p_category,
			int p_kind, String filename) {
		this.p_name = p_name;
		this.p_info = p_info;
		this.p_material = p_material;
		this.p_madeIn = p_madeIn;
		this.p_price = p_price;
		this.p_category = p_category;
		this.p_kind = p_kind;
		this.filename = filename;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_info() {
		return p_info;
	}

	public void setP_info(String p_info) {
		this.p_info = p_info;
	}

	public String getP_material() {
		return p_material;
	}

	public void setP_material(String p_material) {
		this.p_material = p_material;
	}

	public String getP_madeIn() {
		return p_madeIn;
	}

	public void setP_madeIn(String p_madeIn) {
		this.p_madeIn = p_madeIn;
	}

	public int getP_price() {
		return p_price;
	}

	public void setPrice(int p_price) {
		this.p_price = p_price;
	}

	public String getP_category() {
		return p_category;
	}

	public void setP_category(String p_category) {
		this.p_category = p_category;
	}

	public int getP_readcount() {
		return p_readcount;
	}

	public void setP_readcount(int p_readcount) {
		this.p_readcount = p_readcount;
	}

	public int getP_kind() {
		return p_kind;
	}

	public void setP_kind(int p_kind) {
		this.p_kind = p_kind;
	}
	

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public String toString() {
		return "ProductDto [seq=" + seq + ", p_name=" + p_name + ", p_info=" + p_info + ", p_material=" + p_material
				+ ", p_madeIn=" + p_madeIn + ", p_price=" + p_price + ", p_category=" + p_category + ", p_readcount="
				+ p_readcount + ", p_kind=" + p_kind + "filename="+filename+"]";
	}
}
