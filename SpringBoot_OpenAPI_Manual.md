# Manual: Building a Spring Boot Project with OpenAPI Generator

This guide walks you through creating a Spring Boot project using Spring Initializr, integrating an OpenAPI spec, generating code, and resolving common build issues.

---

## 1. Generate Initial Spring Boot Project

Use [Spring Initializr](https://start.spring.io/) to generate your starter project:

- **Project**: Maven
- **Language**: Java
- **Spring Boot**: 3.2.5
- **Group**: `com.starckai`
- **Artifact**: `feedback-evaluation`
- **Name**: `feedback-evaluation`
- **Package Name**: `com.starckai`
- **Packaging**: Jar
- **Java**: 17
- **Dependencies**:
  - Spring Web
  - Spring Boot DevTools (optional)

Click **Generate**, unzip the archive, and open it in your IDE.

---

## 2. Place OpenAPI Spec

Create a directory and place your OpenAPI spec file:

```
src/main/resources/api/feedback-evaluation.yaml
```

---

## 3. Add OpenAPI Generator Plugin to `pom.xml`

```xml
<plugin>
  <groupId>org.openapitools</groupId>
  <artifactId>openapi-generator-maven-plugin</artifactId>
  <version>6.6.0</version>
  <executions>
    <execution>
      <goals><goal>generate</goal></goals>
      <configuration>
        <inputSpec>${project.basedir}/src/main/resources/api/feedback-evaluation.yaml</inputSpec>
        <generatorName>spring</generatorName>
        <library>spring-boot</library>
        <output>${project.build.directory}/generated-sources</output>
        <apiPackage>com.starckai.api</apiPackage>
        <modelPackage>com.starckai.model</modelPackage>
        <configOptions>
          <interfaceOnly>true</interfaceOnly>
          <useSwaggerAnnotations>true</useSwaggerAnnotations>
          <hideGenerationTimestamp>true</hideGenerationTimestamp>
          <useJakartaEe>true</useJakartaEe>
        </configOptions>
      </configuration>
    </execution>
  </executions>
</plugin>
```

---

## 4. Include Generated Sources in Compile Path

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>build-helper-maven-plugin</artifactId>
  <version>3.2.0</version>
  <executions>
    <execution>
      <id>add-source</id>
      <phase>generate-sources</phase>
      <goals><goal>add-source</goal></goals>
      <configuration>
        <sources>
          <source>${project.build.directory}/generated-sources/src/main/java</source>
        </sources>
      </configuration>
    </execution>
  </executions>
</plugin>
```

---

## 5. Required Dependencies

Add these to your `<dependencies>` section:

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<dependency>
  <groupId>org.springdoc</groupId>
  <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>io.swagger.core.v3</groupId>
  <artifactId>swagger-annotations</artifactId>
  <version>2.2.15</version>
</dependency>

<dependency>
  <groupId>jakarta.servlet</groupId>
  <artifactId>jakarta.servlet-api</artifactId>
  <version>6.0.0</version>
  <scope>provided</scope>
</dependency>

<dependency>
  <groupId>jakarta.validation</groupId>
  <artifactId>jakarta.validation-api</artifactId>
  <version>3.0.2</version>
</dependency>

<dependency>
  <groupId>org.openapitools</groupId>
  <artifactId>jackson-databind-nullable</artifactId>
  <version>0.2.6</version>
</dependency>
```

---

## 6. Generate Source Code

Run this command in your project root:

```bash
mvn clean compile
```

---

## 7. Common Errors and Fixes

### ❌ `javax.annotation.Generated` not found
✅ Fix:
```xml
<hideGenerationTimestamp>true</hideGenerationTimestamp>
```

---

### ❌ `javax.servlet.http` not found
✅ Fix:
```xml
<dependency>
  <groupId>jakarta.servlet</groupId>
  <artifactId>jakarta.servlet-api</artifactId>
  <version>6.0.0</version>
  <scope>provided</scope>
</dependency>
```

---

### ❌ `javax.validation` not found
✅ Fix:
```xml
<dependency>
  <groupId>jakarta.validation</groupId>
  <artifactId>jakarta.validation-api</artifactId>
  <version>3.0.2</version>
</dependency>
```

---

### ❌ `org.openapitools.jackson.nullable.JsonNullable` not found
✅ Fix:
```xml
<dependency>
  <groupId>org.openapitools</groupId>
  <artifactId>jackson-databind-nullable</artifactId>
  <version>0.2.6</version>
</dependency>
```

---

You are now ready to develop and test OpenAPI-driven Spring Boot APIs!