package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.QnaAnswer;
import com.cosmus.resonos.service.QnaAnswerService;

@RestController
@RequestMapping("/qna-answers")
public class QnaAnswerController {

    private final QnaAnswerService qnaAnswerService;

    public QnaAnswerController(QnaAnswerService qnaAnswerService) {
        this.qnaAnswerService = qnaAnswerService;
    }

    @GetMapping
    public ResponseEntity<List<QnaAnswer>> getAllAnswers() {
        try {
            List<QnaAnswer> answers = qnaAnswerService.list();
            return ResponseEntity.ok(answers);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<QnaAnswer> getAnswer(@PathVariable Long id) {
        try {
            QnaAnswer answer = qnaAnswerService.select(id);
            if (answer == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(answer);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/qna/{qnaId}")
    public ResponseEntity<List<QnaAnswer>> getAnswersByQnaId(@PathVariable Long qnaId) {
        try {
            List<QnaAnswer> answers = qnaAnswerService.findByQnaId(qnaId);
            return ResponseEntity.ok(answers);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createAnswer(@RequestBody QnaAnswer answer) {
        try {
            boolean success = qnaAnswerService.insert(answer);
            if (success) {
                return ResponseEntity.ok("QnA answer created");
            }
            return ResponseEntity.status(500).body("Failed to create QnA answer");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create QnA answer: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateAnswer(@PathVariable Long id, @RequestBody QnaAnswer answer) {
        try {
            answer.setId(id);
            boolean success = qnaAnswerService.update(answer);
            if (success) {
                return ResponseEntity.ok("QnA answer updated");
            }
            return ResponseEntity.status(500).body("Failed to update QnA answer");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update QnA answer: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAnswer(@PathVariable Long id) {
        try {
            boolean success = qnaAnswerService.delete(id);
            if (success) {
                return ResponseEntity.ok("QnA answer deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete QnA answer");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete QnA answer: " + e.getMessage());
        }
    }
}
