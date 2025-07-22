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
            // 기존 제외 키워드
            "reaction", "리액션", "fanmade", "teaser", "remix", "mix", "loop", "cover", "커버", "edit",
            "fan cam", "직캠", "응원법", "응원", "가사", "소리만", "소리", "asmr",
            "instrumental", "inst", "highlight", "shorts", "short", "mv teaser", "피아노",
            "dance practice", "dance ver", "live", "뮤뱅", "뮤직뱅크", "인기가요", "쇼챔피언",
            "음중", "엠카", "음방", "방청", "선공개", "미공개", "뮤비해석", "vlog", "study", "study with me",
            "reaction mashup", "edit audio", "edit version", "first time", "my first time", "listening to",
            "react", "respond", "reacted", "i cried", "emotional", "review", "실사화", "mash", "mashup",

            // 다국어 리액션/반응 키워드
            "реакция", "реакция на", // 러시아어
            "reacción", "reaccionando", "mi reacción", "reacción", // 스페인어
            "réaction", "ma réaction", // 프랑스어
            "reaktion", "meine reaktion", // 독일어
            "reazione", "la mia reazione", // 이탈리아어
            "リアクション", "反応", // 일본어
            "반응", "실시간 반응", "리액션 영상", // 한국어 확장
            "watching for the first time", "my response", "responding");

    private static final List<String> OFFICIAL_CHANNEL_KEYWORDS = List.of(
            // 국내 플랫폼 및 유통사
            "official", "1thek", "stone music", "genie", "bugs", "melon",
            "smtown", "jyp", "yg", "big hit", "bighit", "hybe", "ador", "kq", "rbw", "cube",
            "wm", "starship", "pledis", "fantagio", "woollim", "brandnew", "mnh", "mbk",
            "c9", "top media", "swing entertainment", "beat interactive", "a team", "mld",
            "1million dance studio", "m2", "genie original", "jyp entertainment", "hybe labels",
            "smtown",
            // 국내 아티스트 개인 채널
            "iu official", "taeyeon official", "zico official", "jay park", "jessi official",
            "bts official", "blackpink", "twice official", "exo official", "red velvet official",
            "stray kids official", "itzy official", "got7 official", "seventeen official",
            "mamamoo official", "chung ha_official", "ive", "ROSÉ", "aespa", "stayc", "kepler", "g-idle",
            "ive official", "le sserafim", "newjeans official", "itzy", "twice",
            "dreamcatcher official", "loona", "taeyeon", "jessi official",
            "lee hi", "heize official", "bb girls", "viviz",
            "bts official", "exo", "nct", "nct dream", "nct 127", "super junior", "shinee",
            "taemin", "kai", "got7", "jackson wang", "stray kids", "the boyz", "ateez", "txt",
            "enhypen", "seventeen", "astro", "monsta x", "btob", "highlight",
            "jay park", "crush", "penomeco", "gray official", "loco official", "paul kim",
            "lee mujin", "baekhyun", "wonho", "kard",

            // 해외 메이저 레이블 및 배급사
            "sony music", "sony music korea", "워너뮤직코리아", "warner music", "warner music korea",
            "universal music", "universal music group", "universal music japan",
            "atlantic records", "columbia records", "capitol records", "interscope",
            "republic records", "rca records", "avex", "jstorm", "toho animation",
            "smej", "king records", "Sony Pictures Animation",

            // 글로벌 아티스트/뮤직 플랫폼/브랜드 채널
            "vevo", "avicii", "dua lipa", "coldplay", "shawn mendes", "beyoncé", "bruno mars",
            "doja cat", "billie eilish", "the weeknd", "drake", "eminem", "post malone",
            "t-series", "zee music company", "tips official", "trap nation", "monstercat",
            "no-copyright-sounds", "chill nation", "ukf", "colorsxstudios", "sofar sounds",
            "lyrical lemonade", "armada music", "bbc radio 1", "wave music", "ncs", "justin bieber",
            "monstercat uncaged", "epic music world", "Rihanna", "comfy music channel",
            "lofi hip hop", "colors – live sessions", "es sheeran", "lady gaga");

    private static final List<String> PRIORITY_TITLE_KEYWORDS = List.of(
            "official music video", "mv", "m/v", "performance video", "official performance",
            "official mv", "official", "studio choom", "relay dance");

    public String searchVideoId(String title, String artist) {
        if (apiKey == null || apiKey.isBlank()) {
            System.out.println("❗ API 키가 설정되지 않았습니다.");
            return null;
        }

        String cleanedTitle = cleanTitle(title);
        String normTitle = normalize(cleanedTitle);
        String normArtist = normalize(artist);

        List<String> fallbackQueries = new ArrayList<>();
        fallbackQueries.add(normArtist + " - " + normTitle + " mv");

        String extractedEng = extractEnglish(cleanedTitle);
        if (!extractedEng.isEmpty())
            fallbackQueries.add(normArtist + " " + extractedEng);

        String extractedKor = extractKorean(cleanedTitle);
        if (!extractedKor.isEmpty())
            fallbackQueries.add(normArtist + " " + extractedKor);

        String extractedJpn = extractJapanese(cleanedTitle);
        if (!extractedJpn.isEmpty())
            fallbackQueries.add(normArtist + " " + extractedJpn);

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
                    System.out.println("📦 검색 결과 총 " + items.size() + "개");

                    String bestVideoId = null;
                    int bestScore = Integer.MIN_VALUE;

                    for (JsonNode item : items) {
                        String videoId = item.get("id").get("videoId").asText();
                        String videoTitleRaw = item.get("snippet").get("title").asText();
                        String channelTitleRaw = item.get("snippet").get("channelTitle").asText();

                        String videoTitle = normalize(videoTitleRaw);
                        String channelTitle = normalize(channelTitleRaw);

                        boolean isOfficialChannel = OFFICIAL_CHANNEL_KEYWORDS.stream()
                                .anyMatch(keyword -> channelTitle.contains(normalize(keyword)));

                        if (!videoTitle.contains(normArtist) && !channelTitle.contains(normArtist)
                                && !isOfficialChannel) {
                            System.out.println("⛔ 제외된 영상: [" + videoTitleRaw + "] by [" + channelTitleRaw
                                    + "] → 이유: 아티스트명 미포함 (" + normArtist + ")");
                            continue;
                        }

                        int penalty = calculatePenalty(videoTitle);
                        if (penalty >= 10) {
                            System.out.println("⛔ 제외된 영상: [" + videoTitleRaw + "] by [" + channelTitleRaw
                                    + "] → 이유: penalty " + penalty);
                            continue;
                        }

                        int score = calculateScore(videoTitle, channelTitle, normTitle, normArtist) - penalty;

                        if (score > bestScore) {
                            bestScore = score;
                            bestVideoId = videoId;
                        }
                    }

                    if (bestVideoId != null) {
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

    private int calculatePenalty(String normalizedTitle) {
        for (String k : EXCLUDED_KEYWORDS) {
            if (normalizedTitle.contains(normalize(k))) {
                return 10;
            }
        }
        return 0;
    }

    private int calculateScore(String videoTitle, String channelTitle, String normTitle, String normArtist) {
        int score = 0;

        if (videoTitle.contains(normTitle))
            score += 2;
        if (videoTitle.contains(normArtist))
            score += 3;
        if (videoTitle.contains(normTitle) && videoTitle.contains(normArtist))
            score += 2; // 제목-아티스트 완전 포함시 보너스
            
        for (String priority : PRIORITY_TITLE_KEYWORDS) {
            if (videoTitle.contains(normalize(priority))) {
                score += 5;
                break;
            }
        }

        for (String official : OFFICIAL_CHANNEL_KEYWORDS) {
            if (channelTitle.contains(normalize(official))) {
                score += 15;
                break;
            }
        }

        return score;
    }

    private String cleanTitle(String title) {
        if (title == null)
            return "";

        // feat, featuring, ft 뒤 내용 제거
        String removedFeat = title.replaceAll("(?i)\\s*(feat|featuring|ft)\\s*.*", "").trim();

        // instrumental 포함시 그 뒤 제거
        return removedFeat.replaceAll("(?i)\\s*instrumental.*", "").trim();
    }

    // 키릴 문자 범위 추가: \u0400-\u04FF
    private String normalize(String input) {
        if (input == null)
            return "";
        String decoded = StringEscapeUtils.unescapeHtml4(input).toLowerCase();
        return decoded.replaceAll("[^a-z0-9가-힣ぁ-んァ-ン一-龯\u0400-\u04FF\\s]", "").replaceAll("\\s+", " ").trim();
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
