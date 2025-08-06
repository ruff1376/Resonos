package com.cosmus.resonos.util;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.cosmus.resonos.domain.user.GenreCount;

public class FlattenGenreCounts {

  public static Map<String, Integer> execute(List<GenreCount> rawList) {
    Map<String, Integer> genreCountMap = new HashMap<>();

    for (GenreCount item : rawList) {
      String[] genres = item.getGenres().split(",");
      int count = item.getCount();

      for (String genre : genres) {
          genre = genre.trim();
          genreCountMap.put(genre, genreCountMap.getOrDefault(genre, 0) + count);
      }
    }

    return genreCountMap.entrySet().stream()
      .sorted((a, b) -> b.getValue().compareTo(a.getValue()))
      .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
          (e1, e2) -> e1,
          LinkedHashMap::new
      ));
  }
}
