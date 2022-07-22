package com.aza.service.domain;

public class LessonBook {

    private int bookCode;
    private String lessonCode;
    private String isbn;
    
    public int getBookCode() {
        return bookCode;
    }

    public void setBookCode(int bookCode) {
        this.bookCode = bookCode;
    }

    public String getLessonCode() {
        return lessonCode;
    }

    public void setLessonCode(String lessonCode) {
        this.lessonCode = lessonCode;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String toString() {
    	return "Lesson bookCode="+bookCode+", lessonCode= "+lessonCode+", isbn= "+isbn+"]";
    }
}
