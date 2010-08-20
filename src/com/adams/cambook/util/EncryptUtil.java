package com.adams.cambook.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.*;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class EncryptUtil {
	private Key key = null;

	public EncryptUtil() {
		Security.addProvider( new com.sun.crypto.provider.SunJCE() );
		byte[]keyBytes = new String("SRETBT23234SDFTR").getBytes();
        SecretKeySpec keyspec = new SecretKeySpec(keyBytes,0,16, "AES");
        key = keyspec;
	}
	
	public String getEncryptedString(String input) {
		String encrypted = null; 
		try {
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[]inputBytes = input.getBytes("UTF8");		//Encode
			byte[] outputBytes = cipher.doFinal(inputBytes);
			BASE64Encoder encoder = new BASE64Encoder();
			encrypted = encoder.encode(outputBytes);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return encrypted;
	}

	public String getDecryptedString(String input) {
		String decrypted = null; 
		try {
			System.out.println("encrypted input String: "+input);
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.DECRYPT_MODE, key);
			BASE64Decoder decoder = new BASE64Decoder();
			byte[] inputBytes = decoder.decodeBuffer(input);
			byte[] outputBytes = cipher.doFinal (inputBytes);
			decrypted = new String ( outputBytes, "UTF8" );
			System.out.println("decrypted String: "+decrypted);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return decrypted;
	}

	public static void main (String[] args) {
		EncryptUtil encryptUtil = new EncryptUtil();
		try {
			String encryptedString = encryptUtil.getEncryptedString("arnaud");
			String urlEncodedString = URLEncoder.encode(encryptedString, "UTF8");
			System.out.println("encryptedString:"+encryptedString);
			System.out.println("encryptedURLString:"+urlEncodedString);
			String urlDecodedString = URLDecoder.decode(urlEncodedString, "UTF8");
			String decryptedString = encryptUtil.getDecryptedString(urlDecodedString);
			System.out.println("decryptedString:"+decryptedString);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
