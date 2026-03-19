package ${packageName}.${config.servicePackage?replace('/', '.')}.mappers;

import ${packageName}.${config.entityPackage?replace('/', '.')}.${className};
import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;

import org.modelmapper.ModelMapper;

import java.util.List;

public class ${className}Mapper {
    private ${className}Mapper() {
        throw new IllegalStateException("No existe un constructor para la clase");
    }
    private static final ModelMapper MAPPER = new ModelMapper();
    public static ${className}DTO toModel(${className} entity) {
        return MAPPER.map(entity, ${className}DTO.class);
    }

    public static ${className} mapmapMenuOpcionDTO(${className}DTO model) {
        return MAPPER.map(model, ${className}.class);
    }
}
