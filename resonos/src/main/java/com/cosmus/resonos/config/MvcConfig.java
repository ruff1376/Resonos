package com.cosmus.resonos.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String uploadPath1 = "file:./uploads/thumbnail/";
        String uploadPath2 = "file:./uploads/profile_img/";
        registry.addResourceHandler("/thumbnail/**")
                .addResourceLocations(uploadPath1);
        registry.addResourceHandler("/profile_img/**")
                .addResourceLocations(uploadPath2);
    }
}

