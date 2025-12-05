package com.MokU.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MokU.dao.ReportDAO;
import com.MokU.vo.ReportVO;

@Service("reportService")   // 이름까지 명시해 두면 컨트롤러에서 찾기 편합니다.
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportDAO reportDAO;

    /** 신고 저장 (상품 상세에서 “신고하기” 눌렀을 때 호출) */
    @Override
    public void saveReport(ReportVO vo) {
        reportDAO.insertReport(vo);
    }

    /** 상태별 신고 목록 조회 (관리자용 리스트) */
    @Override
    public List<ReportVO> getReports(String status) {
        return reportDAO.selectReports(status);
    }

    /** 신고 처리 상태 변경 (DONE, IN_PROGRESS 등) */
    @Override
    public void changeReportStatus(Integer reportId, String status, Integer adminUserId) {
        ReportVO vo = new ReportVO();
        vo.setReportId(reportId);
        vo.setStatus(status);
        vo.setProcessedBy(adminUserId);
        reportDAO.updateReportStatus(vo);
    }
    @Override
    public boolean hasReportedProduct(int reporterId, int productId) {
        int cnt = reportDAO.countProductReportByUser(reporterId, productId);
        return cnt > 0;
    }
}
