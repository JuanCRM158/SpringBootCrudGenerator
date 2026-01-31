package ${packageName}.<#if config??>${config.repositoryPackage?replace('/', '.')}<#else>repositories</#if>;

import ${packageName}.<#if config??>${config.entityPackage?replace('/', '.')}<#else>entities</#if>.${className};
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ${className}Repository extends JpaRepository<${className}, ${idType}> {

    // Métodos de búsqueda personalizados generados automáticamente
    <#list columns as column>
    <#if (column.unique!false) && !(column.primaryKey!column?is_first)>
    Optional<${className}> findBy${column.fieldName?cap_first}(${column.columnType} ${column.fieldName});
    </#if>
    <#if column.columnType == "String" && !(column.primaryKey!column?is_first)>
    List<${className}> findBy${column.fieldName?cap_first}Containing(String ${column.fieldName});
    </#if>
    </#list>
}
