package com.example.demo.services;

import com.example.demo.models.GeneratedFile;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class ZipService {

    public ByteArrayOutputStream createZip(List<GeneratedFile> files) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
            for (GeneratedFile file : files) {
                // Usamos la ruta completa del archivo para la entrada del ZIP
                ZipEntry entry = new ZipEntry(file.getPath());
                zos.putNextEntry(entry);
                zos.write(file.getContent().getBytes());
                zos.closeEntry();
            }
        }
        return baos;
    }
}
