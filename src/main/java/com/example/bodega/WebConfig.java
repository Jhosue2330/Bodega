package com.example.bodega;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.example.bodega.config.AuthInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

  // ====== IDIOMA (i18n) ======
  @Bean
  public LocaleResolver localeResolver() {
    SessionLocaleResolver slr = new SessionLocaleResolver();
    slr.setDefaultLocale(new Locale("es", "PE")); // Español Perú
    return slr;
  }

  @Bean
  public LocaleChangeInterceptor localeChangeInterceptor() {
    LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
    lci.setParamName("lang"); // ?lang=es o ?lang=en
    return lci;
  }

  // ====== INTERCEPTORES ======
  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    // Login interceptor (asegúrate de tener AuthInterceptor.java creado)
    registry.addInterceptor(new AuthInterceptor()).addPathPatterns("/**");

    // Cambiar idioma
    registry.addInterceptor(localeChangeInterceptor());
  }

  // ====== RECURSOS ESTÁTICOS ======
  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/css/**").addResourceLocations("/css/");
    registry.addResourceHandler("/img/**").addResourceLocations("/img/");
    registry.addResourceHandler("/js/**").addResourceLocations("/js/");
  }
}
