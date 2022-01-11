package com.findYou.common.utils;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class CrawlingUtils {
	
	//WebDriver 설정
	private WebDriver driver;
	private WebElement element;
    
	//Properties 설정
	public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static String WEB_DRIVER_PATH = "/home/pc34/Downloads/chromedriver";
	public static String TEST_URL = "https://cyberbureau.police.go.kr/prevention/sub7.jsp?mid=020600";
	
	public CrawlingUtils() {
		 super();
		 
	    //System Property SetUp
	    System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
	    
	    //Driver SetUp
//	    driver = new ChromeDriver();
	}
	
	public String getCriminalInfo(String hpNum) throws InterruptedException {

		ChromeDriver driver= null;
		try {
			
			ChromeOptions options = new ChromeOptions();
			options.addArguments("headless");
			options.addArguments("--no-sandbox");
			driver = new ChromeDriver(options);
			
			driver.get(TEST_URL);

			element = driver.findElement(By.id("idsearch"));
			element.sendKeys(hpNum + Keys.ENTER);
			
			element = driver.findElement(By.id("getXmlSearch"));
			element.click();
			
			element = driver.findElement(By.id("search_result"));
            
          Thread.sleep(500);
          
          	element = driver.findElement(By.id("search_result"));
          	String text = element.getText();
          	System.out.println(text);
          
			return text;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			driver.close();
		}
		
		return "";
		
	}
}
