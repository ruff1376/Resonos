package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.AlbumReview;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Report;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.service.ReportService;
import com.cosmus.resonos.service.TrackReviewService;
import com.cosmus.resonos.service.AlbumReviewService;

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {

    @Autowired
    ReportService reportService;

    @GetMapping("")
    public String reportMain(
            @RequestParam(value = "tab", defaultValue = "all") String tab,
            @RequestParam(value = "page", defaultValue = "1") long page,
            @RequestParam(value = "size", defaultValue = "10") long size,
            Model model) throws Exception {

        // 각 탭별 전체 개수
        long totalAll = reportService.countAll();
        long totalPending = reportService.countByStatus("PENDING");
        long totalDone = reportService.countByStatus("DONE");
        long totalRejected = reportService.countByStatus("REJECTED");

        // 탭별 페이지 번호
        long allPage = 1, pendingPage = 1, donePage = 1;
        if ("pending".equals(tab)) pendingPage = page;
        else if ("done".equals(tab)) donePage = page;
        else allPage = page;

        // Pagination 객체 생성
        Pagination allPagination = new Pagination(allPage, size, 10, totalAll);
        Pagination pendingPagination = new Pagination(pendingPage, size, 10, totalPending);
        Pagination donePagination = new Pagination(donePage, size, 10, totalDone);
        Pagination rejectedPagination = new Pagination(donePage, size, 10, totalRejected);


        // 탭별 목록 조회
        List<Report> allReports = reportService.findAllPaging(allPagination);
        List<Report> pendingReports = reportService.findByStatusPaging("PENDING", pendingPagination);
        List<Report> doneReports = reportService.findByStatusPaging("DONE", donePagination);
        List<Report> rejectedReports = reportService.findByStatusPaging("REJECTED", donePagination);


        // 현재 탭에 맞는 목록/페이징만 전달
        List<Report> reports;
        Pagination pagination;
        String pageUri;
        switch (tab) {
            case "pending" -> {
                reports = pendingReports;
                pagination = pendingPagination;
                pageUri = "/admin/report?tab=pending&size=" + size;
            }
            case "done" -> {
                reports = doneReports;
                pagination = donePagination;
                pageUri = "/admin/report?tab=done&size=" + size;
            }
            case "rejected" -> {
                reports = rejectedReports;
                pagination = rejectedPagination;
            pageUri = "/admin/report?tab=rejected&size=" + size;
        }
            default -> {
                reports = allReports;
                pagination = allPagination;
                pageUri = "/admin/report?tab=all&size=" + size;
            }
        }

        model.addAttribute("reports", reports);
        model.addAttribute("pagination", pagination);
        model.addAttribute("pageUri", pageUri);
        model.addAttribute("tab", tab);
        model.addAttribute("size", size);
        model.addAttribute("totalAll", totalAll);
        model.addAttribute("totalPending", totalPending);
        model.addAttribute("totalDone", totalDone);
        model.addAttribute("totalRejected", totalRejected);

        return "admin/report";
    }

    // get방식, 상세, /detail?id=
    @GetMapping("/detail/{id}")
    public String reportDetail(@PathVariable Long id, Model model) throws Exception {
        Report report = reportService.select(id);
        model.addAttribute("report", report);
        return "admin/report";
    }
    


    // post방식, 삭제, /delete
    @PostMapping("/delete")
    public String reportDelete(
        Long id,
        @RequestParam(defaultValue = "all") String tab,
        @RequestParam(defaultValue = "1") long page,
        @RequestParam(defaultValue = "10") long size
    ) throws Exception {
        reportService.delete(id);
        return "redirect:/admin/report?tab=" + tab + "&page=" + page + "&size=" + size;
    }

    
    // 수정 
    @PostMapping("/updateStatus")
    public String updateStatus(
        Long id,
        String status,
        String processMemo,
        @RequestParam(defaultValue = "all") String tab,
        @RequestParam(defaultValue = "1") long page,
        @RequestParam(defaultValue = "10") long size,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        Long processedBy = (loginUser != null) ? loginUser.getUser().getId() : null;
        reportService.updateStatus(id, status, processedBy, processMemo);
        // 리다이렉트 시 파라미터 반영
        return "redirect:/admin/report?tab=" + tab + "&page=" + page + "&size=" + size;
    }

    




    // review 신고 처리 

    @Autowired
    private TrackReviewService trackReviewService;
    @Autowired
    private AlbumReviewService albumReviewService;

    // 리뷰 목록 (앨범/트랙)
    @GetMapping("/review")
    public String reviewList(
            @RequestParam(value = "type", defaultValue = "album") String type,
            @RequestParam(value = "page", defaultValue = "1") long page,
            @RequestParam(value = "size", defaultValue = "10") long size,
            Model model) throws Exception {

        if ("track".equalsIgnoreCase(type)) {
            long total = trackReviewService.countAll(); // 트랙 리뷰 전체 수 (필요시 구현)
            Pagination pagination = new Pagination(page, size, 10, total);
            List<TrackReview> reviews = trackReviewService.getMoreReviews(null, (int) page, (int) size);

            model.addAttribute("reviews", reviews);
            model.addAttribute("pagination", pagination);
            model.addAttribute("pageUri", "/admin/report/review?type=track&size=" + size);
            model.addAttribute("type", "track");
        } else {
            long total = albumReviewService.countAll(); // 앨범 리뷰 전체 수 (필요시 구현)
            Pagination pagination = new Pagination(page, size, 10, total);
            List<AlbumReview> reviews = albumReviewService.getMoreReviews(null, (int) page, (int) size);

            model.addAttribute("reviews", reviews);
            model.addAttribute("pagination", pagination);
            model.addAttribute("pageUri", "/admin/report/review?type=album&size=" + size);
            model.addAttribute("type", "album");
        }
        model.addAttribute("size", size);

        // 뷰 파일: templates/admin/review.html
        return "admin/review";
    }

    // 리뷰 상세
    @GetMapping("/review/{type}/{id}")
    public String reviewDetail(
            @PathVariable String type,
            @PathVariable Long id,
            Model model) {

        if ("track".equalsIgnoreCase(type)) {
            TrackReview review = trackReviewService.findById(id);
            if (review == null) {
                return "redirect:/admin/report/review?type=track&error=notfound";
            }
            model.addAttribute("review", review);
            model.addAttribute("type", "track");
        } else {
            AlbumReview review = albumReviewService.findById(id);
            if (review == null) {
                return "redirect:/admin/report/review?type=album&error=notfound";
            }
            model.addAttribute("review", review);
            model.addAttribute("type", "album");
        }
        // 뷰 파일: templates/admin/review_detail.html
        return "admin/review_detail";
    }

    // 블라인드/해제
    @PostMapping("/review/{type}/{id}/blind")
    public String blindReview(
            @PathVariable String type,
            @PathVariable Long id,
            @RequestParam boolean blinded) {

        if ("track".equalsIgnoreCase(type)) {
            trackReviewService.blindReview(id, blinded);
            return "redirect:/admin/report/review/track/" + id;
        } else {
            albumReviewService.blindReview(id, blinded);
            return "redirect:/admin/report/review/album/" + id;
        }
    }

    // 삭제
    @PostMapping("/review/{type}/{id}/delete")
    public String deleteReview(
            @PathVariable String type,
            @PathVariable Long id) {

        if ("track".equalsIgnoreCase(type)) {
            trackReviewService.delete(id);
            return "redirect:/admin/report/review?type=track";
        } else {
            albumReviewService.delete(id);
            return "redirect:/admin/report/review?type=album";
        }
    }

}
