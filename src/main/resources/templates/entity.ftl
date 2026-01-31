package ${packageName}.<#if config??>${config.entityPackage?replace('/', '.')}<#else>entities</#if>;

<#if (addJpaAnnotations!true)>
import jakarta.persistence.*;
</#if>
<#if (addLombokAnnotations!true)>
import lombok.Data;
<#if (addJpaAnnotations!true)>
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
</#if>
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
<#if (addJpaAnnotations!true)>
@NoArgsConstructor
@AllArgsConstructor
</#if>
</#if>
<#if (addJpaAnnotations!true)>
@Entity
@Table(name = "${tableName}")
</#if>
public class ${className} {

    <#list columns as column>
    <#if column.primaryKey!column?is_first && (addJpaAnnotations!true)>
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    </#if>
    <#if (addJpaAnnotations!true)>
    @Column(name = "${column.columnName}"<#if !(column.nullable!true)>, nullable = false</#if><#if (column.unique!false)>, unique = true</#if><#if column.length??>, length = ${column.length}</#if>)
    </#if>
    <#if (addValidationAnnotations!false)>
    <#if !(column.nullable!true)>
    @NotNull
    </#if>
    <#if column.minLength?? || column.maxLength??>
    @Size(<#if column.minLength??>min = ${column.minLength}</#if><#if column.minLength?? && column.maxLength??>, </#if><#if column.maxLength??>max = ${column.maxLength}</#if>)
    </#if>
    <#if column.validationPattern??>
    @Pattern(regexp = "${column.validationPattern}")
    </#if>
    </#if>
    private ${column.columnType} ${column.fieldName};

    </#list>
}
