package ${packageName}.${config.servicePackage?replace('/', '.')};

import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;

import java.util.List;
import java.util.Optional;

public interface ${className}Service {

    List<${className}DTO> findAll();

    Optional<${className}DTO> findById(${idType} id);

    ${className}DTO save(${className}DTO dto);

    ${className}DTO update(${idType} id, ${className}DTO dto);

    void deleteById(${idType} id);
}
