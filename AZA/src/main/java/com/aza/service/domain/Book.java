package com.aza.service.domain;

public class Book {

    private String isbn;
    private String bookTitle;
    private String publisher;
    private String bookPrice;
    private String author;
    private String bookYear;
    private String bookImg;
    
    public Book() {}
    
    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(String bookPrice) {
        this.bookPrice = bookPrice;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBookYear() {
        return bookYear;
    }

    public void setBookYear(String bookYear) {
        this.bookYear = bookYear;
    }

    public String getBookImg() {
        return bookImg;
    }

    public void setBookImg(String bookImg) {
        this.bookImg = bookImg;
    }
    
    public String toString() {
    	return "Book [isbn= "+isbn+", bookTitle= "+bookTitle+"publisher= "+publisher+
    			"bookPrice= "+bookPrice+", author= "+author+", bookYear= "+bookYear+
    			"bookImg= "+bookImg+"]";
    }

}