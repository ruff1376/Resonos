package com.cosmus.resonos.controller.admin;

import com.cosmus.resonos.domain.admin.QnaAnswer;
import com.cosmus.resonos.domain.user.Qna;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.service.admin.QnaAnswerService;
import com.cosmus.resonos.service.user.QnaService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/qna")
public class AdminQnAController {

    @Autowired
    private QnaService qnaService;

    @Autowired
    private QnaAnswerService qnaAnswerService;

    /** QnA 목록 조회 (전체, 답변있음, 없음 포함) */
    @GetMapping
    public Map<String, Object> listQnaTabs(
            @RequestParam(name = "qnaId", required = false) Long qnaId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Qna> allQnaList = qnaService.list();
            List<Qna> answeredQnaList = qnaService.listAnswered();
            List<Qna> noAnswerQnaList = qnaService.listNoAnswer();

            result.put("success", true);
            result.put("allQnaList", allQnaList);
            result.put("answeredQnaList", answeredQnaList);
            result.put("noAnswerQnaList", noAnswerQnaList);

            // 선택된 QnA
            Qna currentQna = null;
            if (qnaId != null) {
                currentQna = qnaService.select(qnaId);
            }
            if (currentQna == null && !allQnaList.isEmpty()) {
                currentQna = allQnaList.get(0);
            }
            result.put("currentQna", currentQna);

            // 선택 QnA 답변
            if (currentQna != null) {
                List<QnaAnswer> answers = qnaAnswerService.findByQnaId(currentQna.getId());
                result.put("answers", answers);
            }

        } catch (Exception e) {
            log.error("QnA 목록 조회 실패", e);
            result.put("success", false);
            result.put("message", "QnA 목록 조회 중 오류");
        }
        return result;
    }

    /** QnA 답변 등록 */
    @PostMapping("/{qnaId}/answer")
    public Map<String, Object> createAnswer(
            @PathVariable(name = "qnaId") Long qnaId,
            @RequestBody Map<String, Object> payload,
            @AuthenticationPrincipal CustomUser loginUser) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (loginUser == null) {
                throw new IllegalStateException("인증정보가 없습니다.");
            }
            QnaAnswer answer = new QnaAnswer();
            answer.setQnaId(qnaId);
            answer.setContent((String) payload.get("content"));
            answer.setAdminId(loginUser.getUser().getId());

            qnaAnswerService.insert(answer);
            result.put("success", true);
            result.put("answer", answer);
        } catch (Exception e) {
            log.error("QnA 답변 등록 실패", e);
            result.put("success", false);
            result.put("message", "답변 등록 중 오류");
        }
        return result;
    }

    /** QnA 답변 수정 */
    @PutMapping("/answer/{answerId}")
    public Map<String, Object> updateAnswer(
            @PathVariable(name = "answerId") Long answerId,
            @RequestBody Map<String, Object> payload,
            @AuthenticationPrincipal CustomUser loginUser) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (loginUser == null) {
                throw new IllegalStateException("인증정보가 없습니다.");
            }
            QnaAnswer answer = new QnaAnswer();
            answer.setId(answerId);
            answer.setQnaId(Long.valueOf(payload.get("qnaId").toString()));
            answer.setContent((String) payload.get("content"));
            answer.setAdminId(loginUser.getUser().getId());

            qnaAnswerService.update(answer);
            result.put("success", true);
            result.put("answer", answer);
        } catch (Exception e) {
            log.error("QnA 답변 수정 실패", e);
            result.put("success", false);
            result.put("message", "답변 수정 중 오류");
        }
        return result;
    }

    /** QnA 답변 삭제 */
    @DeleteMapping("/answer/{answerId}")
    public Map<String, Object> deleteAnswer(@PathVariable(name = "answerId") Long answerId) {
        Map<String, Object> result = new HashMap<>();
        try {
            QnaAnswer answer = qnaAnswerService.select(answerId);
            if (answer != null) {
                qnaAnswerService.delete(answerId);
                result.put("success", true);
                result.put("qnaId", answer.getQnaId());
            } else {
                result.put("success", false);
                result.put("message", "답변을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            log.error("QnA 답변 삭제 실패", e);
            result.put("success", false);
            result.put("message", "답변 삭제 중 오류");
        }
        return result;
    }

    /** QnA 질문 삭제 */
    @DeleteMapping("/{id}")
    public Map<String, Object> deleteQna(@PathVariable(name = "id") Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            qnaService.delete(id);
            result.put("success", true);
        } catch (Exception e) {
            log.error("QnA 삭제 실패", e);
            result.put("success", false);
            result.put("message", "질문 삭제 중 오류");
        }
        return result;
    }
}
