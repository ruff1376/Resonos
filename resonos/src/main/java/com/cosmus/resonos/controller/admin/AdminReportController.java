package com.cosmus.resonos.controller.admin;

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
    public String reportDetail(@PathVariable("id") Long id, Model model) throws Exception {
        Report report = reportService.select(id);
        model.addAttribute("report", report);
        return "admin/report";
    }


@PostMapping("/delete")
public String reportDelete(
    @RequestParam("id") Long id,
    @RequestParam(value = "tab", defaultValue = "all") String tab,
    @RequestParam(value = "page", defaultValue = "1") long page,
    @RequestParam(value = "size", defaultValue = "10") long size
) throws Exception {
    reportService.delete(id);
    return "redirect:/admin/report?tab=" + tab + "&page=" + page + "&size=" + size;
}


@PostMapping("/updateStatus")
public String updateStatus(
    @RequestParam("id") Long id,
    @RequestParam("status") String status,
    @RequestParam(value = "processMemo", required = false) String processMemo,
    @RequestParam(value = "tab", defaultValue = "all") String tab,
    @RequestParam(value = "page", defaultValue = "1") long page,
    @RequestParam(value = "size", defaultValue = "10") long size,
    @AuthenticationPrincipal CustomUser loginUser
) throws Exception {
    Long processedBy = (loginUser != null) ? loginUser.getUser().getId() : null;
    reportService.updateStatus(id, status, processedBy, processMemo);
    return "redirect:/admin/report?tab=" + tab + "&page=" + page + "&size=" + size;
}








    // 리뷰 목록 ##############################
    @Autowired
    private TrackReviewService trackReviewService;
    @Autowired
    private AlbumReviewService albumReviewService;

     // 리뷰 목록 (앨범/트랙)
    @GetMapping("/review")
    public String reviewList(
            @RequestParam(value = "type", defaultValue = "album") String type,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            Model model) throws Exception {

        log.info("리뷰 목록 요청: type={}, page={}, size={}", type, page, size);

        long total;
        Pagination pagination;
        List<?> reviews;

        if ("track".equalsIgnoreCase(type)) {
            total = trackReviewService.countAll();
            reviews = trackReviewService.getMoreReviews(null, page, size);
            model.addAttribute("type", "track");
        } else {
            total = albumReviewService.countAll();
            reviews = albumReviewService.getMoreReviews(null, page, size);
            model.addAttribute("type", "album");
        }
        pagination = new Pagination(page, size, 10, total);

        model.addAttribute("reviews", reviews);
        model.addAttribute("pagination", pagination);
        model.addAttribute("pageUri", "/admin/report/review?type=" + type + "&size=" + size);
        model.addAttribute("size", size);

        return "admin/review";
    }


    // 블라인드/해제
    @PostMapping("/review/{type}/{id}/blind")
    public String blindReview(
            @PathVariable("type") String type,
            @PathVariable("id") Long id,
            @RequestParam("blinded") boolean blinded) {

        log.info("리뷰 블라인드 처리: type={}, id={}, blinded={}", type, id, blinded);

        if ("track".equalsIgnoreCase(type)) {
            trackReviewService.blindReview(id, blinded);
        } else {
            albumReviewService.blindReview(id, blinded);
        }
        return "redirect:/admin/report/review?type=" + type;
    }

    // 삭제
    @PostMapping("/review/{type}/{id}/delete")
    public String deleteReview(
            @PathVariable("type") String type,
            @PathVariable("id") Long id) {

        log.info("리뷰 삭제 요청: type={}, id={}", type, id);

        if ("track".equalsIgnoreCase(type)) {
            trackReviewService.delete(id);
        } else {
            albumReviewService.delete(id);
        }
        return "redirect:/admin/report/review?type=" + type;
    }


}
