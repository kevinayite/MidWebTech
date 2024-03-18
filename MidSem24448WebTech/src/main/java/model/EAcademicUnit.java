package model;

public enum EAcademicUnit {
	PROGRAM("Program"),
	FACULTY("Faculty"),
	DEPARTMENT("Department");
	
	private final String info;

	EAcademicUnit(String info){
	    this.info = info;
	}

	public String getInfo() {
		return info;
	}

	


}
