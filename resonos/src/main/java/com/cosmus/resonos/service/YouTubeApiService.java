package com.cosmus.resonos.service;

import com.fasterxml.jackson.databind.JsonNode;
import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

@Service
public class YouTubeApiService {

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${youtube.api.key}")
    private String apiKey;

    private static final String[] EXCLUDED_KEYWORDS = {
            "reaction", "리액션", "fanmade", "teaser", "remix", "mix",
            "first time", "my first time", "listening to",
            "respond", "reacted", "i cried", "emotional", "review"
    };

    private static final String[] OFFICIAL_CHANNEL_KEYWORDS = {
            "official", "smtown", "jyp", "yg", "1thek", "stone music", "kakao", "big hit", "bighit", "kq", "rbw",
            "cube", "wm", "starship", "pledis", "fantagio", "woollim", "brandnew", "mnh", "mbk", "c9", "top media",
            "aespa", "sony music", "sony music korea", "warner music", "warner music korea", "universal music",
            "universal music group", "atlantic records", "columbia records", "capitol records", "interscope",
            "republic records", "rca records", "avex", "jstorm", "toho animation", "smej", "king records",
            "universal music japan"
    };

    public String searchVideoId(String title, String artist) {
        if (apiKey == null || apiKey.isBlank()) {
            System.out.println("❗ API 키가 설정되지 않았습니다.");
            return null;
        }

        String normTitle = normalize(title);
        String normArtist = normalize(artist);

        List<String> fallbackQueries = Arrays.asList(
                normArtist + " - " + normTitle + " mv",
                normArtist + " " + extractEnglish(normTitle),
                normArtist + " " + extractKorean(normTitle),
                normArtist + " " + extractJapanese(normTitle),
                normArtist,
                normTitle
        );

        for (String query : fallbackQueries) {
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);
            String url = "https://www.googleapis.com/youtube/v3/search"
                    + "?part=snippet&type=video"
                    + "&maxResults=15"
                    + "&order=viewCount"
                    + "&q=" + encodedQuery
                    + "&key=" + apiKey;

            System.out.println("🔍 유튜브 API 요청: " + query);

            try {
                ResponseEntity<JsonNode> response = restTemplate.getForEntity(url, JsonNode.class);
                JsonNode items = response.getBody().get("items");

                if (items != null && items.size() > 0) {
                    String fallbackVideoId = null;

                    outer: for (JsonNode item : items) {
                        String videoId = item.get("id").get("videoId").asText();
                        String videoTitleRaw = item.get("snippet").get("title").asText();
                        String channelTitleRaw = item.get("snippet").get("channelTitle").asText();

                        String videoTitle = normalize(videoTitleRaw);
                        String channelTitle = normalize(channelTitleRaw);

                        for (String keyword : EXCLUDED_KEYWORDS) {
                            if (videoTitle.contains(normalize(keyword))) {
                                // System.out.println("🚫 제외된 영상 제목: " + videoTitleRaw + " (키워드: " + keyword + ")");
                                continue outer;
                            }
                        }

                        if (!(videoTitle.contains(normTitle) && videoTitle.contains(normArtist))) {
                            // System.out.println("⛔ 필수 키워드 누락: " + videoTitleRaw);
                            continue;
                        }

                        for (String official : OFFICIAL_CHANNEL_KEYWORDS) {
                            if (channelTitle.contains(normalize(official))) {
                                System.out.println("✅ 공식 채널 영상 선택됨: " + videoTitleRaw + " (" + channelTitleRaw + ")");
                                return videoId;
                            }
                        }

                        if (fallbackVideoId == null) {
                            fallbackVideoId = videoId;
                            System.out.println("🟡 fallback 후보: " + videoTitleRaw + " (" + channelTitleRaw + ")");
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
        }

        System.out.println("❌ 모든 fallback 쿼리에서 결과 없음");
        return "N/A";
    }

    private String normalize(String input) {
        if (input == null) return "";
        String decoded = StringEscapeUtils.unescapeHtml4(input);
        decoded = decoded.toLowerCase();
        decoded = decoded.replaceAll("[^a-z0-9가-힣\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FAF\\s]", "");
        decoded = decoded.replaceAll("\\s+", " ").trim();
        return decoded;
    }

    private String extractKorean(String input) {
        return input.replaceAll("[^가-힣\\s]", "").trim();
    }

    private String extractEnglish(String input) {
        return input.replaceAll("[^a-zA-Z\\s]", "").trim();
    }

    private String extractJapanese(String input) {
        return input.replaceAll("[^ぁ-んァ-ン一-龯ー\\s]", "").trim();
    }
}
