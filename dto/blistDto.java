package dto;

import java.io.Serializable;

public class blistDto implements Serializable {
	private int seq;
	private String title;
	private String contents;
	private int part_seq;
	private String part_name;
	private String id;
	private int secret;
	private String wdate;
	private String udate;
	
	public blistDto() {}
	
	public blistDto(int seq,String id, String title, String udate) {
		this.seq = seq;
		this.title = title;
		this.id = id;
		this.udate = udate;
	}

	public blistDto(int seq, String title, String contents, int part_seq, String id, int secret) {
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.part_seq = part_seq;
		this.id = id;
		this.secret = secret;
	}

	public blistDto(String id, int secret) {
		this.id = id;
		this.secret = secret;
	}

	public blistDto(int seq, String title, String contents, String part_name, String id) {
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.part_name = part_name;
		this.id = id;
	}

	public blistDto(int seq, String title, String contents, int part_seq, String id, int secret, String wdate) {
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.part_seq = part_seq;
		this.id = id;
		this.secret = secret;
		this.wdate = wdate;
	}

	public blistDto(String title, String contents, int part_seq, String id, int secret) {
		this.title = title;
		this.contents = contents;
		this.part_seq = part_seq;
		this.id = id;
		this.secret = secret;
	}
	public int getSeq() {
		return seq;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getPart_seq() {
		return part_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getUdate() {
		return udate;
	}
	public void setUdate(String udate) {
		this.udate = udate;
	}
	public String getPart_name() {
		return part_name;
	}

	public void setPart_name(String part_name) {
		this.part_name = part_name;
	}

	@Override
	public String toString() {
		return "blistDto [seq=" + seq + ", title=" + title + ", contents=" + contents + ", part_seq=" + part_seq
				+ ", id=" + id + ", secret=" + secret + ", wdate=" + wdate + ", udate=" + udate + "]";
	}
	
}
