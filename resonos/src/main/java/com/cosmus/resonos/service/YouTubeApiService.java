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

    @Value("${youtube.api.key}")
    private String apiKey;

    // 제외 키워드 목록
    private static final String[] EXCLUDED_KEYWORDS = {
            "reaction", "리액션", "fanmade", "teaser", "remix", "mix",
            "first time", "my first time", "listening to",
            "respond", "reacted", "i cried", "emotional", "review"
    };

    private static final String[] OFFICIAL_CHANNEL_KEYWORDS = {
            // 국내 레이블
            "official", "smtown", "jyp", "yg", "1thek", "stone music", "kakao", "big hit", "bighit", "kq", "rbw",
            "cube", "wm", "starship", "pledis", "fantagio", "woollim", "brandnew", "mnh", "mbk", "c9", "top media",

            // 글로벌 레이블
            "sony music", "sony music korea", "warner music", "warner music korea", "universal music",
            "universal music group",
            "atlantic records", "columbia records", "capitol records", "interscope", "republic records", "rca records"
    };

    public String searchVideoId(String title, String artist) {
        if (apiKey == null || apiKey.isBlank()) {
            System.out.println("❗ API 키가 설정되지 않았습니다.");
            return null;
        }

        String query = URLEncoder.encode(artist + " - " + title + " official MV", StandardCharsets.UTF_8);
        String url = "https://www.googleapis.com/youtube/v3/search"
                + "?part=snippet&type=video"
                + "&maxResults=5"
                + "&order=viewCount"
                + "&q=" + query
                + "&videoCategoryId=10"
                + "&key=" + apiKey;

        try {
            System.out.println("🔍 유튜브 API 요청: " + artist + " - " + title);
            ResponseEntity<JsonNode> response = restTemplate.getForEntity(url, JsonNode.class);
            JsonNode items = response.getBody().get("items");

            if (items != null && items.size() > 0) {
                String fallbackVideoId = null;

                outer: for (JsonNode item : items) {
                    String videoId = item.get("id").get("videoId").asText();
                    String videoTitle = item.get("snippet").get("title").asText().toLowerCase();
                    String channelTitle = item.get("snippet").get("channelTitle").asText().toLowerCase();

                    // 1️⃣ 제외 키워드 필터링
                    for (String keyword : EXCLUDED_KEYWORDS) {
                        if (videoTitle.contains(keyword)) {
                            System.out.println("🚫 제외된 영상 제목: " + videoTitle + " (키워드: " + keyword + ")");
                            continue outer;
                        }
                    }

                    // 2️⃣ 필수 키워드 포함 확인
                    if (!(videoTitle.contains(title.toLowerCase()) && videoTitle.contains(artist.toLowerCase()))) {
                        System.out.println("⛔ 필수 키워드 누락: " + videoTitle);
                        continue;
                    }

                    // 3️⃣ 공식 채널 우선
                    for (String official : OFFICIAL_CHANNEL_KEYWORDS) {
                        if (channelTitle.contains(official)) {
                            System.out.println("✅ 공식 채널 영상 선택됨: " + videoTitle + " (" + channelTitle + ")");
                            return videoId;
                        }
                    }

                    // 4️⃣ fallback 후보 저장 (제목 통과한 경우만)
                    if (fallbackVideoId == null) {
                        fallbackVideoId = videoId;
                        System.out.println("🟡 fallback 후보: " + videoTitle + " (" + channelTitle + ")");
                    }
                }

                if (fallbackVideoId != null) {
                    System.out.println("🟡 fallback 영상 최종 선택됨: " + fallbackVideoId);
                    return fallbackVideoId;
                } else {
                    System.out.println("❌ 모든 영상이 필터링되어 fallback 없음");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "N/A";
    }
}
