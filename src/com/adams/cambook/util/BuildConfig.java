package com.adams.cambook.util;

import com.adams.cambook.dao.hibernate.CambookPageDAO;

public final class BuildConfig {
	
	public static String serverAddress = null;
	public static String serverPort = null;
	public static String db = "MYSQL";
	
	public static String smtpMailFromUser = null;
	public static String smtpMailFromPass = null;
	public static String smtpMailHostName = null;
	public static String smtpMailHostPort = null;
	public static boolean smtpMailStarttlsEnable = true;
	public static boolean smtpMailIsSSL = true;
	public static boolean smtpMailAuth = true;
	public static boolean smtpMailDebugging = true;
	public static String smtpMailMailLabel = null;
	
	public static CambookPageDAO cambookPageDAO = null;
	public static String applicationContext = null;
}