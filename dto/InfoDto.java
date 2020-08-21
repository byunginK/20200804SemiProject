package dto;

import java.io.Serializable;

/*
CREATE TABLE FIVE_INFO(
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	TITLE VARCHAR2(2000) NOT NULL,
	CONTENT VARCHAR2(5000) NOT NULL,
	WDATE DATE NOT NULL
);
 */
public class InfoDto implements Serializable{
	private int seq;
	private String id;
	private String title;
	private String content;
	private String wdate;
	
	public InfoDto() {
	}
	public InfoDto(int seq, String id, String title, String content, String wdate) {
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
	}
	public InfoDto(String id, String title, String content) {
		this.id = id;
		this.title = title;
		this.content = content;
	}
	//추가
	public InfoDto(int seq, String title, String content) {
		this.seq = seq;
		this.title = title;
		this.content = content;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	@Override
	public String toString() {
		return "InfoDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ "]";
	}
}
