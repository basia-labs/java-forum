/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tags;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author pawel
 */
public class rating extends SimpleTagSupport {

    private int value;

    public void setValue(String val) {
        this.value = (int)Double.parseDouble(val);
    }

    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        String output = "<span class='text-primary'>";
        for (int i = 0; i < value; i++) {
            output += "★";
        }
        output += "</span><span class='text-dark'>";
        int blackStars = 10 - value;
        for (int i = 0; i < blackStars; i++) {
            output += "★";
        }
        output+="</span>";
        out.println(output);

    }
}
