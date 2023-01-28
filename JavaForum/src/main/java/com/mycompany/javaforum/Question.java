/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.javaforum;

import java.util.LinkedList;

/**
 *
 * @author pawel
 */
public class Question {

    String id;
    String userId;
    String title;
    String content;
    String date;
    User questionAuthor;
    LinkedList<Answer> answers;

    public Question(String id, String userId, String title, String content, String date, User questionAuthor, LinkedList<Answer> answers) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.date = date;
        this.questionAuthor = questionAuthor;
        this.answers = answers;
    }
    
    // <editor-fold defaultstate="collapsed" desc="get/set">
    public void setId(String id) {
        this.id = id;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setQuestionAuthor(User questionAuthor) {
        this.questionAuthor = questionAuthor;
    }

    public void setAnswers(LinkedList<Answer> answers) {
        this.answers = answers;
    }

    public User getQuestionAuthor() {
        return questionAuthor;
    }

    public LinkedList<Answer> getAnswers() {
        return answers;
    }

    public String getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getDate() {
        return date;
    }
    // </editor-fold>
}
