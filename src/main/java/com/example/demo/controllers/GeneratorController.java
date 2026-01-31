package com.example.demo.controllers;

import com.example.demo.services.ZipService;
import com.example.demo.models.GeneratedFile;
import com.example.demo.models.GenerationRequest;
import com.example.demo.services.GeneratorService;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/generator")
public class GeneratorController {

    @Autowired
    private GeneratorService generatorService;

    @Autowired
    private ZipService zipService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/generate")
    public ResponseEntity<ByteArrayResource> generate(@RequestBody GenerationRequest request) {
        try {
            List<GeneratedFile> generatedFiles = generatorService.generateFromDefinitions(request);
            ByteArrayOutputStream zipStream = zipService.createZip(generatedFiles);

            ByteArrayResource resource = new ByteArrayResource(zipStream.toByteArray());

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=generated-code.zip")
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .contentLength(resource.contentLength())
                    .body(resource);

        } catch (IOException | TemplateException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }
}
