package com.example.demo.config;

import lombok.Data;

import java.util.List;

@Data
public class GenerationConfig {
    // Configuración de paquetes
    private String basePackage;
    private String entityPackage = "entities";
    private String dtoPackage = "dto";
    private String repositoryPackage = "repositories";
    private String servicePackage = "services";
    private String serviceImplPackage = "services/impl";
    private String controllerPackage = "controllers";
    private String mapperPackage = "mappers";

    // Configuración de nombres de archivos
    private String entitySuffix = ".java";
    private String dtoSuffix = "DTO.java";
    private String repositorySuffix = "Repository.java";
    private String serviceSuffix = "Service.java";
    private String serviceImplSuffix = "ServiceImpl.java";
    private String controllerSuffix = "Controller.java";
    private String mapperSuffix = "Mapper.java";

    // Configuración de templates
    private List<TemplateConfig> templates;

    // Configuración de detección de ID
    private IdDetectionStrategy idDetectionStrategy = IdDetectionStrategy.AUTO;
    private String customIdColumnName; // Para estrategia CUSTOM
    private String defaultIdType = "Long";

    // Configuración de conversión de nombres
    private NamingStrategy tableNamingStrategy = NamingStrategy.SNAKE_TO_PASCAL;
    private NamingStrategy fieldNamingStrategy = NamingStrategy.SNAKE_TO_CAMEL;

    // Configuración de features opcionales
    private boolean generateServices = false;
    private boolean generateControllers = false;
    private boolean addLombokAnnotations = true;
    private boolean addJpaAnnotations = true;
    private boolean addValidationAnnotations = false;

    @Data
    public static class TemplateConfig {
        private String templateName;
        private String outputFolder;
        private String fileSuffix;
        private boolean enabled = true;
    }

    public enum IdDetectionStrategy {
        AUTO,           // Busca automáticamente (id, *_id, etc.)
        FIRST_COLUMN,   // Usa la primera columna
        CUSTOM,         // Usa customIdColumnName
        ANNOTATION      // Busca anotación @Id en los metadatos
    }

    public enum NamingStrategy {
        SNAKE_TO_PASCAL,    // user_table -> UserTable
        SNAKE_TO_CAMEL,     // user_name -> userName
        KEEP_ORIGINAL,      // mantiene el nombre original
        UPPERCASE,          // TODO MAYÚSCULAS
        LOWERCASE           // todo minúsculas
    }
}