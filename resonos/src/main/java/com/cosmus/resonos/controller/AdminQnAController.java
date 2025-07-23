package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Qna;
import com.cosmus.resonos.domain.QnaAnswer;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.QnaAnswerService;
import com.cosmus.resonos.service.QnaService;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.QnaAnswer;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/admin/qna")
public class AdminQnAController {

    @Autowired
    private QnaService qnaService;
    @Autowired
    private QnaAnswerService qnaAnswerService;


    @GetMapping
    public String listQnaTabs(Model model, @RequestParam(value = "qnaId", required = false) Long qnaId) throws Exception {

        // 전체 문의 리스트
        List<Qna> allQnaList = qnaService.list();

        // 답변이 존재하는 문의
        List<Qna> answeredQnaList = qnaService.listAnswered();   // 서비스단에서 구현 필요

        // 답변이 없는 문의
        List<Qna> noAnswerQnaList = qnaService.listNoAnswer();    // 서비스단에서 구현 필요

        model.addAttribute("allQnaList", allQnaList);
        model.addAttribute("answeredQnaList", answeredQnaList);
        model.addAttribute("noAnswerQnaList", noAnswerQnaList);

        // 선택된 QnA 상세 - 필요시 qnaId로 상세 데이터 로드
        Qna currentQna = null;
        if (qnaId != null) {
            currentQna = qnaService.select(qnaId);
        }
        if (currentQna == null && !allQnaList.isEmpty()) {
            currentQna = allQnaList.get(0);
        }
        model.addAttribute("currentQna", currentQna);

        // 선택 질문 관련 답변
        if (currentQna != null) {
            List<QnaAnswer> answers = qnaAnswerService.findByQnaId(currentQna.getId());
            model.addAttribute("answers", answers);
        }

        model.addAttribute("answerForm", new QnaAnswer());
        return "admin/qna";
    }
    @PostMapping("/{qnaId}/answer")
    public String createAnswer(@PathVariable("qnaId") Long qnaId,
                            @Validated @ModelAttribute("answerForm") QnaAnswer answer,
                            BindingResult result,
                            @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (result.hasErrors()) {
            return "redirect:/admin/qna?qnaId=" + qnaId;
        }
        answer.setQnaId(qnaId);

        if (loginUser == null) {
            throw new IllegalStateException("인증정보가 없습니다.");
        }
        answer.setAdminId(loginUser.getUser().getId());  // CustomUser 내 실제 Users 도메인 참조 구조에 맞게 조정

        qnaAnswerService.insert(answer);
        return "redirect:/admin/qna?qnaId=" + qnaId;
    }

    @PostMapping("/answer/{answerId}/edit")
    public String updateAnswer(@PathVariable("answerId") Long answerId,
                            @Validated @ModelAttribute("answerForm") QnaAnswer answer,
                            BindingResult result,
                            @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (result.hasErrors()) {
            return "redirect:/admin/qna?qnaId=" + answer.getQnaId();
        }
        answer.setId(answerId);

        if (loginUser == null) {
            throw new IllegalStateException("인증정보가 없습니다.");
        }
        answer.setAdminId(loginUser.getUser().getId());

        qnaAnswerService.update(answer);
        return "redirect:/admin/qna?qnaId=" + answer.getQnaId();
    }


    // 답변 삭제 처리
    @PostMapping("/answer/{answerId}/delete")
    public String deleteAnswer(@PathVariable("answerId") Long answerId) throws Exception {
        QnaAnswer answer = qnaAnswerService.select(answerId);
        if (answer != null) {
            qnaAnswerService.delete(answerId);
            return "redirect:/admin/qna?qnaId=" + answer.getQnaId();
        }
        return "redirect:/admin/qna";
    }

    // 질문 삭제 처리
    @PostMapping("/{id}/delete")
    public String deleteQna(@PathVariable Long id) throws Exception {
        qnaService.delete(id);
        return "redirect:/admin/qna";
    }
}
