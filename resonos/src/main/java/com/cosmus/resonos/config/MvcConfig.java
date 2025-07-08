package com.cosmus.resonos.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String projectPath = System.getProperty("user.dir").replace("\\", "/");
        String uploadPath = "file:///" + projectPath + "/resonos/uploads/thumbnail/";
        registry.addResourceHandler("/thumbnail/**")
                .addResourceLocations(uploadPath);
    }
}

