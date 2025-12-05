package com.MokU.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MokU.service.ReportService;
import com.MokU.vo.MemberVO;
import com.MokU.vo.ReportVO;

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String status,
                       HttpSession session,
                       Model model) {

        // ✅ 관리자 세션 체크
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";   // 실제 로그인 URL 에 맞게 수정
        }
        if (!loginUser.isAdmin()) {            // 방금 VO 에 추가한 메서드
            return "redirect:/";               // 권한 없으면 메인으로 돌려보내기 등
        }

        List<ReportVO> reports = reportService.getReports(status);
        model.addAttribute("reports", reports);
        model.addAttribute("status", status);
        return "admin/reportList";
    }

    @PostMapping("/resolve")
    @ResponseBody
    public Map<String, Object> resolve(@RequestParam Integer reportId,
                                       HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        MemberVO admin = (MemberVO) session.getAttribute("loginUser");
        if (admin == null || !admin.isAdmin()) {
            result.put("status", "forbidden");
            return result;
        }

        reportService.changeReportStatus(reportId, "DONE", admin.getUserId());
        result.put("status", "success");
        return result;
    }
}

