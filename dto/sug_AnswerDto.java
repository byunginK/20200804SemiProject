package dto;

import java.io.Serializable;

public class sug_AnswerDto implements Serializable {

	private int answer_Seq;
	private int suggest_Seq;
	private String answer_Id;
	private String content;
	private String answer_Wdate;
	private int del;
	
	
	public sug_AnswerDto() {

	}
	
	
	public sug_AnswerDto(int suggest_Seq, String answer_Id, String content) {
		super();
		this.suggest_Seq = suggest_Seq;
		this.answer_Id = answer_Id;
		this.content = content;
	}


	public sug_AnswerDto(int answer_Seq, int suggest_Seq, String answer_Id, String content, String answer_Wdate, int del) {
		super();
		this.answer_Seq = answer_Seq;
		this.suggest_Seq = suggest_Seq;
		this.answer_Id = answer_Id;
		this.content = content;
		this.answer_Wdate = answer_Wdate;
		this.del = del;
	}

	public int getAnswer_Seq() {
		return answer_Seq;
	}


	public void setAnswer_Seq(int answer_Seq) {
		this.answer_Seq = answer_Seq;
	}


	public int getSuggest_Seq() {
		return suggest_Seq;
	}


	public void setSuggest_Seq(int suggest_Seq) {
		this.suggest_Seq = suggest_Seq;
	}

	public String getAnswer_Id() {
		return answer_Id;
	}


	public void setAnswer_Id(String answer_Id) {
		this.answer_Id = answer_Id;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getAnswer_Wdate() {
		return answer_Wdate;
	}


	public void setAnswer_Wdate(String anawer_Wdate) {
		this.answer_Wdate = anawer_Wdate;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}
	
	
	
}
