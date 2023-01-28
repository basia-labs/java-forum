/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.javaforum;

/**
 *
 * @author pawel
 */
public class User {

    public String id;
    public String email;
    public String password;
    public String nick;

    public User(String id, String email, String password, String nick) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.nick = nick;
    }

// <editor-fold defaultstate="collapsed" desc="get/set">

    public String getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getNick() {
        return nick;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }
    // </editor-fold>
}
