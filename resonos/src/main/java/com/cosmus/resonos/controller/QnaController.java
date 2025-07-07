package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Qna;
import com.cosmus.resonos.service.QnaService;

@RestController
@RequestMapping("/counseling")
public class QnaController {

    private final QnaService qnaService;

    public QnaController(QnaService qnaService) {
        this.qnaService = qnaService;
    }


    // 화면 연결 community/qna
    @GetMapping("/qna")   
    public String qnaPage() {
        return "community/qna"; // 해당 경로에 JSP 파일이 있어야 합니다.
    }

    @GetMapping
    public ResponseEntity<List<Qna>> getAllQna() {
        try {
            List<Qna> qnaList = qnaService.list();
            return ResponseEntity.ok(qnaList);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Qna> getQna(@PathVariable Long id) {
        try {
            Qna qna = qnaService.select(id);
            if (qna == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(qna);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createQna(@RequestBody Qna qna) {
        try {
            boolean success = qnaService.insert(qna);
            if (success) {
                return ResponseEntity.ok("QnA created");
            }
            return ResponseEntity.status(500).body("Failed to create QnA");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create QnA: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateQna(@PathVariable Long id, @RequestBody Qna qna) {
        try {
            qna.setId(id);
            boolean success = qnaService.update(qna);
            if (success) {
                return ResponseEntity.ok("QnA updated");
            }
            return ResponseEntity.status(500).body("Failed to update QnA");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update QnA: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteQna(@PathVariable Long id) {
        try {
            boolean success = qnaService.delete(id);
            if (success) {
                return ResponseEntity.ok("QnA deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete QnA");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete QnA: " + e.getMessage());
        }
    }
}
