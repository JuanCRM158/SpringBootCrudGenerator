package ${packageName}.${config.servicePackage?replace('/', '.')}.mapper;

import ${packageName}.${config.entityPackage?replace('/', '.')}.${className};
import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ${className}Mapper {

    ${className}Mapper INSTANCE = Mappers.getMapper(${className}Mapper.class);

    ${className}DTO toDTO(${className} entity);

    ${className} toEntity(${className}DTO dto);

    List<${className}DTO> toDTOList(List<${className}> entities);

    List<${className}> toEntityList(List<${className}DTO> dtos);

    <#list columns as column>
    <#if !column.primaryKey>
    @Mapping(target = "${column.fieldName}", source = "${column.fieldName}")
    </#if>
    </#list>
    void updateEntityFromDTO(${className}DTO dto, @MappingTarget ${className} entity);
}
