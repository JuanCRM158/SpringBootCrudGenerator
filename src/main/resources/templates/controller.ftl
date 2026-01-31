package ${packageName}.${config.controllerPackage?replace('/', '.')};

import ${packageName}.${config.dtoPackage?replace('/', '.')}.${className}DTO;
import ${packageName}.${config.servicePackage?replace('/', '.')}.${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

<#if addValidationAnnotations>
import jakarta.validation.Valid;
</#if>
import java.util.List;

@RestController
@RequestMapping("/api/${tableName?replace('_', '-')}")
@CrossOrigin(origins = "*")
public class ${className}Controller {

    @Autowired
    private ${className}Service service;

    @GetMapping
    public ResponseEntity<List<${className}DTO>> getAll() {
        List<${className}DTO> items = service.findAll();
        return ResponseEntity.ok(items);
    }

    @GetMapping("/{id}")
    public ResponseEntity<${className}DTO> getById(@PathVariable ${idType} id) {
        return service.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<${className}DTO> create(<#if addValidationAnnotations>@Valid </#if>@RequestBody ${className}DTO dto) {
        ${className}DTO created = service.save(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<${className}DTO> update(
            @PathVariable ${idType} id,
            <#if addValidationAnnotations>@Valid </#if>@RequestBody ${className}DTO dto) {
        try {
            ${className}DTO updated = service.update(id, dto);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable ${idType} id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
