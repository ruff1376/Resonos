package com.cosmus.resonos.service;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriUtils;

import com.cosmus.resonos.domain.ConcertInfo;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BandsintownService {

    // @Value("${bandsintown.app-id}")
    private String appId;

    private final RestTemplate restTemplate = new RestTemplate();

    public List<ConcertInfo> getConcerts(String artistName) {
        if (appId == null || appId.isBlank()) {
            System.out.println("❗ API 키가 설정되지 않았습니다.");
            return null;
        }
        try {
            String encodedName = UriUtils.encodePath(artistName, StandardCharsets.UTF_8);
            String url = String.format(
                "https://rest.bandsintown.com/artists/%s/events?app_id=%s",
                encodedName, appId
            );

            ResponseEntity<List> response = restTemplate.getForEntity(url, List.class);
            List<Map<String, Object>> events = response.getBody();
            List<ConcertInfo> result = new ArrayList<>();

            if (events != null) {
                for (Map<String, Object> event : events) {
                    if (result.size() >= 3) break;

                    String datetime = (String) event.get("datetime");
                    String date = datetime != null ? datetime.split("T")[0] : null;

                    Map<String, Object> venue = (Map<String, Object>) event.get("venue");
                    String city = venue != null ? (String) venue.get("city") : "";
                    String country = venue != null ? (String) venue.get("country") : "";
                    String place = venue != null ? (String) venue.get("name") : "";
                    String displayName = artistName + " at " + place;

                    result.add(new ConcertInfo(date, city + ", " + country, displayName));
                }
            }

            return result;

        } catch (Exception e) {
            log.error("Bandsintown API 오류", e);
            return List.of();
        }
    }
}
