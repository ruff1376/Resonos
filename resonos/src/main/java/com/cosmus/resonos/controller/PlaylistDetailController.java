package com.cosmus.resonos.controller;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.service.PlaylistDetailService;
import com.cosmus.resonos.service.PlaylistService;

@RestController
@RequestMapping("/playlist-details")
public class PlaylistDetailController {

    @Autowired
    private PlaylistDetailService playlistDetailService;

    @Autowired
    private PlaylistService playlistService;


    @PostMapping(value = "/{id}", consumes = "application/json")
    public ResponseEntity<?> insertAjaxTracks(@RequestBody Map<String, List<String>> data, @PathVariable("id") Long id) {
        try {
            List<String> trackIdList = data.get("list");
            int maxOrderNo = playlistDetailService.getMaxOrderNo(id);

            if(trackIdList != null) {
                List<PlaylistDetail> trackList = new ArrayList<>();
                for (int i = 0; i < trackIdList.size(); i++) {
                    PlaylistDetail pd = new PlaylistDetail();
                    pd.setPlaylistId(id);
                    pd.setTrackId(trackIdList.get(i));
                    pd.setOrderNo(maxOrderNo + i + 1);
                    trackList.add(pd);
                }
                boolean result = playlistDetailService.insert(trackList);
                if(result) {
                    PlaylistDTO playlistDto = playlistService.trackOfPlaylist(id);

                    return new ResponseEntity<>(playlistDto, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("이미 플레이리스트에 있는 트랙입니다.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public ResponseEntity<List<PlaylistDetail>> getAllDetails() {
        try {
            List<PlaylistDetail> details = playlistDetailService.list();
            return ResponseEntity.ok(details);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlaylistDetail> getDetail(@PathVariable Long id) {
        try {
            PlaylistDetail detail = playlistDetailService.select(id);
            if (detail == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(detail);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateDetail(@PathVariable Long id, @RequestBody PlaylistDetail detail) {
        try {
            detail.setId(id);
            boolean success = playlistDetailService.update(detail);
            if (success) {
                return ResponseEntity.ok("Playlist detail updated");
            }
            return ResponseEntity.status(500).body("Failed to update playlist detail");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update playlist detail: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteDetail(@PathVariable Long id) {
        try {
            boolean success = playlistDetailService.delete(id);
            if (success) {
                return ResponseEntity.ok("Playlist detail deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete playlist detail");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete playlist detail: " + e.getMessage());
        }
    }
}
