package ${packageName}.<#if config??>${config.dtoPackage?replace('/', '.')}<#else>dto</#if>;

<#if (addLombokAnnotations!true)>
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
</#if>
<#if (addValidationAnnotations!false)>
import jakarta.validation.constraints.*;
</#if>

<#if hasBigDecimal>import java.math.BigDecimal;</#if>
<#if hasLocalDate>import java.time.LocalDate;</#if>
<#if hasLocalTime>import java.time.LocalTime;</#if>
<#if hasLocalDateTime>import java.time.LocalDateTime;</#if>

<#if (addLombokAnnotations!true)>
@Data
@NoArgsConstructor
@AllArgsConstructor
</#if>
public class ${className}DTO {

    <#list columns as column>
    <#if (addValidationAnnotations!false)>
    <#if !(column.nullable!true) && !(column.primaryKey!column?is_first)>
    @NotNull(message = "${column.fieldName} no puede ser nulo")
    </#if>
    <#if column.minLength?? || column.maxLength??>
    @Size(<#if column.minLength??>min = ${column.minLength}</#if><#if column.minLength?? && column.maxLength??>, </#if><#if column.maxLength??>max = ${column.maxLength}</#if>, message = "${column.fieldName} debe tener entre <#if column.minLength??>${column.minLength}</#if> y <#if column.maxLength??>${column.maxLength}</#if> caracteres")
    </#if>
    <#if column.validationPattern??>
    @Pattern(regexp = "${column.validationPattern}", message = "${column.fieldName} tiene un formato inválido")
    </#if>
    </#if>
    private ${column.columnType} ${column.fieldName};

    </#list>
}
