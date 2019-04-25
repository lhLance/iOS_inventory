package com.foxconn.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * ����ͼ������˽ӿڣ�ÿ�������ƣ��������ô˷�ʽ�����ͷ�������
 * @author Lance
 *
 */
public class TalkUtil {

    //�����˶�Ӧ��APIkey--ͼ��ƽ̨��ȡ
   public static final String API_KEY = "922a7bfffcd9463fbafa58d88d64d988";
   public static final String API_URL = "http://www.tuling123.com/openapi/api";

   /**
    * @param msg ��Ҫ���͵���Ϣ
    * @return
    */
   private String setParameter(String msg){
	   try {
           return API_URL + "?key=" + API_KEY + "&info=" + URLEncoder.encode(msg, "utf-8");
       } catch (UnsupportedEncodingException e) {
           e.printStackTrace();
       }
       return null;
   }

   /**
    * �õ���Ϣ�ظ�������
    * @param json ����ӿڵõ���JSON
    * @return text�Ĳ���
    */
   private String getString(String json){
       try {
           JSONObject object = new JSONObject(json);
           return object.getString("text");
       } catch (JSONException e) {
           e.printStackTrace();
       }
       return null;
   }

   /**
    * �ṩ���⹫���ķ������������õ������˻ظ�����Ϣ
    * @param msg ��������Ҫ���͵���Ϣ
    * @return �����˶���Ļظ�
    */
   public String getMessage(String msg){
       return getString(getHTML(setParameter(msg)));
   }


   private String getHTML(String url) {
       StringBuffer buffer = new StringBuffer();
       BufferedReader bufferedReader = null;
       try {
           URL u = new URL(url);
           HttpURLConnection connection = (HttpURLConnection) u.openConnection();
           bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
           String line = "";
           while ((line = bufferedReader.readLine()) != null) {
               buffer.append(line);
           }
       } catch (MalformedURLException e) {
           e.printStackTrace();
       } catch (IOException e) {
           e.printStackTrace();
       }finally {
           try {
               bufferedReader.close();
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
       //System.out.println(buffer.toString());
       return buffer.toString();
   }

   /*public static void main(String[] args) {
       TalkUtil util = new TalkUtil();
       Scanner scanner = new Scanner(System.in);//����̨����
       while (scanner.hasNext()){
           //ֱ����������˵Ļظ�
           System.err.println("Ta ����˵ ----> " + util.getMessage(scanner.nextLine()));
       }
   }*/

}
