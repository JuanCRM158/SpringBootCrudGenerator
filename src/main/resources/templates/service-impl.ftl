package ${packageName}.${config.servicePackage?replace('/', '.')}.impl;

import ${packageName}.${config.entityPackage?replace('/', '.')}.${className};
import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;
import ${packageName}.${config.repositoryPackage?replace('/', '.')}.${className}Repository;
import ${packageName}.${config.servicePackage?replace('/', '.')}.${className}Service;
import ${packageName}.${config.servicePackage?replace('/', '.')}.mapper.${className}Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ${className}ServiceImpl implements ${className}Service {

    @Autowired
    private ${className}Repository repository;

    @Autowired
    private ${className}Mapper mapper;

    @Override
    public List<${className}DTO> findAll() {
        return mapper.toDTOList(repository.findAll());
    }

    @Override
    public Optional<${className}DTO> findById(${idType} id) {
        return repository.findById(id)
                .map(mapper::toDTO);
    }

    @Override
    public ${className}DTO save(${className}DTO dto) {
        ${className} entity = mapper.toEntity(dto);
        ${className} saved = repository.save(entity);
        return mapper.toDTO(saved);
    }

    @Override
    public ${className}DTO update(${idType} id, ${className}DTO dto) {
        return repository.findById(id)
                .map(existing -> {
                    mapper.updateEntityFromDTO(dto, existing);
                    ${className} updated = repository.save(existing);
                    return mapper.toDTO(updated);
                })
                .orElseThrow(() -> new RuntimeException("${className} no encontrado con id: " + id));
    }

    @Override
    public void deleteById(${idType} id) {
        repository.deleteById(id);
    }
}
