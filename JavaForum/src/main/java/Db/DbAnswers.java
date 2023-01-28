/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Db;

import com.mycompany.javaforum.Answer;
import com.mycompany.javaforum.User;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

/**
 *
 * @author pawel
 */
public class DbAnswers {
    
    public static String getAnswersAmount() 
            throws SQLException, ClassNotFoundException{
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT COUNT(id) as amount FROM answers");

        //execute statement
        ResultSet rs = st.executeQuery();
        if (rs.isBeforeFirst())
            rs.first();

        String output = rs.getString("amount");
        
        // Close all connections
        st.close();
        con.close();
        return output;
    }
    
    public static Answer getDbAnswer(String id)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement("SELECT id, userId, title, content, date FROM answers WHERE id = ?");

        st.setString(1, id);

        //execute statement
        ResultSet rs = st.executeQuery();

        Answer answer = getFromResultSet(rs);
        // Close all connections
        st.close();
        con.close();
        return answer;
    }

    public static LinkedList<Answer> getDbAnswersList(String questionId)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        return getDbAnswersListByStatement("SELECT answers.id, content, answers.date, userId, nick, questionId "
                + "FROM answers "
                + "LEFT JOIN USERS on users.id = answers.userId "
                + "WHERE answers.questionId = " + questionId);
    }

    public static LinkedList<Answer> getDbAnswersListByStatement(String statement)
            throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        LinkedList<Answer> output = new LinkedList<>();
        //establish connection
        Connection con = DbConnection.initializeDatabase();

        //prepare statement
        PreparedStatement st = con.prepareStatement(statement);

        //execute statement
        ResultSet rs = st.executeQuery();

        //put results to list
        while (rs.next()) {
            output.add(buildQuestionFromResult(rs));
        }

        // Close all connections
        st.close();
        con.close();
        return output;
    }

    public static boolean insertAnswer(String questionId, String userId, String content) {
        //establish connection
        try {
            Connection con = DbConnection.initializeDatabase();

            //prepare statement
            PreparedStatement st = con.prepareStatement("INSERT INTO `answers` (`id`, `questionId`, `userId`, `content`, `date`) VALUES (NULL, ?, ?, ?, current_timestamp())");

            st.setString(1, questionId);
            st.setString(2, userId);
            st.setString(3, content);
            st.executeUpdate();

            // Close all connections
            st.close();
            con.close();
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    private static Answer getFromResultSet(ResultSet rs) throws SQLException {
        if (rs.isBeforeFirst()) {
            rs.first();
            return buildQuestionFromResult(rs);
        }
        return null;
    }

    private static Answer buildQuestionFromResult(ResultSet rs) throws NumberFormatException, SQLException {
        //get nick if exist in rs
        String nick = "";
        try{
            nick = rs.getString("nick");
        }catch(Exception e){ }
        
        //build answer object
        User author = new User(rs.getString("userId"), "", "", nick);
        return new Answer(rs.getString("id"),
                rs.getString("questionId"),
                rs.getString("userId"),
                rs.getString("content"),
                rs.getString("date"),
                author);
    }
}
