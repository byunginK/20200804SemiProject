package dto;

import java.io.Serializable;
/*CREATE FIVE_REPLY(
		SEQ NUMBER(8) PRIMARY KEY,
		QNA_SEQ NUMBER(8),
		ID VARCHAR2(50) NOT NULL,
		WDATE VARCHAR2(50) NOT NULL,
		SECRET NUMBER(1),
		UDATE VARCHAR2(50) NOT NULL,
		CATEGORY_SEQ NUMBER(10),
		CONTENTS VARCHAR2(4000)
	);*/
public class ReplyDto implements Serializable {

	private int seq;
	private int qna_seq;
	private String id;
	private String wdate;
	private int secret;
	private String udate;
	private int category_seq;
	private String contents;
	
	public ReplyDto() {
	}

	public ReplyDto(int seq, int qna_seq, String id, String wdate, int secret, String udate, int category_seq,
			String contents) {
		this.seq = seq;
		this.qna_seq = qna_seq;
		this.id = id;
		this.wdate = wdate;
		this.secret = secret;
		this.udate = udate;
		this.category_seq = category_seq;
		this.contents = contents;
	}
	//추가
	public ReplyDto(int seq, int qna_seq, String id, String contents,String wdate) {
		this.seq = seq;
		this.qna_seq = qna_seq;
		this.id = id;
		this.contents = contents;
		this.wdate = wdate;
	}
	
	public ReplyDto(int seq, String id, String wdate, String contents) {
		this.seq = seq;
		this.id = id;
		this.wdate = wdate;
		this.contents = contents;
	}

	public ReplyDto(int qna_seq, String id, int category_seq, String contents) {
		this.qna_seq = qna_seq;
		this.id = id;
		this.category_seq = category_seq;
		this.contents = contents;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getQna_seq() {
		return qna_seq;
	}

	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getSecret() {
		return secret;
	}

	public void setSecret(int secret) {
		this.secret = secret;
	}

	public String getUdate() {
		return udate;
	}

	public void setUdate(String udate) {
		this.udate = udate;
	}

	public int getCategory_seq() {
		return category_seq;
	}

	public void setCategory_seq(int category_seq) {
		this.category_seq = category_seq;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@Override
	public String toString() {
		return "ReplyDto [seq=" + seq + ", qna_seq=" + qna_seq + ", id=" + id + ", wdate=" + wdate + ", secret="
				+ secret + ", udate=" + udate + ", category_seq=" + category_seq + ", contents=" + contents + "]";
	}
	
}
