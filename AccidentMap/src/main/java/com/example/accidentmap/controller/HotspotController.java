package com.example.accidentmap.controller;

import com.example.accidentmap.entity.Hotspot;
import com.example.accidentmap.service.HotspotService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/hotspots")
@RequiredArgsConstructor
public class HotspotController {

    private final HotspotService hotspotService;

    @GetMapping
    public List<Hotspot> getAll() {
        return hotspotService.getAllHotspots();
    }

    @GetMapping("/{id}")
    public Hotspot getById(@PathVariable String id) {
        return hotspotService.getHotspotById(id);
    }

    @PostMapping
    public Hotspot create(@RequestBody Hotspot hotspot) {
        return hotspotService.saveHotspot(hotspot);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable String id) {
        hotspotService.deleteHotspot(id);
    }
}