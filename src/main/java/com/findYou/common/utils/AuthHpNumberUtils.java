package com.findYou.common.utils;

import java.util.HashMap;

import java.util.Random;



import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;



public class AuthHpNumberUtils {
  //랜덤
  private static String getKey(int size) {
      //size만큼 랜덤 숫자 생성
      Random random = new Random();
      StringBuffer buffer = new StringBuffer();
      int num = 0;

      while(buffer.length() < size) {
          num = random.nextInt(10);
          buffer.append(num);
      }

      return buffer.toString();
  }


  //인증값 보내기   
  public static String sendAuth() {
      //6자리 얻기

      String authKey = getKey(6);
        return authKey;
  }

	public static String Auth(String hp 
			) {
	 String send = "null";
	
    String api_key = "NCS2WEIUATTAFEOT";
    String api_secret = "IVCDLH2USUASSEUN8WADDKEQUFAFJASH";
    Message coolsms = new Message(api_key, api_secret);
    
    System.out.println(hp);
    // 4 params(to, from, type, text) are mandatory. must be filled
    HashMap<String, String> params = new HashMap<String, String>();
    params.put("to",hp );   //받는사람
    params.put("from", "01055742125");  //01028506698 번호 바꾸면 가능
    params.put("type", "SMS");
   	 send = sendAuth();
   	 
    params.put("text", send+" 인증 번호를 입력해주시기 바랍니다."); //보내는 문자
    params.put("app_version", "test app 1.2"); // application name and version

    try {
      JSONObject obj = (JSONObject) coolsms.send(params);
      System.out.println(obj.toString());
    } catch (CoolsmsException e) {
      System.out.println(e.getMessage());
      System.out.println(e.getCode());
    }
	return send;
  }
}