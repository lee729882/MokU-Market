package com.MokU.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.MokU.vo.ReportVO;

public interface ReportMapper {

    int insertReport(ReportVO vo);

    List<ReportVO> selectReports(@Param("status") String status);

    int updateReportStatus(ReportVO vo);
    int countProductReportByUser(@Param("reporterId") int reporterId,
            @Param("productId") int productId);
}
