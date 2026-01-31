package com.example.demo.models;

import lombok.Data;

import java.util.List;

@Data
public class TableDefinition {
    private String name;
    private List<ColumnModel> columns;
}
