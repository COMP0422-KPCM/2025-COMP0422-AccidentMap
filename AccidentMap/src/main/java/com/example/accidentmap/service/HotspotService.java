package com.example.accidentmap.service;

import com.example.accidentmap.entity.Hotspot;
import com.example.accidentmap.repository.HotspotRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HotspotService {

    private final HotspotRepository hotspotRepository;

    public List<Hotspot> getAllHotspots() {
        return hotspotRepository.findAll();
    }

    public Hotspot getHotspotById(String id) {
        return hotspotRepository.findById(id).orElse(null);
    }

    public Hotspot saveHotspot(Hotspot hotspot) {
        return hotspotRepository.save(hotspot);
    }

    public void deleteHotspot(String id) {
        hotspotRepository.deleteById(id);
    }
}
