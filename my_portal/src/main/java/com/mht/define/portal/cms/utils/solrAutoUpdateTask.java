package com.mht.define.portal.cms.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jcraft.jsch.Logger;
import com.mht.common.config.Global;

/**
 * solr定时更新Controller
 * 
 * @author dty
 * @version 2017-11-29
 */
@Component
public class solrAutoUpdateTask {
	/**
	 * 日志对象
	 */
	private org.slf4j.Logger logger = LoggerFactory.getLogger(getClass());
	/*
	 * 获取solr地址
	 */
	private String url = Global.getConfig("solr_url");

	@Scheduled(cron = "${schedule_time}") // 间隔180秒执行
	public void updateNews() {
		String newsUrl = url
				+ "/news/dataimport?command=full-import&verbose=false&clean=true&commit=true&optimize=false&core=news&name=dataimport";
		URL news_url;
		HttpURLConnection newsConnection = null;
		try {
			news_url = new URL(newsUrl);
			newsConnection = (HttpURLConnection) news_url.openConnection();
			newsConnection.connect();
			String result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(newsConnection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			in.close();
			String s =result.substring(result.indexOf("Indexing"), result.lastIndexOf(".</str>")) ;
			logger.info("----------------------------solr-news:"+s);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != newsConnection) {
				newsConnection.disconnect();
			}
		}
		

	}

	@Scheduled(cron = "${schedule_time}") // 间隔180秒执行
	public void updateService() {
		String serviceUrl = url
				+ "/service/dataimport?command=full-import&verbose=false&clean=true&commit=true&optimize=false&core=service&name=dataimport";
		URL service_url;
		HttpURLConnection serviceConnection = null;
		try {
			service_url = new URL(serviceUrl);
			serviceConnection = (HttpURLConnection) service_url.openConnection();
			serviceConnection.connect();
			String result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(serviceConnection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			in.close();
			String s =result.substring(result.indexOf("Indexing"), result.lastIndexOf(".</str>")) ;
			logger.info("----------------------------solr-service:"+s);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != serviceConnection) {
				serviceConnection.disconnect();
			}

		}
		

	}
	@Scheduled(cron = "${schedule_time}") // 间隔180秒执行
	public void updateVideo() {
		String videoUrl = url
				+ "/video/dataimport?command=full-import&verbose=false&clean=true&commit=true&optimize=false&core=video&name=dataimport";
		URL video_url;	
		HttpURLConnection videoConnection = null;
		try {
			video_url = new URL(videoUrl);
			videoConnection = (HttpURLConnection) video_url.openConnection();
			videoConnection.connect();
			String result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(videoConnection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			in.close();
			String s =result.substring(result.indexOf("Indexing"), result.lastIndexOf(".</str>")) ;
			logger.info("----------------------------solr-video:"+s);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != videoConnection) {
				videoConnection.disconnect();
			}

		}

	}
	
	@Scheduled(cron = "${schedule_time}") // 间隔180秒执行
	public void updateNotice() {
		String noticeUrl = url
				+ "/notice/dataimport?command=full-import&verbose=false&clean=true&commit=true&optimize=false&core=notice&name=dataimport";
		URL notice_url;	
		HttpURLConnection noticeConnection = null;
		try {
			notice_url = new URL(noticeUrl);
			noticeConnection = (HttpURLConnection) notice_url.openConnection();
			noticeConnection.connect();
			String result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(noticeConnection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			in.close();
			String s =result.substring(result.indexOf("Indexing"), result.lastIndexOf(".</str>")) ;
			logger.info("----------------------------solr-notice:"+s);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != noticeConnection) {
				noticeConnection.disconnect();
			}

		}

	}
}
