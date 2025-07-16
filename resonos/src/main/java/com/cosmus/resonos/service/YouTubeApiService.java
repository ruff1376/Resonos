package com.cosmus.resonos.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;

@Service
public class YouTubeApiService {

    private final RestTemplate restTemplate = new RestTemplate();
    // @Value("${youtube.api.key}")
    private String apiKey;

    public String searchVideoId(String title, String artist) {
        if (apiKey == null || apiKey.isBlank()) {
            System.out.println("API 키를 설정해주세요.");
            return null;
        }
        String query = URLEncoder.encode(artist + " " + title + " official MV", StandardCharsets.UTF_8);
        String url = "https://www.googleapis.com/youtube/v3/search"
                + "?part=snippet&type=video&maxResults=1"
                + "&q=" + query
                + "&key=" + apiKey
                + "&videoCategoryId=10";

        try {
            System.out.println("유튜브 api 요청했음 " + artist + " " + title);
            ResponseEntity<JsonNode> response = restTemplate.getForEntity(url, JsonNode.class);
            JsonNode items = response.getBody().get("items");

            if (items != null && items.size() > 0) {
                return items.get(0).get("id").get("videoId").asText();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "N/A";
    }
}
