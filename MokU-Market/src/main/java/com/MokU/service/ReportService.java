package com.MokU.service;

import java.util.List;

import com.MokU.vo.ReportVO;

public interface ReportService {
    void saveReport(ReportVO vo);
    List<ReportVO> getReports(String status);
    void changeReportStatus(Integer reportId, String status, Integer adminUserId);
    boolean hasReportedProduct(int reporterId, int productId);

}

