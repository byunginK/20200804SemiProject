package dto;

import java.io.Serializable;

public class loginDto implements Serializable {
   
	 private String id;
     private int auth;
     
     
     public loginDto() {
	    
	      }
  public loginDto(String id, int auth) {
	super();
	this.id = id;
	this.auth = auth;
  
  }
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public int getAuth() {
	return auth;
}
public void setAuth(int auth) {
	this.auth = auth;
}
   
   
}
