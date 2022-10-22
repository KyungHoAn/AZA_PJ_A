package com.aza.service.domain;


public class Lesson {

    @Override
	public String toString() {
		return "Lesson [lessonCode=" + lessonCode + ", lessonName=" + lessonName + ", lessonDay=" + lessonDay
				+ ", lessonStartTime=" + lessonStartTime + ", lessonEndTime=" + lessonEndTime + ", lessonPlace="
				+ lessonPlace + ", fees=" + fees + ", subject=" + subject + ", teacherId=" + teacherId
				+ ", lessonContent=" + lessonContent + ", lessonCreateAt=" + lessonCreateAt + ", isbn=" + isbn
				+ ", bookTitle=" + bookTitle + ", publisher=" + publisher + ", bookPrice=" + bookPrice + ", author="
				+ author + ", bookYear=" + bookYear + ", bookImg=" + bookImg + ", bookCode=" + bookCode + ", studentId="
				+ studentId + ", proposal=" + proposal + ", teacherName=" + teacherName + "]";
	}

	private String lessonCode;
    private String lessonName;
    private String lessonDay;
    private String lessonStartTime;
    private String lessonEndTime;
    private String lessonPlace;
    private int fees;
    private String subject;
    private String teacherId;
    private String lessonContent;
    private String lessonCreateAt;
    
    private String isbn;
    private String bookTitle;
    private String publisher;
    private String bookPrice;
    private String author;
    private String bookYear;
    private String bookImg;
    
    private int bookCode;
    
    private User teacherName;
    
    private Students studentId;
    private Students proposal;
    
    public Lesson() {
    }
    
    public User getTeacherName() {
    	return teacherName;
    }
    public void setTeacherName(User teacherName) {
    	this.teacherName = teacherName;
    }
    
    public String getLessonCode() {
        return lessonCode;
    }

    public void setLessonCode(String lessonCode) {
        this.lessonCode = lessonCode;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public String getLessonDay() {
        return lessonDay;
    }

    public void setLessonDay(String lessonDay) {
        this.lessonDay = lessonDay;
    }

    public String getLessonStartTime() {
        return lessonStartTime;
    }

    public void setLessonStartTime(String lessonStartTime) {
        this.lessonStartTime = lessonStartTime;
    }

    public String getLessonEndTime() {
        return lessonEndTime;
    }

    public void setLessonEndTime(String lessonEndTime) {
        this.lessonEndTime = lessonEndTime;
    }

    public String getLessonPlace() {
        return lessonPlace;
    }

    public void setLessonPlace(String lessonPlace) {
        this.lessonPlace = lessonPlace;
    }

    public int getFees() {
        return fees;
    }

    public void setFees(int fees) {
        this.fees = fees;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getLessonContent() {
        return lessonContent;
    }

    public void setLessonContent(String lessonContent) {
        this.lessonContent = lessonContent;
    }

    public String getLessonCreateAt() {
        return lessonCreateAt;
    }

    public void setLessonCreateAt(String lessonCreateAt) {
        this.lessonCreateAt = lessonCreateAt;
    }

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(Object object) {
		this.bookTitle = (String) object;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(Object object) {
		this.isbn = (String) object;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(Object object) {
		this.publisher = (String) object;

	}

	public String getBookPrice() {
		return bookPrice;
	}

	public void setBookPrice(Object object) {
		this.bookPrice = (String) object;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(Object object) {
		this.author = (String) object;
	}

	public String getBookYear() {
		return bookYear;
	}

	public void setBookYear(Object object) {
		this.bookYear = (String) object;
	}

	public String getBookImg() {
		return bookImg;
	}

	public void setBookImg(Object object) {
		this.bookImg = (String) object;
	}

	public int getBookCode() {
		return bookCode;
	}

	public void setBookCode(int bookCode) {
		this.bookCode = bookCode;
	}

	public Students getStudentId() {
		return studentId;
	}

	public void setStudentId(Students studentId) {
		this.studentId = studentId;
	}


	public Students getProposal() {
		return proposal;
	}

	public void setProposal(Students proposal) {
		this.proposal = proposal;
	}
}