package com.aza.service.domain;

public class Schedule {

	private int scheduleCode;
    private String scheduleStartDate;
    private String start;
    private String end;
    private String scheduleEndDate;
    private String scheduleContent;
    private String teacherId;
    private String title;
    
    private User teacherName;
    
    private Students studentId;

    public String getScheduleStartDate() {
        return scheduleStartDate;
    }

    public void setScheduleStartDate(String scheduleStartDate) {
        this.scheduleStartDate = scheduleStartDate;
    }

    public int getScheduleCode() {
        return scheduleCode;
    }

    public void setScheduleCode(int scheduleCode) {
        this.scheduleCode = scheduleCode;
    }

//    public String getScheduleStartTime() {
//        return scheduleStartTime;
//    }
//
//    public void setScheduleStartTime(String scheduleStartTime) {
//        this.scheduleStartTime = scheduleStartTime;
//    }
//
//    public String getScheduleEndTime() {
//        return scheduleEndTime;
//    }
//
//    public void setScheduleEndTime(String scheduleEndTime) {
//        this.scheduleEndTime = scheduleEndTime;
//    }

    public String getScheduleEndDate() {
        return scheduleEndDate;
    }

    public void setScheduleEndDate(String scheduleEndDate) {
        this.scheduleEndDate = scheduleEndDate;
    }

    public String getScheduleContent() {
        return scheduleContent;
    }

    public void setScheduleContent(String scheduleContent) {
        this.scheduleContent = scheduleContent;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

//	public String getScheduleTitle() {
//		return scheduleTitle;
//	}
//
//	public void setScheduleTitle(String scheduleTitle) {
//		this.scheduleTitle = scheduleTitle;
//	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public User getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(User teacherName) {
		this.teacherName = teacherName;
	}

	public Students getStudentId() {
		return studentId;
	}

	public void setStudentId(Students studentId) {
		this.studentId = studentId;
	}

	@Override
	public String toString() {
		return "Schedule [scheduleCode=" + scheduleCode + ", scheduleStartDate=" + scheduleStartDate + ", start="
				+ start + ", end=" + end + ", scheduleEndDate=" + scheduleEndDate + ", scheduleContent="
				+ scheduleContent + ", teacherId=" + teacherId + ", title=" + title + ", teacherName=" + teacherName
				+ ", studentId=" + studentId + "]";
	}
    
	

}