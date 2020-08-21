package dto;

import java.io.Serializable;

public class calendarDto implements Serializable {
	
	private int seq;
	private String contents;
	private String caldate;
	
	public calendarDto() {
	}

	public calendarDto(int seq, String contents, String cdate){
		this.seq = seq;
		this.contents = contents;
		this.caldate = cdate;
	}
	
	public calendarDto(String contents, String caldate) {
		this.contents = contents;
		this.caldate = caldate;
	}

	public void setSeq(int seq){
		this.seq = seq;
	}
	public int getSeq(){
		return seq;
	}
	public void setContents(String contents){
		this.contents = contents;
	}
	public String getContents(){
		return contents;
	}
	public void setCdate(String cdate){
		this.caldate = cdate;
	}
	public String getCdate(){
		return caldate;
	}
	public String toString(){
		return "seq ="+seq+", contents="+contents+", cdate="+caldate;
	}

}
