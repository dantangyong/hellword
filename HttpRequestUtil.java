package com.mht.define.portal.cms.utils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mht.common.json.AjaxJson;
import com.mht.common.utils.PropertiesLoader;

//import net.sf.json.JSONObject;
/**
 * 发起http请求并获取结果
 * 
 * @author zyz
 * @date 20140522
 *
 */
public class HttpRequestUtil {
	/**
	 * 发起http请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static AjaxJson httpRequest(String requestUrl, String requestMethod, String outputStr) {
		AjaxJson json = new AjaxJson();
		StringBuffer buffer = new StringBuffer();
		InputStream inputStream = null;
		try {
			URL url = new URL(requestUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			// if (null != outputStr) {
			OutputStream outputStream = httpUrlConn.getOutputStream();
			// 注意编码格式，防止中文乱码
			outputStream.write(outputStr.getBytes("UTF-8"));
			outputStream.close();
			// }
			// 将返回的输入流转换成字符串
			inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			json.put("result", buffer.toString());

		} catch (ConnectException ce) {
			ce.printStackTrace();
			System.out.println("Weixin server connection timed out");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("http request error:{}");
		} finally {
			try {
				if (inputStream != null) {
					inputStream.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return json;
	}

	/**
	 * 从网络获取json数据,(String byte[})
	 * 
	 * @param path
	 * @return
	 */
	private static Logger logger = LoggerFactory.getLogger(HttpRequestUtil.class);

	public static String getJsonByInternet(String path) {
		try {
			URL url = new URL(path.trim());
			// 打开连接
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			logger.debug(urlConnection.getResponseCode() + "--------------");
			if (200 == urlConnection.getResponseCode()) {
				// 得到输入流
				InputStream is = urlConnection.getInputStream();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buffer = new byte[1024];
				int len = 0;
				while (-1 != (len = is.read(buffer))) {
					baos.write(buffer, 0, len);
					baos.flush();
				}
				return baos.toString("utf-8");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String getJsonInternetBy(String path) throws Exception {
		
		HttpURLConnection urlConnection;
		try {
			URL url = new URL(path.trim());
			if("https".equalsIgnoreCase(url.getProtocol())){  
	            SSLUtils.ignoreSsl();  
	        } 
			// 打开连接
			urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestProperty("X-WEBSRV-APP", "86e3ebc10b6c0f4914436035686cd820");
			urlConnection.setRequestProperty("X-WEBSRV-KEY", "86e5f6e8d9289d249787a6555aac5ee3");
			logger.debug(urlConnection.getResponseCode() + "--------------");
			if (200 == urlConnection.getResponseCode()) {
				// 得到输入流
				InputStream is = urlConnection.getInputStream();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buffer = new byte[1024];
				int len = 0;
				while (-1 != (len = is.read(buffer))) {
					baos.write(buffer, 0, len);
					baos.flush();
				}
				return baos.toString("utf-8");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	* @Title: getUrlByProperties
	* @Description: ◕ᴗ◕✿ TODO(根据配置文件名称及key获取value)
	* @param fileName
	* @param key
	* @return  
	* String  
	*/
	public static String getUrlByProperties(String fileName,String key){
		PropertiesLoader p = new PropertiesLoader(fileName);
		return p.getProperty(key);
	}

}
