package com.cosmus.resonos.service;

import com.fasterxml.jackson.databind.JsonNode;
import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Service
public class YouTubeApiService {

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${youtube.api.key}")
    private String apiKey;

    private static final List<String> EXCLUDED_KEYWORDS = List.of(
            "reaction", "리액션", "fanmade", "teaser", "remix", "mix", "loop", "cover", "커버", "edit", "ver.",
            "fan cam", "직캠", "응원법", "응원", "lyrics", "lyric", "가사", "소리만", "소리", "asmr",
            "instrumental", "inst", "highlight", "shorts", "short", "mv teaser", "피아노",
            "dance practice", "dance ver", "live", "performance", "뮤뱅", "뮤직뱅크", "인기가요", "쇼챔피언",
            "음중", "엠카", "음방", "방청", "선공개", "미공개", "뮤비해석", "vlog", "study", "study with me",
            "reaction mashup", "edit audio", "edit version", "first time", "my first time", "listening to",
            "react", "respond", "reacted", "i cried", "emotional", "review");

    private static final List<String> OFFICIAL_CHANNEL_KEYWORDS = List.of(
            // ✅ 국내 플랫폼 및 유통사
            "official", "1thek", "stone music", "genie", "bugs", "melon",
            "smtown", "jyp", "yg", "big hit", "bighit", "hybe", "ador", "kq", "rbw", "cube",
            "wm", "starship", "pledis", "fantagio", "woollim", "brandnew", "mnh", "mbk",
            "c9", "top media", "swing entertainment", "beat interactive", "a team", "mld",
            "1MILLION Dance Studio",

            // ✅ 국내 아티스트 개인 채널
            "iu official", "taeyeon official", "zico official", "jay park", "jessi official",
            "bts official", "blackpink", "twice official", "exo official", "red velvet official",
            "stray kids official", "itzy official", "got7 official", "seventeen official",
            "mamamoo official",

            // ✅ 해외 메이저 레이블 및 배급사
            "sony music", "sony music korea", "워너뮤직코리아", "warner music", "warner music korea",
            "universal music", "universal music group", "universal music japan",
            "atlantic records", "columbia records", "capitol records", "interscope",
            "republic records", "rca records", "avex", "jstorm", "toho animation",
            "smej", "king records",

            // ✅ 글로벌 아티스트/뮤직 플랫폼/브랜드 채널
            "t-series", "zee music company", "tips official", "trap nation", "monstercat",
            "no-copyright-sounds", "chill nation", "ukf", "colorsxstudios", "sofar sounds",
            "lyrical lemonade", "armada music", "bbc radio 1", "wave music", "ncs",
            "monstercat uncaged", "epic music world", "comfy music channel",
            "lofi hip hop", "colors – live sessions");

    private static final List<String> PRIORITY_TITLE_KEYWORDS = List.of(
            "official music video", "mv", "m/v");

    public String searchVideoId(String title, String artist) {
        if (apiKey == null || apiKey.isBlank()) {
            System.out.println("❗ API 키가 설정되지 않았습니다.");
            return null;
        }

        String cleanedTitle = cleanTitle(title);

        String normTitle = normalize(cleanedTitle);
        String normArtist = normalize(artist);

        // ✅ 조건부로 fallbackQueries 생성
        List<String> fallbackQueries = new ArrayList<>();
        fallbackQueries.add(normArtist + " - " + normTitle + " mv");

        String extractedEng = extractEnglish(cleanedTitle);
        if (!extractedEng.isEmpty()) {
            fallbackQueries.add(normArtist + " " + extractedEng);
        }

        String extractedKor = extractKorean(cleanedTitle);
        if (!extractedKor.isEmpty()) {
            fallbackQueries.add(normArtist + " " + extractedKor);
        }

        String extractedJpn = extractJapanese(cleanedTitle);
        if (!extractedJpn.isEmpty()) {
            fallbackQueries.add(normArtist + " " + extractedJpn);
        }

        fallbackQueries.add(normArtist);
        fallbackQueries.add(normTitle);

        for (String query : fallbackQueries) {
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);
            String url = "https://www.googleapis.com/youtube/v3/search"
                    + "?part=snippet&type=video"
                    + "&maxResults=50"
                    + "&order=viewCount"
                    + "&q=" + encodedQuery
                    + "&key=" + apiKey;

            System.out.println("🔍 유튜브 API 요청: " + query);

            try {
                ResponseEntity<JsonNode> response = restTemplate.getForEntity(url, JsonNode.class);
                JsonNode items = response.getBody().get("items");

                if (items != null && items.size() > 0) {
                    String bestVideoId = null;
                    int bestScore = Integer.MIN_VALUE;

                    for (JsonNode item : items) {
                        String videoId = item.get("id").get("videoId").asText();
                        String videoTitleRaw = item.get("snippet").get("title").asText();
                        String channelTitleRaw = item.get("snippet").get("channelTitle").asText();

                        String videoTitle = normalize(videoTitleRaw);
                        String channelTitle = normalize(channelTitleRaw);

                        int penalty = 0;
                        for (String k : EXCLUDED_KEYWORDS) {
                            if (videoTitle.contains(normalize(k))) {
                                penalty += 10;
                            }
                        }
                        if (penalty >= 10)
                            continue;

                        int score = 0;
                        if (videoTitle.contains(normTitle))
                            score += 3;
                        if (videoTitle.contains(normArtist))
                            score += 3;

                        if (PRIORITY_TITLE_KEYWORDS.stream().anyMatch(k -> videoTitle.contains(normalize(k)))) {
                            score += 5;
                        }

                        if (OFFICIAL_CHANNEL_KEYWORDS.stream().anyMatch(k -> channelTitle.contains(normalize(k)))) {
                            score += 5;
                        }

                        score -= penalty;

                        if (score > bestScore) {
                            bestScore = score;
                            bestVideoId = videoId;
                            System.out.println("🟡 후보 영상 업데이트: " + videoTitleRaw + " (score: " + score + ")");
                        }
                    }

                    if (bestVideoId != null) {
                        System.out.println("✅ 최종 선택된 영상 ID: " + bestVideoId);
                        return bestVideoId;
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        System.out.println("❌ 모든 fallback 쿼리에서 결과 없음");
        return "N/A";
    }

    private String cleanTitle(String title) {
        if (title == null)
            return "";

        // 1) feat, featuring, ft 뒤 내용 모두 제거 (대소문자 구분없이)
        String removedFeat = title.replaceAll("(?i)\\s*(feat|featuring|ft)\\s*.*", "").trim();

        // 2) instrumental 포함하면 instrumental부터 뒷부분 제거
        String cleaned = removedFeat.replaceAll("(?i)\\s*instrumental.*", "").trim();

        return cleaned;
    }

    private String normalize(String input) {
        if (input == null)
            return "";
        String decoded = StringEscapeUtils.unescapeHtml4(input).toLowerCase();
        return decoded.replaceAll("[^a-z0-9가-힣぀-ゟ゠-ヿ一-龯\\s]", "").replaceAll("\\s+", " ").trim();
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
