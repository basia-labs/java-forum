/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.javaforum;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.xml.sax.SAXException;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

/**
 *
 * @author pawel
 */
public class Helpers {
    /**
     * get current date
     * @return 
     */
    public static String getDate(){
            LocalDate dateObj = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String date = dateObj.format(formatter);
            
            return date;
    }
    /**
     * return hashed string
     *
     * @param passwordToHash
     * @return
     * @throws NoSuchAlgorithmException
     */
    public static String hash(String passwordToHash) throws NoSuchAlgorithmException {
        // Create MessageDigest instance for MD5
        MessageDigest md = MessageDigest.getInstance("MD5");
        // Add password bytes to digest
        md.update(passwordToHash.getBytes());
        // Get the hash's bytes
        byte[] bytes = md.digest();
        // This bytes[] has bytes in decimal format. Convert it to hexadecimal format
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }

        return sb.toString();
    }

    public static NodeList getNodeList(String xmlUrl, String xPathExp)
            throws IOException, SAXException, XPathExpressionException, ParserConfigurationException {
        Document doc = getXMLDoc(xmlUrl);

        //search XML
        XPathFactory xFactory = XPathFactory.newInstance();
        XPath xPath = xFactory.newXPath();

        XPathExpression exp = xPath.compile(xPathExp);
        NodeList nodeList = (NodeList) exp.evaluate(doc, XPathConstants.NODESET);
        return nodeList;
    }

    public static Document getXMLDoc(String XML_PATH)
            throws SAXException, ParserConfigurationException, IOException {
        //get file
        File file = new File(XML_PATH);
        //parse XML
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(file);
        doc.getDocumentElement().normalize();
        return doc;
    }
}
