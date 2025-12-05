package com.MokU.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.MokU.mapper.ReportMapper;
import com.MokU.vo.ReportVO;

@Repository
public class ReportDAO {

    @Autowired
    private ReportMapper reportMapper;   // 🔹 SqlSession 대신 Mapper 인터페이스 주입

    public int insertReport(ReportVO vo) {
        return reportMapper.insertReport(vo);
    }

    public List<ReportVO> selectReports(String status) {
        return reportMapper.selectReports(status);
    }

    public int updateReportStatus(ReportVO vo) {
        return reportMapper.updateReportStatus(vo);
    }
    public int countProductReportByUser(int reporterId, int productId) {
        return reportMapper.countProductReportByUser(reporterId, productId);
    }
}
