package ${packageName}.${config.servicePackage?replace('/', '.')};

import ${packageName}.${config.entityPackage?replace('/', '.')}.${className};
import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;
import ${packageName}.${config.repositoryPackage?replace('/', '.')}.${className}Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class ${className}Service {

    @Autowired
    private ${className}Repository repository;

    public List<${className}DTO> findAll() {
        return repository.findAll().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public Optional<${className}DTO> findById(${idType} id) {
        return repository.findById(id)
                .map(this::toDTO);
    }

    public ${className}DTO save(${className}DTO dto) {
        ${className} entity = toEntity(dto);
        ${className} saved = repository.save(entity);
        return toDTO(saved);
    }

    public ${className}DTO update(${idType} id, ${className}DTO dto) {
        return repository.findById(id)
                .map(existing -> {
                    updateEntityFromDTO(existing, dto);
                    ${className} updated = repository.save(existing);
                    return toDTO(updated);
                })
                .orElseThrow(() -> new RuntimeException("${className} no encontrado con id: " + id));
    }

    public void deleteById(${idType} id) {
        repository.deleteById(id);
    }

    // Métodos de conversión
    private ${className}DTO toDTO(${className} entity) {
        ${className}DTO dto = new ${className}DTO();
        <#list columns as column>
        dto.set${column.fieldName?cap_first}(entity.get${column.fieldName?cap_first}());
        </#list>
        return dto;
    }

    private ${className} toEntity(${className}DTO dto) {
        ${className} entity = new ${className}();
        <#list columns as column>
        <#if !column.primaryKey>
        entity.set${column.fieldName?cap_first}(dto.get${column.fieldName?cap_first}());
        </#if>
        </#list>
        return entity;
    }

    private void updateEntityFromDTO(${className} entity, ${className}DTO dto) {
        <#list columns as column>
        <#if !column.primaryKey>
        entity.set${column.fieldName?cap_first}(dto.get${column.fieldName?cap_first}());
        </#if>
        </#list>
    }
}
