package com.cosmus.resonos.controller.admin;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.community.Report;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.service.admin.ReportService;
import com.cosmus.resonos.service.review.AlbumReviewService;
import com.cosmus.resonos.service.review.TrackReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/report")
public class AdminReportRestController {

    @Autowired
    private ReportService reportService;

    @Autowired
    private TrackReviewService trackReviewService;

    @Autowired
    private AlbumReviewService albumReviewService;

    // --- Reports 리스트 조회 (탭별) ---
    @GetMapping("")
    public ResponseEntity<?> getReports(
            @RequestParam(value = "tab", defaultValue = "all") String tab,
            @RequestParam(value = "page", defaultValue = "1") long page,
            @RequestParam(value = "size", defaultValue = "10") long size) {

        try {
            // 각 탭별 전체 개수
            long totalAll = reportService.countAll();
            long totalPending = reportService.countByStatus("PENDING");
            long totalDone = reportService.countByStatus("DONE");
            long totalRejected = reportService.countByStatus("REJECTED");

            // 탭별 페이지 번호 설정
            long allPage = 1, pendingPage = 1, donePage = 1, rejectedPage = 1;
            if ("pending".equals(tab)) pendingPage = page;
            else if ("done".equals(tab)) donePage = page;
            else if ("rejected".equals(tab)) rejectedPage = page;
            else allPage = page;

            Pagination allPagination = new Pagination(allPage, size, 10, totalAll);
            Pagination pendingPagination = new Pagination(pendingPage, size, 10, totalPending);
            Pagination donePagination = new Pagination(donePage, size, 10, totalDone);
            Pagination rejectedPagination = new Pagination(rejectedPage, size, 10, totalRejected);

            // 해당 탭에 따른 데이터 조회
            List<Report> reports;
            Pagination pagination;
            switch (tab.toLowerCase()) {
                case "pending":
                    reports = reportService.findByStatusPaging("PENDING", pendingPagination);
                    pagination = pendingPagination;
                    break;
                case "done":
                    reports = reportService.findByStatusPaging("DONE", donePagination);
                    pagination = donePagination;
                    break;
                case "rejected":
                    reports = reportService.findByStatusPaging("REJECTED", rejectedPagination);
                    pagination = rejectedPagination;
                    break;
                default:
                    reports = reportService.findAllPaging(allPagination);
                    pagination = allPagination;
                    break;
            }

            // 응답용 데이터 구성
            Map<String, Object> response = new HashMap<>();
            response.put("reports", reports);
            response.put("pagination", pagination);
            response.put("tab", tab);
            response.put("totals", Map.of(
                    "all", totalAll,
                    "pending", totalPending,
                    "done", totalDone,
                    "rejected", totalRejected
            ));

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("리포트 목록 조회 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리포트 목록 조회 실패"));
        }
    }

    // --- Report 상세 조회 ---
    @GetMapping("/{id}")
    public ResponseEntity<?> getReportDetail(@PathVariable("id") Long id) {
        try {
            Report report = reportService.select(id);
            if (report == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "해당 리포트를 찾을 수 없습니다."));
            }
            return ResponseEntity.ok(report);
        } catch (Exception e) {
            log.error("리포트 상세 조회 실패 (id: {})", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리포트 상세 조회 실패"));
        }
    }

    // --- Report 삭제 ---
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteReport(@PathVariable("id") Long id) {
        try {
            reportService.delete(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("리포트 삭제 실패 (id: {})", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리포트 삭제 실패"));
        }
    }

    // --- Report 상태 업데이트 ---
    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateReportStatus(
            @PathVariable("id") Long id,
            @RequestParam("status") String status,
            @RequestParam(value = "processMemo", required = false) String processMemo,
            @AuthenticationPrincipal CustomUser loginUser) {

        try {
            Long processedBy = (loginUser != null) ? loginUser.getUser().getId() : null;
            reportService.updateStatus(id, status, processedBy, processMemo);
            return ResponseEntity.ok(Map.of("message", "상태가 업데이트되었습니다."));
        } catch (Exception e) {
            log.error("리포트 상태 업데이트 실패 (id: {})", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리포트 상태 업데이트 실패"));
        }
    }

    // --- 리뷰 목록 조회 (앨범 or 트랙) ---
    @GetMapping("/review")
    public ResponseEntity<?> getReviewList(
            @RequestParam(value = "type", defaultValue = "album") String type,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {

        try {
            long total;
            List<?> reviews;

            if ("track".equalsIgnoreCase(type)) {
                total = trackReviewService.countAll();
                reviews = trackReviewService.getMoreReviews(null, page, size);
            } else {
                total = albumReviewService.countAll();
                reviews = albumReviewService.getMoreReviews(null, page, size);
            }

            Pagination pagination = new Pagination(page, size, 10, total);

            Map<String, Object> response = new HashMap<>();
            response.put("type", type.toLowerCase());
            response.put("reviews", reviews);
            response.put("pagination", pagination);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("리뷰 목록 조회 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리뷰 목록 조회 실패"));
        }
    }


    // --- 리뷰 블라인드 처리 ---
    @PutMapping("/review/{type}/{id}/blind")
    public ResponseEntity<?> blindReview(
            @PathVariable("type") String type,
            @PathVariable("id") Long id,
            @RequestParam("blinded") boolean blinded) {

        try {
            if ("track".equalsIgnoreCase(type)) {
                trackReviewService.blindReview(id, blinded);
            } else {
                albumReviewService.blindReview(id, blinded);
            }
            return ResponseEntity.ok(Map.of("message", "블라인드 상태가 변경되었습니다."));
        } catch (Exception e) {
            log.error("리뷰 블라인드 처리 실패 type={}, id={}", type, id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리뷰 블라인드 처리 실패"));
        }
    }

    // --- 리뷰 삭제 ---
    @DeleteMapping("/review/{type}/{id}")
    public ResponseEntity<?> deleteReview(
            @PathVariable("type") String type,
            @PathVariable("id") Long id) {

        try {
            if ("track".equalsIgnoreCase(type)) {
                trackReviewService.delete(id);
            } else {
                albumReviewService.delete(id);
            }
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("리뷰 삭제 실패 type={}, id={}", type, id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "리뷰 삭제 실패"));
        }
    }

}
