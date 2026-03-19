# Java API Service Starter

http://localhost:8080/api/generator/generate
https://springbootcrudgenerator.onrender.com

# 🚀 Generador de Código Personalizable

Sistema flexible de generación de código que se adapta a cualquier proyecto Java/Spring.

## 📋 Características Principales

### ✅ Totalmente Personalizable
- **Estrategias de nombres**: Snake case, Camel case, Pascal case, o mantener original
- **Detección de ID flexible**: Automática, primera columna, custom, o por anotación
- **Templates personalizables**: Define tus propios templates Freemarker
- **Estructura de paquetes configurable**: Adapta a tu arquitectura (hexagonal, clean, MVC, etc.)

### ✅ Generación Opcional
- Entities (siempre)
- DTOs (siempre)
- Repositories (siempre)
- Services (opcional)
- Controllers (opcional)

### ✅ Anotaciones Opcionales
- Lombok (`@Data`, `@Entity`, etc.)
- JPA (`@Table`, `@Column`, `@Id`)
- Validaciones (`@NotNull`, `@Size`, `@Pattern`)

## 🎯 Casos de Uso

### Caso 1: Proyecto Simple (Default)
```json
{
  "packageName": "com.example.demo",
  "tables": [
    {
      "name": "product",
      "columns": [
        {"columnName": "id", "columnType": "Long", "primaryKey": true},
        {"columnName": "name", "columnType": "String"}
      ]
    }
  ]
}
```

### Caso 2: Arquitectura Hexagonal
```json
{
  "packageName": "com.myapp",
  "config": {
    "entityPackage": "domain.model",
    "dtoPackage": "application.dto",
    "repositoryPackage": "infrastructure.persistence",
    "servicePackage": "application.service",
    "generateServices": true
  }
}
```

### Caso 3: Clean Architecture
```json
{
  "config": {
    "entityPackage": "core.entities",
    "dtoPackage": "adapters.web.dto",
    "repositoryPackage": "adapters.persistence.repositories",
    "servicePackage": "usecases"
  }
}
```

### Caso 4: Nombres Personalizados de ID
```json
{
  "config": {
    "idDetectionStrategy": "CUSTOM",
    "customIdColumnName": "pk_id"
  }
}
```

### Caso 5: Templates Personalizados
```json
{
  "config": {
    "templates": [
      {
        "templateName": "custom-entity.ftl",
        "outputFolder": "models",
        "fileSuffix": "Model.java",
        "enabled": true
      },
      {
        "templateName": "mapper.ftl",
        "outputFolder": "mappers",
        "fileSuffix": "Mapper.java",
        "enabled": true
      }
    ]
  }
}
```

## 🔧 Configuración Completa

```json
{
  "packageName": "com.mycompany.project",
  "tables": [...],
  "config": {
    // Paquetes
    "entityPackage": "entities",
    "dtoPackage": "dto",
    "repositoryPackage": "repositories",
    "servicePackage": "services",
    "controllerPackage": "controllers",
    
    // Sufijos de archivos
    "entitySuffix": ".java",
    "dtoSuffix": "DTO.java",
    "repositorySuffix": "Repository.java",
    "serviceSuffix": "Service.java",
    "controllerSuffix": "Controller.java",
    
    // Detección de ID
    "idDetectionStrategy": "AUTO|FIRST_COLUMN|CUSTOM|ANNOTATION",
    "customIdColumnName": "mi_id_personalizado",
    "defaultIdType": "Long",
    
    // Estrategias de nombres
    "tableNamingStrategy": "SNAKE_TO_PASCAL|SNAKE_TO_CAMEL|KEEP_ORIGINAL|UPPERCASE|LOWERCASE",
    "fieldNamingStrategy": "SNAKE_TO_CAMEL|SNAKE_TO_PASCAL|KEEP_ORIGINAL|UPPERCASE|LOWERCASE",
    
    // Features opcionales
    "generateServices": true,
    "generateControllers": true,
    "addLombokAnnotations": true,
    "addJpaAnnotations": true,
    "addValidationAnnotations": true,
    
    // Templates personalizados (opcional)
    "templates": [
      {
        "templateName": "entity.ftl",
        "outputFolder": "domain/entities",
        "fileSuffix": ".java",
        "enabled": true
      },
      {
        "templateName": "dto.ftl",
        "outputFolder": "api/dto",
        "fileSuffix": "DTO.java",
        "enabled": true
      },
      {
        "templateName": "repository.ftl",
        "outputFolder": "infrastructure/repositories",
        "fileSuffix": "Repository.java",
        "enabled": true
      },
      {
        "templateName": "service.ftl",
        "outputFolder": "application/services",
        "fileSuffix": "Service.java",
        "enabled": true
      },
      {
        "templateName": "controller.ftl",
        "outputFolder": "api/controllers",
        "fileSuffix": "Controller.java",
        "enabled": true
      }
    ]
  }
}
```

```json
{
  "packageName": "com.mycompany.project",
  "tables": [
    {
      "name": "user_account",
      "columns": [
        {
          "columnName": "user_id",
          "columnType": "Long",
          "primaryKey": true,
          "nullable": false
        },
        {
          "columnName": "user_name",
          "columnType": "String",
          "nullable": false,
          "maxLength": 100
        },
        {
          "columnName": "email",
          "columnType": "String",
          "unique": true,
          "validationPattern": "^[A-Za-z0-9+_.-]+@(.+)$"
        },
        {
          "columnName": "created_at",
          "columnType": "LocalDateTime"
        }
      ]
    }
  ],
  "config": {
    "basePackage": "com.mycompany.project",
    "entityPackage": "domain.entities",
    "dtoPackage": "api.dto",
    "repositoryPackage": "infrastructure.repositories",
    "servicePackage": "application.services",
    "controllerPackage": "api.controllers",
    "entitySuffix": ".java",
    "dtoSuffix": "DTO.java",
    "repositorySuffix": "Repository.java",
    "serviceSuffix": "Service.java",
    "controllerSuffix": "Controller.java",
    "idDetectionStrategy": "ANNOTATION",
    "defaultIdType": "Long",
    "tableNamingStrategy": "SNAKE_TO_PASCAL",
    "fieldNamingStrategy": "SNAKE_TO_CAMEL",
    "generateServices": true,
    "generateControllers": true,
    "addLombokAnnotations": true,
    "addJpaAnnotations": true,
    "addValidationAnnotations": true
  }
}
```


## 📊 Metadatos de Columnas

Puedes agregar metadatos a tus columnas para validaciones y constraints:

```json
{
  "columnName": "email",
  "columnType": "String",
  "primaryKey": false,
  "nullable": false,
  "unique": true,
  "length": 255,
  "validationPattern": "^[A-Za-z0-9+_.-]+@(.+)$",
  "minLength": 5,
  "maxLength": 100
}
```

## 🎨 Ejemplos de Estrategias

### Nombres de Tablas
- `user_account` + `SNAKE_TO_PASCAL` → `UserAccount`
- `user_account` + `SNAKE_TO_CAMEL` → `userAccount`
- `user_account` + `UPPERCASE` → `USER_ACCOUNT`
- `user_account` + `KEEP_ORIGINAL` → `user_account`

### Nombres de Campos
- `first_name` + `SNAKE_TO_CAMEL` → `firstName`
- `first_name` + `SNAKE_TO_PASCAL` → `FirstName`

## 💡 Tips

1. **Usa `AUTO` para detección de ID** si sigues convenciones estándar
2. **Activa `generateServices` y `generateControllers`** para APIs completas
3. **Usa templates personalizados** para patrones específicos de tu empresa
4. **Activa `addValidationAnnotations`** si usas Bean Validation
5. **Configura los paquetes** según tu arquitectura (hexagonal, clean, etc.)

## 🚀 Ventajas

✅ **Portable**: Se adapta a cualquier proyecto  
✅ **Extensible**: Agrega tus propios templates  
✅ **Flexible**: Múltiples estrategias configurables  
✅ **Completo**: Genera desde entities hasta controllers  
✅ **Seguro**: Validaciones y constraints configurables

# 📝 Templates FreeMarker - Guía Completa

## Templates Disponibles

### 1. **entity.ftl** - Entidades JPA
Genera clases de entidad con:
- ✅ Anotaciones JPA (`@Entity`, `@Table`, `@Column`, `@Id`)
- ✅ Anotaciones Lombok (`@Data`, `@NoArgsConstructor`, `@AllArgsConstructor`)
- ✅ Validaciones Jakarta (`@NotNull`, `@Size`, `@Pattern`)
- ✅ Imports automáticos según tipos de datos

**Variables disponibles:**
- `packageName` - Paquete base
- `config.entityPackage` - Sub-paquete de entidades
- `className` - Nombre de la clase
- `tableName` - Nombre de la tabla
- `columns` - Lista de columnas
- `addJpaAnnotations` - Boolean
- `addLombokAnnotations` - Boolean
- `addValidationAnnotations` - Boolean

---

### 2. **dto.ftl** - Data Transfer Objects
Genera DTOs con:
- ✅ Anotaciones Lombok
- ✅ Validaciones con mensajes personalizados
- ✅ Constructores completos

**Características:**
- Validaciones `@NotNull` con mensajes en español
- `@Size` para rangos de longitud
- `@Pattern` para expresiones regulares

---

### 3. **repository.ftl** - Repositorios JPA
Genera interfaces de repositorio con:
- ✅ Extiende `JpaRepository`
- ✅ Métodos de búsqueda automáticos
- ✅ `findByXxxContaining` para campos String
- ✅ `findByXxx` para campos únicos

**Ejemplo de métodos generados:**
```java
Optional<User> findByEmail(String email);
List<User> findByNameContaining(String name);
```

---

### 4. **service.ftl** - Servicios con conversión manual
Genera servicios con:
- ✅ CRUD completo
- ✅ Métodos de conversión Entity ↔ DTO
- ✅ Transaccionalidad
- ✅ Manejo de excepciones

**Métodos generados:**
- `findAll()` → List<DTO>
- `findById(id)` → Optional<DTO>
- `save(dto)` → DTO
- `update(id, dto)` → DTO
- `deleteById(id)` → void

---

### 5. **service-interface.ftl** + **service-impl.ftl**
Para arquitecturas con interfaces:
- `service-interface.ftl` → Interfaz del servicio
- `service-impl.ftl` → Implementación con MapStruct

**Ventajas:**
- Mejor testabilidad
- Compatibilidad con MapStruct
- Separación de contratos

---

### 6. **mapper.ftl** - MapStruct Mappers
Genera mappers automáticos con:
- ✅ Conversión Entity → DTO
- ✅ Conversión DTO → Entity
- ✅ Conversión de listas
- ✅ Actualización de entidades existentes

**Requiere:**
```xml
<dependency>
    <groupId>org.mapstruct</groupId>
    <artifactId>mapstruct</artifactId>
    <version>1.5.5.Final</version>
</dependency>
```

---

### 7. **controller.ftl** - REST Controllers
Genera controladores REST con:
- ✅ Endpoints CRUD completos
- ✅ CORS habilitado
- ✅ Validación con `@Valid`
- ✅ Códigos HTTP apropiados
- ✅ URLs amigables (snake_case → kebab-case)

**Endpoints generados:**
- `GET /api/resource` → Lista todos
- `GET /api/resource/{id}` → Por ID
- `POST /api/resource` → Crear
- `PUT /api/resource/{id}` → Actualizar
- `DELETE /api/resource/{id}` → Eliminar

---

### 8. **entity-test.ftl** - Tests unitarios
Genera tests JUnit 5 con:
- ✅ Tests de getters/setters
- ✅ Assertions por tipo de dato
- ✅ Setup con `@BeforeEach`

---

## 🎯 Configuración por Proyecto

### Proyecto Simple (Solo entity, dto, repository)
```json
{
  "config": {
    "templates": [
      {"templateName": "entity.ftl", "outputFolder": "entities", "fileSuffix": ".java"},
      {"templateName": "dto.ftl", "outputFolder": "dto", "fileSuffix": "DTO.java"},
      {"templateName": "repository.ftl", "outputFolder": "repositories", "fileSuffix": "Repository.java"}
    ]
  }
}
```

### Proyecto con Services
```json
{
  "config": {
    "generateServices": true,
    "templates": [
      // ... entity, dto, repository
      {"templateName": "service.ftl", "outputFolder": "services", "fileSuffix": "Service.java"}
    ]
  }
}
```

### Proyecto con MapStruct
```json
{
  "config": {
    "templates": [
      // ... entity, dto, repository
      {"templateName": "service-interface.ftl", "outputFolder": "services", "fileSuffix": "Service.java"},
      {"templateName": "service-impl.ftl", "outputFolder": "services/impl", "fileSuffix": "ServiceImpl.java"},
      {"templateName": "mapper.ftl", "outputFolder": "services/mapper", "fileSuffix": "Mapper.java"}
    ]
  }
}
```

### API REST Completa
```json
{
  "config": {
    "generateServices": true,
    "generateControllers": true,
    "addValidationAnnotations": true
  }
}
```

### Con Tests
```json
{
  "config": {
    "templates": [
      // ... otros templates
      {"templateName": "entity-test.ftl", "outputFolder": "../test/java/entities", "fileSuffix": "Test.java"}
    ]
  }
}
```

---

## 🔧 Variables Disponibles en Templates

### Variables Globales
```freemarker
${packageName}           - Paquete base del proyecto
${className}             - Nombre de la clase (PascalCase)
${tableName}             - Nombre de la tabla (snake_case)
${idType}                - Tipo del ID (Long, String, etc.)
${idColumn}              - Objeto ColumnModel del ID
```

### Variables de Configuración
```freemarker
${config.entityPackage}
${config.dtoPackage}
${config.repositoryPackage}
${config.servicePackage}
${config.controllerPackage}

${addLombokAnnotations}
${addJpaAnnotations}
${addValidationAnnotations}
```

### Variables de Imports
```freemarker
${hasBigDecimal}        - Boolean
${hasLocalDate}         - Boolean
${hasLocalTime}         - Boolean
${hasLocalDateTime}     - Boolean
```

### Objeto Column
```freemarker
<#list columns as column>
  ${column.columnName}         - Nombre original (snake_case)
  ${column.fieldName}          - Nombre del campo (camelCase)
  ${column.columnType}         - Tipo Java (String, Long, etc.)
  ${column.primaryKey}         - Boolean
  ${column.nullable}           - Boolean
  ${column.unique}             - Boolean
  ${column.length}             - Integer (opcional)
  ${column.validationPattern}  - String (opcional)
  ${column.minLength}          - Integer (opcional)
  ${column.maxLength}          - Integer (opcional)
</#list>
```

---

## 💡 Tips para Templates Personalizados

### 1. Conditional Imports
```freemarker
<#if hasBigDecimal>import java.math.BigDecimal;</#if>
<#if hasLocalDate>import java.time.LocalDate;</#if>
```

### 2. Detectar Primera Columna (ID)
```freemarker
<#list columns as column>
  <#if column?is_first>
    @Id
  </#if>
</#list>
```

### 3. Excluir Primary Key
```freemarker
<#list columns as column>
  <#if !column.primaryKey>
    // código que no debe incluir el ID
  </#if>
</#list>
```

### 4. Validaciones Condicionales
```freemarker
<#if !column.nullable>@NotNull</#if>
<#if column.unique>@Column(unique = true)</#if>
```

### 5. Capitalizar Nombres
```freemarker
${column.fieldName?cap_first}  → FirstName
${column.fieldName?uncap_first} → firstName
```

---

## 📦 Ubicación de Templates

Coloca los templates en: `/src/main/resources/templates/`

Freemarker los encontrará automáticamente si tienes esta configuración:

```java
@Configuration
public class FreemarkerConfig {
    @Bean
    public Configuration freemarkerConfiguration() {
        Configuration config = new Configuration(Configuration.VERSION_2_3_31);
        config.setClassForTemplateLoading(this.getClass(), "/templates");
        return config;
    }
}
```

---

## 🎨 Ejemplo Completo

Para tabla `user_account` con columnas `user_id`, `email`, `created_at`:

**Genera:**
- `UserAccount.java` (entity)
- `UserAccountDTO.java`
- `UserAccountRepository.java`
- `UserAccountService.java`
- `UserAccountController.java`
- `UserAccountMapper.java`
- `UserAccountTest.java`

¡Todo personalizable según tu configuración! 🚀