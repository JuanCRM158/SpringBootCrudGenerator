package com.example.demo.models;

import com.example.demo.config.GenerationConfig;
import lombok.Data;

import java.util.List;

@Data
public class GenerationRequest {
    private String packageName;
    private List<TableDefinition> tables;
    private GenerationConfig config; // Configuración personalizable

    // Constructor con valores por defecto
    public GenerationRequest() {
        this.config = new GenerationConfig();
    }
}