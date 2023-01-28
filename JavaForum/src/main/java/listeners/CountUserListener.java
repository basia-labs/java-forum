/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package listeners;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author pawel
 */
public class CountUserListener implements HttpSessionListener, HttpSessionAttributeListener {

    final String LOGGED = "logged";
    final String ACTIVE = "active";
    ServletContext ctx = null;
    static int active = 0;
    static int logged = 0;

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        se.getSession().setMaxInactiveInterval(120); // in seconds
        active++;
        ctx = se.getSession().getServletContext();
        synchronized (ctx) {
            ctx.setAttribute(ACTIVE, active);
            ctx.setAttribute(LOGGED, logged);
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        active--;
        synchronized (ctx) {
            ctx.setAttribute(ACTIVE, active);
        }
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if (ctx == null) {
            return;
        }
        if (!"user".equals(event.getName())) {
            return;
        }
        logged++;
        synchronized (ctx) {
            ctx.setAttribute(LOGGED, logged);
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        if (ctx == null) {
            return;
        }
        if (!"user".equals(event.getName())) {
            return;
        }
        logged--;
        synchronized (ctx) {
            ctx.setAttribute(LOGGED, logged);
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {

    }
}
