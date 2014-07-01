package com.example.nefs;

public class Event {
	
	String eTitle;
	String eMonth;
	String eDay;
	String eTime;
	String eDesc;
	String eLink;
	
	public void setTitle(String title){
		 eTitle= title;
	}
	
	public void setMonth(String month){
		 eMonth= month;
	}
	
	public void setDay(String day){
		 eDay= day;
	}
	
	public void setTime(String time){
		 eTime= time;
	}
	
	public void setDesc(String desc){
		eDesc = desc;
	}
	
	public void setLink(String link){
		 eLink= link;
	}
	
	public String getTitle(){
		return eTitle;
	}
	
	public String getMonth(){
		return eMonth;
	}
	
	public String getDay(){
		return eDay;
	}
}
