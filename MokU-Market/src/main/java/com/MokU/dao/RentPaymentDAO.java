package com.MokU.dao;

import java.util.List;
import com.MokU.vo.RentPaymentVO;

public interface RentPaymentDAO {

    int getNextPaymentId();

    void insertPayment(RentPaymentVO vo);

    List<RentPaymentVO> getPaymentsByBuyer(String buyerName);
}
