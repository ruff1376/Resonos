package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.Qna;
import com.cosmus.resonos.domain.QnaAnswer;
import com.cosmus.resonos.service.QnaAnswerService;
import com.cosmus.resonos.service.QnaService;

@RestController
@RequestMapping("/admin/qna")
public class AdminQnAController {

    private final QnaService qnaService;
    private final QnaAnswerService qnaAnswerService;

    public AdminQnAController(QnaService qnaService, QnaAnswerService qnaAnswerService) {
        this.qnaService = qnaService;
        this.qnaAnswerService = qnaAnswerService;
    }

    // 모든 문의글 목록
    @GetMapping
    public ResponseEntity<List<Qna>> getAllQna() throws Exception {
        return ResponseEntity.ok(qnaService.list());
    }

    // 문의글 상세
    @GetMapping("/{id}")
    public ResponseEntity<Qna> getQna(@PathVariable Long id) throws Exception {
        Qna qna = qnaService.select(id);
        if (qna == null) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(qna);
    }

    // 답변 등록
    @PostMapping("/{qnaId}/answer")
    public ResponseEntity<String> createAnswer(@PathVariable Long qnaId, @RequestBody QnaAnswer answer) throws Exception {
        answer.setQnaId(qnaId);
        boolean success = qnaAnswerService.insert(answer);
        if (success) return ResponseEntity.ok("답변 등록 완료");
        return ResponseEntity.status(500).body("답변 등록 실패");
    }

    // 문의글 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteQna(@PathVariable Long id) throws Exception {
        boolean success = qnaService.delete(id);
        if (success) return ResponseEntity.ok("삭제 완료");
        return ResponseEntity.status(500).body("삭제 실패");
    }
}

