package com.example.demo.models;

import lombok.Data;

@Data
public class ColumnModel {
    private String columnName;
    private String columnType;
    private String fieldName; // Este campo se calcula, no se envía en el JSON

    // Metadatos adicionales opcionales
    private boolean primaryKey = false;
    private boolean nullable = true;
    private boolean unique = false;
    private Integer length;
    private Integer precision;
    private Integer scale;
    private String defaultValue;

    // Validaciones opcionales
    private String validationPattern;
    private Integer minLength;
    private Integer maxLength;
    private String minValue;
    private String maxValue;
}