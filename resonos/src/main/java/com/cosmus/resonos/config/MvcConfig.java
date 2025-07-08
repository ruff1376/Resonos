package com.cosmus.resonos.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String projectPath = System.getProperty("user.dir").replace("\\", "/");
        String uploadPath1 = "file:///" + projectPath + "/resonos/uploads/thumbnail/";
        String uploadPath2 = "file:///" + projectPath + "/resonos/uploads/profile_img/";
        registry.addResourceHandler("/thumbnail/**")
                .addResourceLocations(uploadPath1);
        registry.addResourceHandler("/profile_img/**")
                .addResourceLocations(uploadPath2);
    }
}

