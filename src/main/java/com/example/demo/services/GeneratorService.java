package com.example.demo.services;

import com.example.demo.models.GeneratedFile;
import com.example.demo.models.GenerationRequest;
import com.example.demo.models.TableDefinition;
import com.example.demo.config.GenerationConfig;
import com.example.demo.models.ColumnModel;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GeneratorService {

    @Autowired
    private Configuration freemarkerConfig;

    public List<GeneratedFile> generateFromDefinitions(GenerationRequest request) throws IOException, TemplateException {
        List<GeneratedFile> generatedFiles = new ArrayList<>();
        String basePackage = request.getPackageName();
        List<TableDefinition> tables = request.getTables();
        GenerationConfig config = request.getConfig() != null ? request.getConfig() : new GenerationConfig();

        for (TableDefinition table : tables) {
            // Calcular nombres de campos según estrategia configurada
            for (ColumnModel column : table.getColumns()) {
                column.setFieldName(applyNamingStrategy(column.getColumnName(), config.getFieldNamingStrategy()));
            }

            Map<String, Object> dataModel = prepareDataModel(table, basePackage, config);

            // Generar archivos según templates configurados o usar defaults
            if (config.getTemplates() != null && !config.getTemplates().isEmpty()) {
                // Usar templates personalizados
                for (GenerationConfig.TemplateConfig templateConfig : config.getTemplates()) {
                    if (templateConfig.isEnabled()) {
                        generatedFiles.add(generateFileContent(
                                dataModel,
                                templateConfig.getTemplateName(),
                                templateConfig.getOutputFolder(),
                                templateConfig.getFileSuffix(),
                                config
                        ));
                    }
                }
            } else {
                // Usar templates por defecto
                generatedFiles.add(generateFileContent(dataModel, "entity.ftl", config.getEntityPackage(), config.getEntitySuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "dto.ftl", config.getDtoPackage(), config.getDtoSuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "repository.ftl", config.getRepositoryPackage(), config.getRepositorySuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "service-interface.ftl", config.getServicePackage(), config.getServiceSuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "service-impl.ftl", config.getServiceImplPackage(), config.getServiceImplSuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "controller.ftl", config.getControllerPackage(), config.getControllerSuffix(), config));
                generatedFiles.add(generateFileContent(dataModel, "mapper.ftl", config.getMapperPackage(), config.getMapperSuffix(), config));
            }
        }
        return generatedFiles;
    }

    private Map<String, Object> prepareDataModel(TableDefinition table, String basePackage, GenerationConfig config) {
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("packageName", basePackage);
        dataModel.put("tableName", table.getName());
        dataModel.put("className", applyNamingStrategy(table.getName(), config.getTableNamingStrategy()));
        dataModel.put("columns", table.getColumns());

        // Configuración de features
        dataModel.put("addLombokAnnotations", config.isAddLombokAnnotations());
        dataModel.put("addJpaAnnotations", config.isAddJpaAnnotations());
        dataModel.put("addValidationAnnotations", config.isAddValidationAnnotations());

        // Detectar ID según estrategia configurada
        String idType = findIdType(table.getColumns(), config);
        dataModel.put("idType", idType);

        // Encontrar la columna ID para el data model
        ColumnModel idColumn = findIdColumn(table.getColumns(), config);
        dataModel.put("idColumn", idColumn);

        // Detectar tipos especiales para imports
        dataModel.put("hasBigDecimal", table.getColumns().stream().anyMatch(c -> "BigDecimal".equals(c.getColumnType())));
        dataModel.put("hasLocalDate", table.getColumns().stream().anyMatch(c -> "LocalDate".equals(c.getColumnType())));
        dataModel.put("hasLocalTime", table.getColumns().stream().anyMatch(c -> "LocalTime".equals(c.getColumnType())));
        dataModel.put("hasLocalDateTime", table.getColumns().stream().anyMatch(c -> "LocalDateTime".equals(c.getColumnType())));

        config.setEntityPackage("entities");
        config.setDtoPackage("dto");
        config.setRepositoryPackage("repositories");
        dataModel.put("config", config);

        return dataModel;
    }

    /**
     * Detecta el tipo de la columna ID según la estrategia configurada
     */
    private String findIdType(List<ColumnModel> columns, GenerationConfig config) {
        ColumnModel idColumn = findIdColumn(columns, config);
        return idColumn != null ? idColumn.getColumnType() : config.getDefaultIdType();
    }

    /**
     * Encuentra la columna ID según la estrategia configurada
     */
    private ColumnModel findIdColumn(List<ColumnModel> columns, GenerationConfig config) {
        if (columns == null || columns.isEmpty()) {
            return null;
        }

        switch (config.getIdDetectionStrategy()) {
            case ANNOTATION:
                // Buscar columna marcada como primaryKey
                for (ColumnModel column : columns) {
                    if (column.isPrimaryKey()) {
                        return column;
                    }
                }
                // Fallback a AUTO si no se encuentra
                return findIdColumnAuto(columns);

            case CUSTOM:
                // Buscar columna con nombre personalizado
                String customName = config.getCustomIdColumnName();
                if (customName != null) {
                    for (ColumnModel column : columns) {
                        if (customName.equalsIgnoreCase(column.getColumnName())) {
                            return column;
                        }
                    }
                }
                // Fallback a primera columna
                return columns.get(0);

            case FIRST_COLUMN:
                return columns.get(0);

            case AUTO:
            default:
                return findIdColumnAuto(columns);
        }
    }

    /**
     * Búsqueda automática de columna ID
     */
    private ColumnModel findIdColumnAuto(List<ColumnModel> columns) {
        // Primero verificar si hay columna marcada como primaryKey
        for (ColumnModel column : columns) {
            if (column.isPrimaryKey()) {
                return column;
            }
        }

        // Buscar columna llamada exactamente "id" (case insensitive)
        for (ColumnModel column : columns) {
            if ("id".equalsIgnoreCase(column.getColumnName())) {
                return column;
            }
        }

        // Buscar columna que termine en "_id"
        for (ColumnModel column : columns) {
            if (column.getColumnName().toLowerCase().endsWith("_id")) {
                return column;
            }
        }

        // Buscar columna que contenga "id" en cualquier parte
        for (ColumnModel column : columns) {
            if (column.getColumnName().toLowerCase().contains("id")) {
                return column;
            }
        }

        // Fallback: usar la primera columna
        return columns.get(0);
    }

    private GeneratedFile generateFileContent(
            Map<String, Object> dataModel,
            String templateName,
            String typeFolder,
            String fileSuffix,
            GenerationConfig config) throws IOException, TemplateException {

        Template template = freemarkerConfig.getTemplate(templateName);

        // Procesar la plantilla en un StringWriter
        Writer out = new StringWriter();
        template.process(dataModel, out);
        String content = out.toString();

        // Construir la ruta completa del archivo
        String basePackage = (String) dataModel.get("packageName");
        String packagePath = basePackage.replace('.', '/');
        String className = (String) dataModel.get("className");
        String filePath = typeFolder + "/" + className + fileSuffix;

        return new GeneratedFile(filePath, content);
    }

    /**
     * Aplica la estrategia de nombres configurada
     */
    private String applyNamingStrategy(String input, GenerationConfig.NamingStrategy strategy) {
        if (input == null || input.isEmpty()) {
            return input;
        }

        switch (strategy) {
            case SNAKE_TO_PASCAL:
                return toPascalCase(input);

            case SNAKE_TO_CAMEL:
                return toCamelCase(input);

            case UPPERCASE:
                return input.toUpperCase();

            case LOWERCASE:
                return input.toLowerCase();

            case KEEP_ORIGINAL:
            default:
                return input;
        }
    }

    private String toPascalCase(String input) {
        String[] parts = input.split("_");
        StringBuilder result = new StringBuilder();
        for (String part : parts) {
            if (!part.isEmpty()) {
                result.append(part.substring(0, 1).toUpperCase())
                        .append(part.substring(1).toLowerCase());
            }
        }
        return result.toString();
    }

    private String toCamelCase(String input) {
        String[] parts = input.split("_");
        if (parts.length == 0) return input.toLowerCase();

        StringBuilder result = new StringBuilder(parts[0].toLowerCase());
        for (int i = 1; i < parts.length; i++) {
            if (!parts[i].isEmpty()) {
                result.append(parts[i].substring(0, 1).toUpperCase())
                        .append(parts[i].substring(1).toLowerCase());
            }
        }
        return result.toString();
    }
}