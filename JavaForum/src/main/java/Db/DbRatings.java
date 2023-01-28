/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author pawel
 */
public class DbRatings {
        public static String getAnswerAvgRating(String answerId) 
            throws SQLException, ClassNotFoundException{
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT AVG(rate) as rate FROM ratings WHERE answerId = " + answerId);

        //execute statement
        ResultSet rs = st.executeQuery();
        if (rs.isBeforeFirst())
            rs.first();

        String output = rs.getString("rate");
        if(output == null || "".equals(output))
            output = "0";
        
        // Close all connections
        st.close();
        con.close();
        return output;
    }
        
    public static boolean hasUserRated(String answerId, String userId) 
            throws SQLException, ClassNotFoundException{
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT COUNT(id) as amount FROM ratings WHERE userId = ? AND answerId = ?");
        st.setString(1, userId);
        st.setString(2, answerId);
            
        //execute statement
        ResultSet rs = st.executeQuery();
        if (rs.isBeforeFirst())
            rs.first();

        boolean output = !"0".equals(rs.getString("amount"));
        
        // Close all connections
        st.close();
        con.close();
        return output;
    }
        
    public static boolean insertRating(String answerId, String userId, String rate) {
        //establish connection
        try {
            Connection con = DbConnection.initializeDatabase();

            //prepare statement
            PreparedStatement st = con.prepareStatement("INSERT INTO ratings (id, userId, answerId, rate) VALUES (NULL, ?, ?, ?)");

            st.setString(1, userId);
            st.setString(2, answerId);
            st.setString(3, rate);
            st.executeUpdate();

            // Close all connections
            st.close();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }
}
