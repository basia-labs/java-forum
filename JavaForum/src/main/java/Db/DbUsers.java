/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Db;

import com.mycompany.javaforum.User;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author pawel
 */
public class DbUsers {

    public static User getDbUser(String email, String passwordHash)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT id,email,password,nick FROM users WHERE email = ? AND password = ?");

        st.setString(1, email);
        st.setString(2, passwordHash);

        //execute statement
        ResultSet rs = st.executeQuery();

        User user = getFromResultSet(rs);
        // Close all connections
        st.close();
        con.close();
        return user;
    }

    public static boolean insertUser(String email, String passwordHash, String nick) {
        //establish connection
        try {
            Connection con = DbConnection.initializeDatabase();

            //prepare statement
            PreparedStatement st = con.prepareStatement("INSERT INTO users (`email`, `password`, `nick`) VALUES (?, ?, ?)");

            st.setString(1, email);
            st.setString(2, passwordHash);
            st.setString(3, nick);
            st.executeUpdate();

            // Close all connections
            st.close();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static User findByEmail(String email)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT id,email,password,nick FROM users WHERE email = ?");

        st.setString(1, email);

        //execute statement
        ResultSet rs = st.executeQuery();
        
        User user = getFromResultSet(rs);
        // Close all connections
        st.close();
        con.close();
        return user;
    }

    public static User findByEmailOrNick(String email, String nick)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT id,email,password,nick FROM users WHERE email = ? OR nick = ?");

        st.setString(1, email);
        st.setString(2, nick);

        //execute statement
        ResultSet rs = st.executeQuery();

        User user = getFromResultSet(rs);
        // Close all connections
        st.close();
        con.close();
        return user;
    }

    private static User getFromResultSet(ResultSet rs) throws SQLException {
        if (rs.isBeforeFirst()) {
            rs.first();
            return new User(rs.getString("id"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("nick"));
        }
        return null;
    }
}
