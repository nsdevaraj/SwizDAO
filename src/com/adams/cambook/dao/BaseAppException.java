package com.adams.cambook.dao;


public class BaseAppException extends Exception {

    static final long serialVersionUID = -5829545098534135052L;

    private String exceptionMessage;



    public BaseAppException(String msg) {
        this.exceptionMessage = msg;
    }


    public BaseAppException(String msg, Throwable e) {
        this.exceptionMessage = msg;
        this.initCause(e);
    }


    public void setCause(Throwable e) {
        this.initCause(e);
    }

    public String toString() {
        String s = getClass().getName();
        return s + ": " + exceptionMessage;
    }


    public String getMessage() {
        return exceptionMessage;
    }
}