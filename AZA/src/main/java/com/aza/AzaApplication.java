package com.aza;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})
@PropertySource("classpath:application.properties")
@ImportResource(value= {"classpath:config/context-aspect.xml",
						"classpath:config/context-common.xml",
						"classpath:config/context-mybatis.xml", 
						"classpath:config/context-transaction.xml" })
@Configuration
public class AzaApplication extends SpringBootServletInitializer/*extends WebMvcConfigurerAdapter*/ {

	public static void main(String[] args) {
		System.out.println("AzaApplication start");
		SpringApplication.run(AzaApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(AzaApplication.class);
	}
	/*
	 * @Override public void addViewControllers(ViewControllerRegistry registry) {
	 * registry.addViewController("/").setViewName("/login");
	 * registry.addViewController("/index").setViewName("/index"); }
	 */
}
