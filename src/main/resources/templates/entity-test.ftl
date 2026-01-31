package ${packageName}.${config.entityPackage?replace('/', '.')};

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;

<#if hasBigDecimal>import java.math.BigDecimal;</#if>
<#if hasLocalDate>import java.time.LocalDate;</#if>
<#if hasLocalTime>import java.time.LocalTime;</#if>
<#if hasLocalDateTime>import java.time.LocalDateTime;</#if>

class ${className}Test {

    private ${className} ${className?uncap_first};

    @BeforeEach
    void setUp() {
        ${className?uncap_first} = new ${className}();
    }

    @Test
    void testGettersAndSetters() {
        <#list columns as column>
        // Test ${column.fieldName}
        <#if column.columnType == "String">
        ${className?uncap_first}.set${column.fieldName?cap_first}("test${column.fieldName?cap_first}");
        assertEquals("test${column.fieldName?cap_first}", ${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "Long">
        ${className?uncap_first}.set${column.fieldName?cap_first}(1L);
        assertEquals(1L, ${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "Integer">
        ${className?uncap_first}.set${column.fieldName?cap_first}(100);
        assertEquals(100, ${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "Boolean">
        ${className?uncap_first}.set${column.fieldName?cap_first}(true);
        assertTrue(${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "BigDecimal">
        ${className?uncap_first}.set${column.fieldName?cap_first}(new BigDecimal("99.99"));
        assertEquals(new BigDecimal("99.99"), ${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "LocalDate">
        ${className?uncap_first}.set${column.fieldName?cap_first}(LocalDate.now());
        assertNotNull(${className?uncap_first}.get${column.fieldName?cap_first}());
        <#elseif column.columnType == "LocalDateTime">
        ${className?uncap_first}.set${column.fieldName?cap_first}(LocalDateTime.now());
        assertNotNull(${className?uncap_first}.get${column.fieldName?cap_first}());
        </#if>
        
        </#list>
    }

    @Test
    void testNotNull() {
        assertNotNull(${className?uncap_first});
    }
}
